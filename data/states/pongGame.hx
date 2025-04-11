//
var canMove:Bool = true;

var ball:HealthIcon;

var borders:FlxGroup;
var ceil:FlxSprite;
var floor:FlxSprite;

var paddles:FlxGroup;
var paddle1:FlxSprite;
var paddle2:FlxSprite;

var score:Int = 0;
var scoreText:Alphabet;

function create() {
    borders = new FlxGroup();
    add(borders);
    
    paddles = new FlxGroup();
    add(paddles);
    
    ball = new HealthIcon("dad");
    ball.scale.set(0.3, 0.3);
    ball.updateHitbox();
    ball.screenCenter();
    ball.velocity.set(-700, 700);
    ball.elasticity = 1;

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

    scoreText = new Alphabet(0, 0, score, true);
    scoreText.scale.set(2, 2);
    scoreText.screenCenter();

    add(ball);
    borders.add(ceil);
    borders.add(floor);
    paddles.add(paddle1);
    paddles.add(paddle2);
    add(scoreText);
}

function update(elapsed:Float) {
    if (canMove) {
        movePaddle((controls.UP && paddle1.y > ceil.y + ceil.height ? -1 : 0) + (controls.DOWN && paddle1.y + paddle1.height < floor.y ? 1 : 0));
    }

    // AI JUMPSCARE
    if (ball.y < paddle1.y + paddle1.height / 2 && paddle1.y > ceil.y + ceil.height) {
        paddle1.velocity.y = -700;
    } else if (ball.y > paddle1.y + paddle1.height / 2 && paddle1.y + paddle1.height < floor.y) {
        paddle1.velocity.y = 700;
    } else {
        paddle1.velocity.y = 0;
    }

    if (controls.BACK) {
        CoolUtil.playMenuSFX(2);
        FlxG.switchState(new MainMenuState());
    }

    FlxG.collide(ball, borders);
    FlxG.collide(ball, paddles);

    if (ball.x < -ball.width) {
        score += 1;
        updateScoreText();
        reset();
    } else if (ball.x > FlxG.width) {
        if (score != 0) score -= 1;
        updateScoreText();
        reset();
    }
}

function movePaddle(dir:Int) {
    paddle2.velocity.y = dir * 700;
}

function updateScoreText() {
    scoreText.text = score;
    scoreText.scale.set(2, 2);
}

function reset() {
    ball.screenCenter();
    ball.velocity.set(-700, 700);
    paddle1.screenCenter(FlxAxes.Y);
    paddle2.screenCenter(FlxAxes.Y);
}