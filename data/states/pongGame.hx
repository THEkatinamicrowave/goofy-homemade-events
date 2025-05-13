//
import funkin.backend.utils.CoolUtil;

var score:Int = 0;
var scoreText:Alphabet;

var ball:HealthIcon;

var borders:FlxGroup;
var ceil:FlxSprite;
var floor:FlxSprite;

var paddles:FlxGroup;
var paddle1:FlxSprite;
var paddle2:FlxSprite;

function create() {
    scoreText = new Alphabet(0, 0, score, true);
    scoreText.screenCenter();

    ball = new HealthIcon("dad");
    ball.scale.set(0.3, 0.3);
    ball.updateHitbox();
    ball.screenCenter();
    ball.elasticity = 1;
    ball.moves = true;
    
    borders = new FlxGroup();
    add(borders);

    ceil = new FlxSprite().loadGraphic(Paths.image("game/healthbar"));
    ceil.setGraphicSize(FlxG.width, 20);
    ceil.updateHitbox();
    ceil.screenCenter();
    ceil.y = -ceil.height/2;
    ceil.immovable = true;

    floor = new FlxSprite().loadGraphic(Paths.image("game/healthbar"));
    floor.setGraphicSize(FlxG.width, 20);
    floor.updateHitbox();
    floor.screenCenter();
    floor.y = FlxG.height - floor.height/2;
    floor.immovable = true;
    
    paddles = new FlxGroup();
    add(paddles);

    paddle1 = new FlxSprite().loadGraphic(Paths.image("game/coolBar"));
    paddle1.setGraphicSize(20, 75);
    paddle1.updateHitbox();
    paddle1.screenCenter();
    paddle1.x = 120;
    paddle1.immovable = true;
    paddle1.color = 0xFFFF0000;

    paddle2 = new FlxSprite().loadGraphic(Paths.image("game/coolBar"));
    paddle2.setGraphicSize(20, 75);
    paddle2.updateHitbox();
    paddle2.screenCenter();
    paddle2.x = FlxG.width - paddle2.width - 120;
    paddle2.immovable = true;
    paddle2.color = 0xFF00FF00;

    add(scoreText);
    add(ball);
    borders.add(ceil);
    borders.add(floor);
    paddles.add(paddle1);
    paddles.add(paddle2);

    reset();
}

function update(elapsed:Float) {
    movePaddle((controls.UP && paddle2.y > ceil.y + ceil.height ? -1 : 0) + (controls.DOWN && paddle2.y + paddle2.height < floor.y ? 1 : 0));
    ball.velocity.set(ball.velocity.x + (ball.velocity.x < 0 ? -60*elapsed : 60*elapsed), ball.velocity.y + (ball.velocity.y < 0 ? -60*elapsed : 60*elapsed));

    // AI JUMPSCARE
    paddle1.velocity.y = (ball.y < paddle1.y + paddle1.height / 2 && paddle1.y > ceil.y + ceil.height) ? -700 : ((ball.y > paddle1.y + paddle1.height / 2 && paddle1.y + paddle1.height < floor.y) ? 700 : 0);

    if (controls.BACK) {
        CoolUtil.playMenuSFX(2);
        FlxG.switchState(new MainMenuState());
    }

    FlxG.collide(ball, borders);
    FlxG.collide(ball, paddles);

    if (ball.x < -ball.width) {
        score += 1;
        scoreText.text = score;
        reset();
    } else if (ball.x > FlxG.width) {
        if (score != 0) score -= 1;
        scoreText.text = score;
        reset();
    }
}

function movePaddle(dir:Int)
    paddle2.velocity.y = dir * 700;

function reset() {
    ball.screenCenter();
    ball.velocity.set(-400, 400);
    paddle1.screenCenter(FlxAxes.Y);
    paddle2.screenCenter(FlxAxes.Y);
}