//
var girlsPos:FlxPoint = FlxPoint.get(-100, 190);

function beatHit(beat:Int) {
	var dir:Int = switch (beat % 2) {
		case 0:
			-1;
		case 1:
			1;
	}

	FlxTween.tween(bgGirls, {y: girlsPos.y - 100}, 30 / Conductor.bpm, {
		ease: FlxEase.circOut,
		onComplete: () -> FlxTween.tween(bgGirls, {y: girlsPos.y + 100}, 30 / Conductor.bpm,
			{ease: FlxEase.circIn})
	});

	FlxTween.tween(bgGirls, {x: girlsPos.x, "skew.x": 0}, 30 / Conductor.bpm, {
		ease: FlxEase.sineOut,
		onComplete: () -> FlxTween.tween(bgGirls, {x: girlsPos.x - 70 * dir, "skew.x": 30 * dir}, 30 / Conductor.bpm,
			{ease: FlxEase.sineIn})
	});
}
