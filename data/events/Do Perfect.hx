//
var forcePerfect:Bool = false;

function onEvent(event:EventGameEvent) {
	if (event.event.name == "Do Perfect") {
		var value = event.event.params[0];
		trace(value);
		forcePerfect = value;
	}
}

function onPlayerHit(event:NoteHitEvent) {
	if (forcePerfect == true) {
		event.accuracy = 1;
		event.rating = "sick";
		event.showSplash = true;

		trace("the sickening");
	}
}

function onPlayerMiss(event:NoteMissEvent) {
	if (forcePerfect == true) {
        misses = misses - 1;
        songScore = songScore + 20;
        health = health + 0.1;

        event.animSuffix = "";
		event.gfSad = false;
		event.accuracy = 1;

		event.preventMissSound();
		event.preventResetCombo();
		event.preventVocalsMute();
	}
}
