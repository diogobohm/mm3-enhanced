part of escape;

class Game extends Sprite {
    static const num CANVAS_WIDTH = 512;
    static const num CANVAS_HEIGHT = 448;
    static const num _GAME_LOOP_TIME = 0;

    /*
  InfoBox _infoBox;
  SimpleButton _shuffleButton;
  SimpleButton _exitButton;
  Board _board;
  TimeGauge _timeGauge;
  Alarm _alarm;
  TextField _pointsTextField;
  TextField _shufflesTextField;

  int _level;
  int _lives;
  int _shuffles;
  int _chainCount;
  int _points;

  Sprite _gameLayer;
  Sprite _messageLayer;
  Sprite _exitLayer;

  Sound _introSound;
  SoundChannel _introSoundChannel;
  */

    ResourceManager _resourceManager;
    Juggler _juggler;

    bool leftKeyPressed;
    bool rightKeyPressed;
    bool downKeyPressed;
    bool upKeyPressed;
    bool jumpKeyPressed;
    bool shootKeyPressed;

    SceneManager _sceneManager;
    Megaman _megaman;
    TopManMap _topManMap;
    StageArea _currentStageArea;

    List<Character> _characterList;

    num _currentTime;

    MovementSpeed _gravitySpeed = new MovementSpeed(40);

    //---------------------------------------------------------------------------------------------------
    Game(ResourceManager resourceManager, Juggler juggler) {

        _resourceManager = resourceManager;
        _juggler = juggler;
        _currentTime = _juggler.elapsedTime;

        _topManMap = new TopManMap(_resourceManager);
        _currentStageArea = _topManMap.getSprite();

        _megaman = new Megaman(_resourceManager);
        _megaman.x = _currentStageArea.getStartXPos();
        _megaman.y = 0;
        _megaman.setTeleportingDown();

        _characterList = new List<Character>();
        _characterList.add(_megaman);

        _sceneManager = new SceneManager(juggler, CANVAS_WIDTH, CANVAS_HEIGHT);
        _sceneManager.addToScene(_currentStageArea);
        _sceneManager.addToScene(_megaman);
        addChild(_sceneManager);

        /*
        Bitmap shuffleButtonNormal = new Bitmap(_resourceManager.getBitmapData("ShuffleButtonNormal"));
        Bitmap shuffleButtonPressed = new Bitmap(_resourceManager.getBitmapData("ShuffleButtonPressed"));

        _shuffleButton = new SimpleButton(shuffleButtonNormal, shuffleButtonNormal, shuffleButtonPressed, shuffleButtonPressed);
        _shuffleButton.addEventListener(MouseEvent.CLICK, _onShuffleButtonClick);
        _shuffleButton.x = 530;
        _shuffleButton.y = 525;
        addChild(_shuffleButton);

        Bitmap exitButtonNormal = new Bitmap(_resourceManager.getBitmapData("ExitButtonNormal"));
        Bitmap exitButtonPressed = new Bitmap(_resourceManager.getBitmapData("ExitButtonPressed"));

        _exitButton = new SimpleButton(exitButtonNormal, exitButtonNormal, exitButtonPressed, exitButtonPressed);
        _exitButton.addEventListener(MouseEvent.CLICK, _onExitButtonClick);
        _exitButton.x = 700;
        _exitButton.y = 500;
        addChild(_exitButton);

        _infoBox = new InfoBox(_resourceManager, _juggler);
        _infoBox.x = 540;
        _infoBox.y = -1000;
        addChild(_infoBox);

        _timeGauge = new TimeGauge(10, _resourceManager.getBitmapData("TimeGauge"), Gauge.DIRECTION_UP);
        _timeGauge.x = 659;
        _timeGauge.y = 244;
        _timeGauge.addEventListener("TimeShort", _onTimeShort);
        _timeGauge.addEventListener("TimeOver", _onTimeOver);
        addChild(_timeGauge);
        _juggler.add(_timeGauge);

        _alarm = new Alarm(_resourceManager, _juggler);
        _alarm.x = 665;
        _alarm.y = 160;
        addChild(_alarm);

        //-------------------------------

        _pointsTextField = new TextField();
        _pointsTextField.defaultTextFormat = new TextFormat("Arial", 30, 0xD0D0D0, bold:true, align:TextFormatAlign.CENTER);
        _pointsTextField.width = 140;
        _pointsTextField.height = 36;
        _pointsTextField.wordWrap = false;
        //_pointsTextField.selectable = false;
        _pointsTextField.x = 646;
        _pointsTextField.y = 130;
        //_pointsTextField.filters = [new GlowFilter(0x000000, 1.0, 2, 2)];
        _pointsTextField.mouseEnabled = false;
        _pointsTextField.text = "0";
        _pointsTextField.scaleX = 0.9;
        addChild(_pointsTextField);

        //-------------------------------

        _shufflesTextField = new TextField();
        _shufflesTextField.defaultTextFormat = new TextFormat("Arial", 20, 0xFFFFFF, bold:true, align:TextFormatAlign.CENTER);
        _shufflesTextField.width = 44;
        _shufflesTextField.height = 30;
        _shufflesTextField.wordWrap = false;
        //_shufflesTextField.selectable = false;
        _shufflesTextField.x = 610;
        _shufflesTextField.y = 559;
        _shufflesTextField.mouseEnabled = false;
        _shufflesTextField.text = "3x";
        addChild(_shufflesTextField);

        //-------------------------------

        _gameLayer = new Sprite();
        addChild(_gameLayer);

        _messageLayer = new Sprite();
        addChild(_messageLayer);

        _exitLayer = new Sprite();
        addChild(_exitLayer);

        //-------------------------------

        _introSound = _resourceManager.getSound("Intro");
        _introSoundChannel = _introSound.play();
        */
    }

