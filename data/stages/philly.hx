//
var shittyTrain:FlxSprite;
var trainBWAAAAAAAAAAAA:FlxSound;

function postCreate() {
    shittyTrain = new FlxSprite().loadGraphic(Paths.image("stages/philly/train"));
    shittyTrain.flipX = true;
    shittyTrain.scale.set(2.3, 2.3);
    shittyTrain.updateHitbox();
    shittyTrain.setPosition(-14000, 40);
    add(shittyTrain);

    trainBWAAAAAAAAAAAA = FlxG.sound.load(Paths.sound("fuckingtrainhorn"));
}

function beatHit(beat:Int) {
    if (Math.random() * 10000 == 69) {
        trainKillsBF();
    }
}

function trainKillsBF() {
    trace("rip bozo");
    
    trainBWAAAAAAAAAAAA.play();
    FlxTween.tween(shittyTrain, {x: boyfriend.x - shittyTrain.width + boyfriend.width}, 1, { onComplete: function() {
		persistentUpdate = false;
		persistentDraw = false;
		paused = true;

        gameOver();
        trainBWAAAAAAAAAAAA.stop();
    }});
}