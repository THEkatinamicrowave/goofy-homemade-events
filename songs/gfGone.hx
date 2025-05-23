//
var killGF:Float = 999;

function postCreate() {
    killGF = FlxG.random.int(0, 50);

    if (killGF == 0) {
        if (gf != null) remove(gf);
        inst.volume = 0;
    }
}