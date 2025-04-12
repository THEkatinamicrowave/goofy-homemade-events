//
var girlsPos:FlxPoint = FlxPoint.get(-100, 190);

var senpaiLeft:FlxSound;
var senpaiDown:FlxSound;
var senpaiUp:FlxSound;
var senpaiRight:FlxSound;
var senpaiFUCKINDICK:FlxSound;

var soundArray:Array<FlxSound>;

function create() {
	if (PlayState.SONG.meta.name.toLowerCase() == "roses") {
		bgGirls.animation.remove("danceLeft");
		bgGirls.animation.remove("danceRight");
		bgGirls.animation.addByIndices('danceLeft', 'BG fangirls dissuaded', CoolUtil.numberArray(14), "", 24, false);
		bgGirls.animation.addByIndices('danceRight', 'BG fangirls dissuaded', CoolUtil.numberArray(30, 15), "", 24, false);
	}
	bgGirls.animation.play("danceLeft", true); // horrible fix, please fix later

	senpaiLeft = FlxG.sound.load(Paths.sound("senpaiBITCH"));
	senpaiDown = FlxG.sound.load(Paths.sound("senpaiPUSSY"));
	senpaiUp = FlxG.sound.load(Paths.sound("senpaiFUCK"));
	senpaiRight = FlxG.sound.load(Paths.sound("senpaiSHIT"));
	senpaiFUCKINDICK = FlxG.sound.load(Paths.sound("fuckin-dick"));

	soundArray = [senpaiLeft, senpaiDown, senpaiUp, senpaiRight];
}

function onNoteHit(event:NoteHitEvent) {
	if (PlayState.SONG.meta.name.toLowerCase() == "roses") {
		if (event.note.strumLine.data.type == 0) {
			vocals.volume = 0;
			event.preventVocalsUnmute();
		
			if (!event.note.isSustainNote) {
				for (sound in soundArray) {
					sound.stop();
					soundArray[event.direction].play();
				}
			}
		}

		if (strumLines.members[0].notes.members.length + strumLines.members[1].notes.members.length == 2) {
			senpaiFUCKINDICK.play();
		}
	}
}

function beatHit(beat:Int) {
	if (beat >= 0) {
		var dir:Int = switch (beat % 2) {
			case 0: -1;
			case 1: 1;
		}
	
		FlxTween.tween(bgGirls, {y: girlsPos.y - 100}, 30 / Conductor.bpm, {
			ease: FlxEase.circOut,
			onComplete: () -> FlxTween.tween(bgGirls, {y: girlsPos.y + 100}, 30 / Conductor.bpm,
				{ease: FlxEase.circIn})
		});
	
		FlxTween.tween(bgGirls, {x: girlsPos.x, "skew.x": 0}, 30 / Conductor.bpm, {
			ease: FlxEase.linear,
			onComplete: () -> FlxTween.tween(bgGirls, {x: girlsPos.x - 120 * dir, "skew.x": 30 * dir}, 30 / Conductor.bpm,
				{ease: FlxEase.linear})
		});
	}
}