  //---------------------------------------------------------------------------------------------------
  //---------------------------------------------------------------------------------------------------

    void start() {

        leftKeyPressed = false;
        rightKeyPressed = false;
        downKeyPressed = false;
        upKeyPressed = false;
        jumpKeyPressed = false;
        shootKeyPressed = false;

        _juggler.delayCall(() => gameLoop(), _GAME_LOOP_TIME);

        /*
        //MessageBox messageBox  = new MessageBox(_resourceManager, _juggler, _resourceManager.getText("ESCStartText"));
        //_messageLayer.addChild(messageBox);

        //messageBox.show(() => _juggler.delayCall(() => _nextLevel(), 0.5));
         */
    }

    void gameLoop() {
        num newTime = _juggler.elapsedTime;
        num elapsedTime = newTime - _currentTime;
        _currentTime = newTime;

        if (leftKeyPressed) {
            print("LeftKey");
            _megaman.leftKeyEvent();
            _megaman.toRightForce -= _megaman.getWalkSpeed().getMovedPixels(elapsedTime);

        } else if (rightKeyPressed) {
            print("RightKey");
            _megaman.rightKeyEvent();
            _megaman.toRightForce += _megaman.getWalkSpeed().getMovedPixels(elapsedTime);

        } else {
            _megaman.noDirectionKeyEvent();
        }

        if (jumpKeyPressed) {
            if (downKeyPressed) {
                if (_megaman.slideKeyEvent()) {
                    print("Slide");
                    if (_megaman.isToRight()) {
                        _megaman.toRightForce += _megaman.getSlideSpeed().getMovedPixels(elapsedTime);
                    } else {
                        _megaman.toRightForce -= _megaman.getSlideSpeed().getMovedPixels(elapsedTime);
                    }
                }
            } else {
                if (_megaman.jumpKeyEvent()) {
                    print("Jump");

                    //_megaman.toDownForce -= _megaman.getJumpSpeed().getMovedPixels(elapsedTime);
                    _megaman.toDownForce -= 3;
                }
            }
        } else {
            _megaman.noJumpKeyEvent();
        }

        if (shootKeyPressed) {
            if (_megaman.shootKeyEvent()) {
                _sceneManager.addToScene(_megaman.getLastProjectile());
            }
        }

        for (Character character in _characterList) {

            if (character.isTeleporting()) {
                if (character.isTeleportingDown()) {
                    if (character.y >= _currentStageArea.getStartYPos()) {
                        character.setStanding();
                    } else {
                        character.y += 7 * _gravitySpeed.getMovedPixels(elapsedTime);
                    }

                // Is teleporting up
                } else {
                    // Finished teleporting, remove from scene.
                    if (_sceneManager.getCamera().isOutsideView(character)) {
                        _sceneManager.removeFromScene(character);
                    } else {
                        character.y -= 7 * _gravitySpeed.getMovedPixels(elapsedTime);
                    }
                }

                // Special treatment, stops dealing with this character.
                continue;
            }

            //Gravity
            character.toDownForce += _gravitySpeed.getMovedPixels(elapsedTime);

            Collidable collidedWith = _currentStageArea.collideWithMap(character,
                    character.toDownForce, 0);

            if (collidedWith != null) {
                Rectangle collisionBounds = collidedWith.getBoundsHitbox();

                // Was falling, landed on sonmething
                if (character.toDownForce > 0) {
                    character.y = collisionBounds.y - character.height;

                    if (character.isJumping()) {
                        character.setStanding();
                    }

                // Was going up, hit ceiling
                } else if (character.toDownForce < 0) {
                    character.y = collisionBounds.y + collisionBounds.height;
                }

                character.toDownForce = 0;


            } else {
                character.setJumping();
                character.y += character.toDownForce;
            }

            collidedWith = _currentStageArea.collideWithMap(character,
                    0, character.toRightForce);

            if (collidedWith != null) {
                Rectangle collisionBounds = collidedWith.getBoundsHitbox();

                if (character.toRightForce > 0) {
                    character.x = collisionBounds.x - character.width;
                } else if (character.toRightForce < 0) {
                    character.x = collisionBounds.x + collisionBounds.width;
                }
            } else {
                character.x += character.toRightForce;
            }

            if (character.isSliding()) {
                num pixelsMoved = character.getSlideSpeed().getMovedPixels(elapsedTime);

                // Prevents accelerating through multiple slides
                character.toRightForce = math.max(math.min(character.toRightForce, pixelsMoved),
                        -pixelsMoved);
            } else {
                character.toRightForce = 0;
            }
        }

        for (Character character in _characterList) {
            List<Projectile> toRemoveProjectiles = new List<Projectile>();

            for (Projectile projectile in character.getProjectiles()) {
                if (projectile.isToRight()) {
                    projectile.x += projectile.getSpeed().getMovedPixels(elapsedTime);
                } else {
                    projectile.x -= projectile.getSpeed().getMovedPixels(elapsedTime);
                }

                print("Projectile "+projectile.getBoundsHitbox().toString()
                        +" Camera "+_sceneManager.getCamera().getRectangle().toString());

                if (_sceneManager.getCamera().isOutsideView(projectile)) {
                    toRemoveProjectiles.add(projectile);
                }
            }

            for (Projectile projectile in toRemoveProjectiles) {
                _sceneManager.removeFromScene(projectile);
                character.getProjectiles().remove(projectile);
            }
        }

        _sceneManager.centerCamera(_megaman);
        //print("Camera X "+_camera.x.toString());

        //Renew Loop
        _juggler.delayCall(() => gameLoop(), _GAME_LOOP_TIME);
    }

