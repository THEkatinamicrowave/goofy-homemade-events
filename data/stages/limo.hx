//
var fastCarCanDrive:Bool = true;

var bloodShader:CustomShader;
var bell:FlxSound;
var textdddd:Alphabet;

var moonActive:Bool = false;
var moonChance:Int = 0;

function create() {
	resetFastCar();

    bloodShader = new CustomShader("bloodmoon");
    bell = FlxG.sound.load(Paths.sound("bloodmoon"));
	
	textdddd = new Alphabet(0, 100, "The Blood Moon is here.", true);
	textdddd.color = FlxColor.RED;
	textdddd.screenCenter(FlxAxes.X);
	textdddd.cameras = [camHUD];
	textdddd.visible = false;
	add(textdddd);
}

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
            FlxTween.tween(guy, {x: (130 + (370 * i)) - 120 * dir, y: 80, "skew.x": 30 * dir, "scale.x": 1, "scale.y": 1}, 15 / Conductor.bpm, {
                ease: FlxEase.circOut,
                onComplete: () -> FlxTween.tween(guy, {x: (130 + (370 * i)), y: 180, "skew.x": 0, "scale.x": 1.5, "scale.y": 0.5}, 45 / Conductor.bpm,
                    {ease: FlxEase.backInOut})
            });
        }
	}

	moonChance = Math.round(Math.random() * Math.ceil((inst.length / 1000) * (Conductor.bpm / 60)) * 10);

    if (!moonActive)
		if (moonChance == 0)
			bloodMoon();
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

function bloodMoon() {
	moonActive = true;

    FlxTween.tween(inst, {pitch: 0}, 4, { ease: FlxEase.sineInOut, onComplete: function() {
        inst.stop();
    }});
    FlxTween.tween(vocals, {pitch: 0}, 4, { ease: FlxEase.sineInOut, onComplete: function() {
        vocals.stop();
    }});
    
    FlxTween.tween(camHUD, { angle: -10, y: 100, alpha: 0 }, 5, { ease: FlxEase.cubeOut, onComplete: function() {
        for (obj in [healthBar, healthBarBG, iconP1, iconP2, strumLines, scoreTxt, missesTxt, accuracyTxt]) remove(obj);
        camHUD.alpha = 1;
		camHUD.angle = 0;
		camHUD.y = 0;

        new FlxTimer().start(1, bloodAfterTimer);
    }});
}

function bloodAfterTimer() {
    for (obj in [boyfriend, dad, gf, dancer1, dancer2, dancer3, dancer4, dancer5, bgLimo, limo]) obj.shader = bloodShader;
    remove(overlayShit);
    skyBG.loadGraphic(Paths.image("stages/limo/limoBloodmoon"));

    bell.play();

	new FlxTimer().start(2, function(tmr:FlxTimer) {
		textdddd.visible = true;
	});

	new FlxTimer().start(5, function(tmr:FlxTimer) {
		gameOver();
	});
}