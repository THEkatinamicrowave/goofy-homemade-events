//
import hxvlc.flixel.FlxVideoSprite;
import haxe.io.Path;

var adStartTimer:FunkinText;
var isTimerStarted = false;
var adStartFlxTimer:FlxTimer;

var adBank = Paths.getFolderContent("videos/ads");

var ad:FlxVideoSprite;
var skipText:FunkinText;
var adSkipFlxTimer:FlxTimer;
var canSkip = false;

function postCreate() {
    adStartTimer = new FunkinText(0, 15, FlxG.width - 15, "", 36);
    adStartTimer.alignment = "right";
    adStartTimer.cameras = [camHUD];
    add(adStartTimer);

    adStartFlxTimer = new FlxTimer();
    adSkipFlxTimer = new FlxTimer();

    ad = new FlxVideoSprite();
    ad.antialiasing = true;
    ad.bitmap.onFormatSetup.add(function() {
        if (ad.bitmap != null && ad.bitmap.bitmapData != null) {
            ad.setGraphicSize(FlxG.width, FlxG.height);
            ad.updateHitbox();
            ad.screenCenter();
        }
    });
    ad.bitmap.onEndReached.add(ad.destroy);
    ad.cameras = [camHUD];
    ad.visible = false;
    add(ad);

    skipText = new FunkinText(0, 15, FlxG.width - 15, "", 36);
    skipText.alignment = "right";
    skipText.cameras = [camHUD];
    skipText.screenCenter(FlxAxes.Y);
    add(skipText);
}

function postUpdate(elapsed:Float) {
    adStartTimer.text = adStartFlxTimer.active ? "Ads in " + Math.ceil(adStartFlxTimer.timeLeft) : "";
    skipText.text = ad.visible ? (canSkip ? "Press [ACCEPT] to skip" : "Skip in " + Math.ceil(adSkipFlxTimer.timeLeft)) : "";

    if (controls.ACCEPT && canSkip) {
        resetAll();
}

function beatHit(beat:Int)
    if (!isTimerStarted && Math.round(Math.random() * 5) == 0) {
        isTimerStarted = true;
        adStartFlxTimer.start(5, ()->doAdShit());
    }

function doAdShit() {
    canPause = false;

    inst.pause();
    vocals.pause();
    for (s in strumLines.members) s.vocals.pause();

    ad.visible = true;
    if (ad.load(Paths.video("ads/" + Path.withoutExtension(adBank[Math.round(Math.random() * (adBank.length-1))])))) {
        ad.visible = true;
        new FlxTimer().start(0.001, ()->ad.play());
        adSkipFlxTimer.start(5, ()->{canSkip = true;});
    } else resetAll();
}

function resetAll() {
    canPause = true;
    isTimerStarted = false;

    inst.resume();
    vocals.resume();
    for (s in strumLines.members) s.vocals.resume();

    canSkip = false;
    ad.stop();
    ad.visible = false;
}