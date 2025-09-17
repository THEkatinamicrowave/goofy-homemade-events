//
function onCountdown(event:CountdownEvent) {
    if (dad.curCharacter == "spooky") for (strum in get_cpu().members) strum.scrollSpeed = 15;
}

function postUpdate(elapsed:Float) {
    if (strumLines.members[curCameraTarget] == get_cpu()) {
        var newNote:Note = new Note(get_cpu(), {time: inst.time + 100, id: FlxG.random.int(0, 3), type: 0, sLen: 0}, false, 0, 0);

        get_cpu().notes.addNotes([newNote]);
    }
}