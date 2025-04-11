//
function onSelectItem(event:NameEvent)
    switch event.name {
        case "pong": FlxG.switchState(new ModState("pongGame"));
    }