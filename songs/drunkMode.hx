//
var newpitch:Float = 1;

var blackout:Bool = false;

var dronk1:CustomShader;
var dronk2:CustomShader;
var dronk3:CustomShader;
var chromatic:CustomShader;
var vignette:CustomShader;

function postCreate() {
    for (shader in [dronk1, dronk2, dronk3]) {
        shader = new CustomShader("engine/editorBlur");
        shader.strength = 10;
    }

    chromatic = new CustomShader("chromaticAberration");
    chromatic.redOff = [0.005, 0];
    chromatic.greenOff = [-0.005, 0];
    chromatic.blueOff = [-0.005, 0];

    vignette = new CustomShader("coloredVignette");
    vignette.color = [0, 0, 0];
    vignette.amount = 1;
	vignette.strength = 3;

    if (FlxG.save.data.goobermod_drunkmode) {
        for (shader in [dronk1, dronk2, dronk3, chromatic]) for (cam in [camGame, camHUD]) cam.addShader(shader);
        camGame.addShader(vignette);
    }
}

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

function measureHit(measure:Int) {
    if (FlxG.save.data.goobermod_drunkmode) {
        if (Math.round(Math.random() * 50) == 1) {
            blackout = true;
            camGame.fade(FlxColor.BLACK, 0.5, FlxG.resetState());
        }
    }
}

function postUpdate(elapsed:Float) {
    if (FlxG.save.data.goobermod_drunkmode) {
        inst.pitch = vocals.pitch = CoolUtil.fpsLerp(inst.pitch, newpitch, 0.16);
        scrollSpeed = CoolUtil.fpsLerp(scrollSpeed, SONG.scrollSpeed * (1/newpitch), 0.08);

        if (!blackout) {
            vignette.strength = CoolUtil.fpsLerp(vignette.strength, 3 + Math.random() * 3, 0.5);
        } else {
            vignette.strength = CoolUtil.fpsLerp(vignette.strength, 70, 0.2);
            inst.volume = vocals.volume = CoolUtil.fpsLerp(inst.volume, 0, 0.2);
        }
    }
}