//
import flixel.FlxObject;

var dadPos:FlxObject;
var gfPos:FlxObject;
var bfPos:FlxObject;

var dadScale:FlxPoint;
var gfScale:FlxPoint;
var bfScale:FlxPoint;

function postCreate() {
    dadPos = new FlxObject(dad.x, dad.y);
    gfPos = new FlxObject(gf.x, gf.y);
    bfPos = new FlxObject(boyfriend.x, boyfriend.y);

    dadScale = FlxPoint.get(dad.scale.x, dad.scale.y);
    gfScale = FlxPoint.get(gf.scale.x, gf.scale.y);
    bfScale = FlxPoint.get(boyfriend.scale.x, boyfriend.scale.y);

    for (pos in [dadPos, gfPos, bfPos])
        add(pos);
}

function postUpdate(elapsed:Float) {
    if (Conductor.songPosition > 0) {
        for (strum in strumLines.members) {
            var propPos:FlxObject = switch (strum.data.type) {
                case 0: dadPos;
                case 1: bfPos;
                case 2: gfPos;
            };
            var propScale:FlxPoint = switch (strum.data.type) {
                case 0: dadScale;
                case 1: bfScale;
                case 2: gfScale;
            };
    
            for (c in strum.characters) {
                c.scale.set(CoolUtil.fpsLerp(c.scale.x, propScale.x, 0.1), CoolUtil.fpsLerp(c.scale.y, propScale.y, 0.1));
                c.skew.set(CoolUtil.fpsLerp(c.skew.x, 0, 0.1), CoolUtil.fpsLerp(c.skew.y, 0, 0.1));
    
                c.setPosition(CoolUtil.fpsLerp(c.x, propPos.x, 0.15), CoolUtil.fpsLerp(c.y, propPos.y, 0.15));
            }
        }
    }
}

function onNoteHit(event:NoteHitEvent) {
    var propPos:FlxObject = switch (event.note.strumLine.data.type) {
        case 0: dadPos;
        case 1: bfPos;
        case 2: gfPos;
    };
    var propScale:FlxPoint = switch (event.note.strumLine.data.type) {
        case 0: dadScale;
        case 1: bfScale;
        case 2: gfScale;
    };

    if (!event.note.isSustainNote) {
        switch (event.note.strumID) {
            case 0:
                event.character.skew.set(50, 0);
                event.character.scale.set(propScale.x, propScale.y);
                event.character.setPosition(propPos.x - ((Math.sin(4 * Math.PI / 18) / Math.sin(5 * Math.PI / 18)) * event.character.height * propScale.x), propPos.y);
            case 1:
                event.character.skew.set(0, 0);
                event.character.scale.set(propScale.x * 2, propScale.y * 0.5);
                event.character.setPosition(propPos.x, propPos.y + (propScale.y * event.character.height / 4));
            case 2:
                event.character.skew.set(0, 0);
                event.character.scale.set(propScale.x * 0.5, propScale.y * 2);
                event.character.setPosition(propPos.x, propPos.y - (propScale.y * event.character.height / 2));
            case 3:
                event.character.skew.set(-50, 0);
                event.character.scale.set(propScale.x, propScale.y);
                event.character.setPosition(propPos.x + ((Math.sin(4 * Math.PI / 18) / Math.sin(5 * Math.PI / 18)) * event.character.height * propScale.x), propPos.y);
        }
    }
}

function onPlayerMiss(event:NoteMissEvent) {
    event.character.skew.set((Math.random() * 178) - 89, (Math.random() * 178) - 89);
}
