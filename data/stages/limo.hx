//
var fastCarCanDrive:Bool = true;

function create()
	resetFastCar();

function update(elapsed:Float)
{
	if (!fastCarCanDrive && fastCar.x > 2000) {
		resetFastCar();
		fastCarCanDrive = true;
	}

	var offset = Math.sin(curBeatFloat / 4) * Math.cos(curBeatFloat / 16) * 85;

	// back limo drive
	if (Options.lowMemoryMode) {
		bgLimo.frameOffset.x = offset;
	} else {
		for(e in [bgLimo, dancer1, dancer2, dancer3, dancer4, dancer5]) {
			e.frameOffset.x = offset;
		}
	}
}
function beatHit(curBeat:Int) {
	if (FlxG.random.bool(10) && fastCarCanDrive)
		fastCarDrive();

    if (curBeat >= 0) {
		var dir:Int = switch (curBeat % 2) {
			case 0: -1;
			case 1: 1;
		}
	
		for (i=>guy in [dancer1, dancer2, dancer3, dancer4, dancer5]) {
            FlxTween.tween(guy, {y: guysPos.y - 100}, 30 / Conductor.bpm, {
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
}

function resetFastCar()
{
	fastCar.x = -12600;
	fastCar.y = FlxG.random.int(140, 250);
	fastCar.velocity.x = 0;
	fastCar.moves = false;
	fastCarCanDrive = true;
}
function fastCarDrive()
{
	FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

	fastCar.velocity.x = FlxG.random.int(170, 220) * 60 * 3;
	fastCar.moves = true;
	fastCarCanDrive = false;
}