//
function onSelectItem(event:NameEvent)
    if (event.name == "pong") FlxG.switchState(new ModState("pongGame"));