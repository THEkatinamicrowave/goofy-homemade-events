//
import flixel.FlxObject;

var dadPos:FlxObject;
var bfPos:FlxObject;
var gfPos:FlxObject;

var dadScale:FlxPoint;
var bfScale:FlxPoint;
var gfScale:FlxPoint;

function postCreate() {
    if (dad != null) {
        dadPos = new FlxObject(dad.x, dad.y);
        dadScale = FlxPoint.get(dad.scale.x, dad.scale.y);
    }

    if (boyfriend != null) {
        bfPos = new FlxObject(boyfriend.x, boyfriend.y);
        bfScale = FlxPoint.get(boyfriend.scale.x, boyfriend.scale.y);
    }

    if (gf != null) {
        gfPos = new FlxObject(gf.x, gf.y);
        gfScale = FlxPoint.get(gf.scale.x, gf.scale.y);
    }

    for (pos in [dadPos, gfPos, bfPos]) if (pos != null) add(pos);
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
                if (c.animation.name == "idle" || c.animation.name == "danceLeft" || c.animation.name == "danceRight")
                    scaleSkewSprite(c, propPos, propScale, 0, propScale.x, propScale.y);
                else
                    scaleSkewSprite(c, propPos, propScale, CoolUtil.fpsLerp(c.skew.x, 0, 0.16), CoolUtil.fpsLerp(c.scale.x, propScale.x, 0.16), CoolUtil.fpsLerp(c.scale.y, propScale.y, 0.16));
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
            case 0: scaleSkewSprite(event.character, propPos, propScale, 60, propScale.x, propScale.y);
            case 1: scaleSkewSprite(event.character, propPos, propScale, 0, propScale.x * 2, propScale.y * 0.5);
            case 2: scaleSkewSprite(event.character, propPos, propScale, 0, propScale.x * 0.5, propScale.y * 1.5);
            case 3: scaleSkewSprite(event.character, propPos, propScale, -60, propScale.x, propScale.y);
        }
    }
}

function scaleSkewSprite(sprite:FlxSprite, sPos:FlxPoint, sScale:FlxPoint, skew:Float, scaleX:Float, scaleY:Float) {
    sprite.scale.set(scaleX, scaleY);
    sprite.skew.set(skew, 0);
    sprite.setPosition(
        sPos.x - (sScale.x * sprite.height * Math.tan(skew * Math.PI / 180)) / 2,
        sPos.y + (sScale.y * sprite.height * (sScale.y - scaleY) / (sScale.y * 2))
    );
}

function onPlayerMiss(event:NoteMissEvent) {
    event.character.skew.set((Math.random() * 178) - 89, (Math.random() * 178) - 89);
}