    void _onKeyDown(html.KeyboardEvent key) {
        print("Key ${key.keyCode} was pressed down.");
        switch (key.keyCode) {
            case html.KeyCode.LEFT:
                leftKeyPressed = true;
                break;
            case html.KeyCode.RIGHT:
                rightKeyPressed = true;
                break;
            case html.KeyCode.DOWN:
                downKeyPressed = true;
                break;
            case html.KeyCode.UP:
                upKeyPressed = true;
                break;
            case html.KeyCode.A:
                jumpKeyPressed = true;
                break;
            case html.KeyCode.S:
                shootKeyPressed = true;
                break;
            default:
                print("Key ${key.keyCode} press was not handled.");
        }
    }

    void _onKeyUp(html.KeyboardEvent key) {
        print("Key ${key.keyCode} was released.");
        switch (key.keyCode) {
            case html.KeyCode.LEFT:
                leftKeyPressed = false;
                break;
            case html.KeyCode.RIGHT:
                rightKeyPressed = false;
                break;
            case html.KeyCode.DOWN:
                downKeyPressed = false;
                break;
            case html.KeyCode.UP:
                upKeyPressed = false;
                break;
            case html.KeyCode.A:
                jumpKeyPressed = false;
                break;
            case html.KeyCode.S:
                shootKeyPressed = false;
                break;
            default:
                print("Key ${key.keyCode} release was not handled.");
        }
    }

  //---------------------------------------------------------------------------------------------------
  //---------------------------------------------------------------------------------------------------
/*
  _gameOver() {

    Sprite gameOverBox = new Sprite();

    Bitmap background = new Bitmap(_resourceManager.getBitmapData("ExitBox"));
    gameOverBox.addChild(background);

    TextField textField = new TextField();
    textField.defaultTextFormat = new TextFormat("Arial", 30, 0xFFFFFF, bold:true, align:TextFormatAlign.CENTER);
    textField.width = 240;
    textField.height = 200;
    textField.wordWrap = true;
    //textField.selectable = false;
    textField.text = _resourceManager.getText("GENgameover");
    textField.x = 47;
    textField.y = 30 + (textField.height - textField.textHeight)/2;
    //textField.filters = [new GlowFilter(0x000000, 0.7, 3, 3)];
    textField.mouseEnabled = false;
    gameOverBox.addChild(textField);

    gameOverBox.x = 110;
    gameOverBox.y = -gameOverBox.height;

    _messageLayer.addChild(gameOverBox);
    _juggler.delayCall(() => _resourceManager.getSound("Laugh").play(), 0.3);

    Tween tween = new Tween(gameOverBox, 0.3, TransitionFunction.easeOutCubic);
    tween.animate.y.to(150);

    _juggler.add(tween);

    //----------------------------------------------

    _juggler.delayCall(() => _exitGame(true), 5.0);

    gameOverBox.addEventListener(MouseEvent.CLICK, (MouseEvent me) => _exitGame(true));
  }

  //---------------------------------------------------------------------------------------------------

  bool _exitCalled = false;

  void _exitGame(bool gameEnded) {
    _timeGauge.pause();

    if (_exitCalled == false) {
      _exitCalled = true;
      //  GameApi.instance.exit(_points.intValue, gameEnded);
    }
  }
  */
}