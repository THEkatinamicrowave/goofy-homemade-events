//
var FUCK:FlxSound;

function postCreate() {
    FUCK = FlxG.sound.load(Paths.sound("senpaiFUCK"));
    FUCK.volume = 3;
}

function onNoteHit(event:NoteHitEvent) {
    if (event.noteType == "FUCK note") {
        vocals.volume = 0;
        event.preventVocalsUnmute();

        FUCK.play();
    }
}