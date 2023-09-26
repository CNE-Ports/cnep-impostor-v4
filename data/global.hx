import funkin.backend.scripting.Script;

var redirectStates:Map<FlxState, String> = [
    MainMenuState => "impostor/MainMenu",
];

var logsScript:Script = Script.create(Paths.script("data/modules/LogsOverlay"));
logsScript.load();
logsScript.call("create", []);

function preStateSwitch() {
    for(redirectState in redirectStates.keys()) {
        if(Std.isOfType(FlxG.game._requestedState, redirectState)) 
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
    }
}

function postStateSwitch() {
    logsScript.call("postStateSwitch", []);
}

function postUpdate(delta:Float) {
    if(FlxG.keys.justPressed.F5)
        FlxG.resetState();
    
    if(FlxG.keys.justPressed.F6)
        logsScript.call("toggle", []);

    logsScript.call("update", [delta]);
}

function onDestroy() {
    logsScript.call("onDestroy", []);
    logsScript.destroy();
}
