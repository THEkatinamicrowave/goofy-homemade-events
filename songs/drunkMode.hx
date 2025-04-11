//
var newpitch:Float = 1;

function onNoteHit(event:NoteHitEvent) {
    if (FlxG.save.data.goobermod_drunkmode) {
        if (!event.note.isSustainNote) {
            newpitch = 0.75 + Math.random() * 0.5;
    
            FlxTween.cancelTweensOf(event.note.strumLine.members[event.direction]);
            event.note.strumLine.members[event.direction].angle = 0;
            
            FlxTween.tween(event.note.strumLine.members[event.direction], { angle: 360 }, 0.5, { ease: FlxEase.quartOut });
        }
    }
}

function postUpdate(elapsed:Float) {
    if (FlxG.save.data.goobermod_drunkmode) {
        inst.pitch = vocals.pitch = CoolUtil.fpsLerp(inst.pitch, newpitch, 0.16);
        scrollSpeed = CoolUtil.fpsLerp(scrollSpeed, SONG.scrollSpeed * (1/newpitch), 0.08);
    }
}