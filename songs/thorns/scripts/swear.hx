//
var senpaiLeft:FlxSound;
var senpaiDown:FlxSound;
var senpaiUp:FlxSound;
var senpaiRight:FlxSound;

var soundArray:Array<FlxSound>;

function postCreate() {
	senpaiLeft = FlxG.sound.load(Paths.sound("senpaiBITCH"));
	senpaiDown = FlxG.sound.load(Paths.sound("senpaiPUSSY"));
	senpaiUp = FlxG.sound.load(Paths.sound("senpaiFUCK"));
	senpaiRight = FlxG.sound.load(Paths.sound("senpaiSHIT"));
    
	soundArray = [senpaiLeft, senpaiDown, senpaiUp, senpaiRight];
}

function onNoteHit(event:NoteHitEvent) {
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
}