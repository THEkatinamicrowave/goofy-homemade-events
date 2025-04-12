//
var gay:CustomShader;
var hue:Float = 0;

function postCreate() {
    gay = new CustomShader("gay");

    if (FlxG.save.data.goobermod_gaymode) for (cam in [camGame, camHUD]) cam.addShader(gay);
}

function postUpdate(elapsed:Float) {
    hue = FlxMath.wrap(100 * (hue + 2*elapsed), 0, 1000) / 100;
    gay.hue = hue;
}