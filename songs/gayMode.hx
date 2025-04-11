//
var gay:CustomShader;
var hue:Float = 0;

function postCreate() {
    gay = new CustomShader("gay");

    if (FlxG.save.data.goobermod_gaymode) {
        camGame.addShader(gay);
        camHUD.addShader(gay);
    }
}

function postUpdate(elapsed:Float) {
    hue = FlxMath.wrap(100 * (hue + 2*elapsed), 0, 1000) / 100;
    gay.hue = hue;
}