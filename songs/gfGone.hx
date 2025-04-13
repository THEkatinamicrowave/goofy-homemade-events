//
var killGF:Float = 999;

function postCreate() {
    killGF = Math.round(Math.random() * 50);

    if (killGF == 0) {
        if (gf != null) remove(gf);
        inst.volume = 0;
    }
}