//
import funkin.game.PlayState;

// phillyTrain is automatically added by Stage.hx

var curColor:Int = 0;
var trainSound:FlxSound;
var colors = [
	0xFF31A2FD,
	0xFF31FD8C,
	0xFFFB33F5,
	0xFFFD4531,
	0xFFFBA633
];
var trainMoving:Bool = false;
var trainFrameTiming:Float = 0;
var trainCars:Int = 8;
var trainFinishing:Bool = false;
var trainCooldown:Int = 0;

var shittyTrain:FlxSprite;
var trainBWAAAAAAAAAAAA:FlxSound;
var trainRand:Int;

function create() {
	// defaultCamZoom = 0.5;
	phillyTrain.moves = true;  // Def value false in funkinsprite
	light.color = colors[curColor];
	trainSound = FlxG.sound.load(Paths.sound("train_passes"));
}

function postCreate() {
    shittyTrain = new FlxSprite().loadGraphic(Paths.image("stages/philly/train"));
    shittyTrain.flipX = true;
    shittyTrain.scale.set(2.3, 2.3);
    shittyTrain.updateHitbox();
    shittyTrain.setPosition(-14000, 40);
    add(shittyTrain);

    trainBWAAAAAAAAAAAA = FlxG.sound.load(Paths.sound("fuckingtrainhorn"));
	trainBWAAAAAAAAAAAA.volume = 5;
}

function beatHit(curBeat:Int) {
	if (curBeat % 4 == 0) {
		// switches color
		var newColor = FlxG.random.int(0, colors.length-2);
		if (newColor >= curColor) newColor++;
		curColor = newColor;
		light.color = colors[curColor];
	}

	if (!trainMoving)
		trainCooldown += 1;

	if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8 && !trainSound.playing)
	{
		trainCooldown = FlxG.random.int(-4, 0);
		trainStart();
	}

	if (curBeat >= 0) {
		trainRand = Math.round(Math.random() * Math.ceil((inst.length / 1000) * (Conductor.bpm / 60)));
		if (trainRand == 1) trainKillsBF();
	}
}

function update(elapsed:Float) {
	if (Conductor.songPosition > 0)
		light.alpha = 1 - (FlxEase.cubeIn((curBeatFloat / 4) % 1) * 0.85);
	else
		light.alpha = 0;

	if (trainMoving) {
		updateTrainPos();
	}
}

function trainStart():Void
{
	trainMoving = true;
	if (!trainSound.playing)
		trainSound.play(true);
}

var startedMoving:Bool = false;

function updateTrainPos():Void
{
	if (trainSound.time >= 4700)
	{
		startedMoving = true;
		gf.playAnim('hairBlow');
	}

	if (startedMoving)
	{
		phillyTrain.velocity.x = -400 * 24;
		if (phillyTrain.x < -2000 && !trainFinishing)
		{
			phillyTrain.x = -1150;
			trainCars -= 1;

			if (trainCars <= 0)
				trainFinishing = true;
		}

		if (phillyTrain.x < -4000 && trainFinishing)
			trainReset();
	}
}

function trainReset():Void
{
	gf.playAnim('hairFall', true);
	phillyTrain.x = FlxG.width + 200;
	trainMoving = false;
	// trainSound.stop();
	// trainSound.time = 0;
	trainCars = 8;
	trainFinishing = false;
	startedMoving = false;
	phillyTrain.velocity.x = 0;
}

function trainKillsBF() {
    trainBWAAAAAAAAAAAA.play();
    FlxTween.tween(shittyTrain, {x: boyfriend.x - shittyTrain.width + boyfriend.width}, 1, { onComplete: function() {
		persistentUpdate = false;
		persistentDraw = false;
		paused = true;

        gameOver();
        trainBWAAAAAAAAAAAA.stop();
    }});
}