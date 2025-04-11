//
var topPos:FlxPoint = FlxPoint.get(-400, -60);
var bottomPos:FlxPoint = FlxPoint.get(-297, 120);



function beatHit(beat:Int) {
	if (beat >= 0) {
		var dir:Int = switch (beat % 2) {
			case 0:
				-1;
			case 1:
				1;
		}
	
		FlxTween.tween(bottomBoppers, {y: bottomPos.y - 100}, 30 / Conductor.bpm, {
			ease: FlxEase.circOut,
			onComplete: () -> FlxTween.tween(bottomBoppers, {y: bottomPos.y + 100}, 30 / Conductor.bpm,
				{ease: FlxEase.circIn})
		});
	
		FlxTween.tween(bottomBoppers, {x: bottomPos.x, "skew.x": 0}, 30 / Conductor.bpm, {
			ease: FlxEase.linear,
			onComplete: () -> FlxTween.tween(bottomBoppers, {x: bottomPos.x - 140 * dir, "skew.x": 30 * dir}, 30 / Conductor.bpm,
				{ease: FlxEase.linear})
		});

        FlxTween.tween(upperBoppers, {y: topPos.y - 25}, 30 / Conductor.bpm, {
			ease: FlxEase.circOut,
			onComplete: () -> FlxTween.tween(upperBoppers, {y: topPos.y + 100}, 30 / Conductor.bpm,
				{ease: FlxEase.circIn})
		});
	
		FlxTween.tween(upperBoppers, {x: topPos.x, "skew.x": 0}, 30 / Conductor.bpm, {
			ease: FlxEase.linear,
			onComplete: () -> FlxTween.tween(upperBoppers, {x: topPos.x - 30 * dir, "skew.x": -15 * dir}, 30 / Conductor.bpm,
				{ease: FlxEase.linear})
		});
	}
}
