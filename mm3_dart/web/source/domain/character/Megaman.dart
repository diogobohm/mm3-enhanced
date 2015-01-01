part of escape;

class Megaman extends Character {

    Animation _standRightAnimation;
    Animation _standShootRightAnimation;
    Animation _walkRightAnimation;
    Animation _walkShootRightAnimation;
    Animation _jumpRightAnimation;
    Animation _jumpShootRightAnimation;
    Animation _slideRightAnimation;
    Animation _damageRightAnimation;

    Animation _standLeftAnimation;
    Animation _standShootLeftAnimation;
    Animation _walkLeftAnimation;
    Animation _walkShootLeftAnimation;
    Animation _jumpLeftAnimation;
    Animation _jumpShootLeftAnimation;
    Animation _slideLeftAnimation;
    Animation _damageLeftAnimation;

    Transition _standRightTransition;

    MovementSpeed _slideSpeed = new MovementSpeed(450);
    MovementSpeed _walkSpeed = new MovementSpeed(200);
    MovementSpeed _jumpSpeed = new MovementSpeed(100);

    Megaman(ResourceManager resourceManager) {
        TextureAtlas textureAtlas = resourceManager.getTextureAtlas("Megaman");

        setWeaponList(_buildWeapons(resourceManager));

        _standRightAnimation = _buildStandRightAnimation(textureAtlas);
        _standShootRightAnimation = _buildStandShootRightAnimation(textureAtlas);
        _walkRightAnimation = _buildWalkRightAnimation(textureAtlas);
        _walkShootRightAnimation = _buildWalkShootRightAnimation(textureAtlas);
        _jumpRightAnimation = _buildJumpRightAnimation(textureAtlas);
        _jumpShootRightAnimation = _buildJumpShootRightAnimation(textureAtlas);
        _slideRightAnimation = _buildSlideRightAnimation(textureAtlas);
        _damageRightAnimation = _buildDamageRightAnimation(textureAtlas);

        _standLeftAnimation = _buildStandLeftAnimation(textureAtlas);
        _standShootLeftAnimation = _buildStandShootLeftAnimation(textureAtlas);
        _walkLeftAnimation = _buildWalkLeftAnimation(textureAtlas);
        _walkShootLeftAnimation = _buildWalkShootLeftAnimation(textureAtlas);
        _jumpLeftAnimation = _buildJumpLeftAnimation(textureAtlas);
        _jumpShootLeftAnimation = _buildJumpShootLeftAnimation(textureAtlas);
        _slideLeftAnimation = _buildSlideLeftAnimation(textureAtlas);
        _damageLeftAnimation = _buildDamageRightAnimation(textureAtlas);

        _standRight();
    }

    MovementSpeed getWalkSpeed() {
        return _walkSpeed;
    }

    MovementSpeed getSlideSpeed() {
        return _slideSpeed;
    }

    MovementSpeed getJumpSpeed() {
        return _jumpSpeed;
    }

    void updateSprite() {

        /* means the is on the ground and stopped, set default frames */
        if (isWalking()) {
            if (isToRight()) {
                if (isShooting()) {
                    _walkShootRight();
                } else {
                    _walkRight();
                }
            } else {
                if (isShooting()) {
                    _walkShootLeft();
                } else {
                    _walkLeft();
                }
            }
        } else if (isJumping()) {
            if (isToRight()) {
                if (isShooting()) {
                    _jumpShootRight();
                } else {
                    _jumpRight();
                }
            } else {
                if (isShooting()) {
                    _jumpShootLeft();
                } else {
                    _jumpLeft();
                }
            }
        } else if (isSliding()) {
            if (isToRight()) {
                _slideRight();
            } else {
                _slideLeft();
            }
        } else {
            if (isToRight()) {
                if (isShooting()) {
                    _standShootRight();
                } else {
                    _standRight();
                }
            } else {
                if (isShooting()) {
                    _standShootLeft();
                } else {
                    _standLeft();
                }
            }
        }
    }

    void _changeAnimation(Animation _newAnimation) {
        if (_currentAnimation != _newAnimation) {
           print("Setting "+_newAnimation.toString()+" animation");
           _changeCurrentAnimation(_newAnimation);
        }
    }

    void _standRight() {
        _changeAnimation(_standRightAnimation);
    }

    void _standShootRight() {
        _changeAnimation(_standShootRightAnimation);
    }

    void _walkRight() {
        _changeAnimation(_walkRightAnimation);
    }

    void _walkShootRight() {
        _changeAnimation(_walkShootRightAnimation);
    }

    void _jumpRight() {
        _changeAnimation(_jumpRightAnimation);
    }

    void _jumpShootRight() {
        _changeAnimation(_jumpShootRightAnimation);
    }

    void _slideRight() {
        _changeAnimation(_slideRightAnimation);
    }

    void _standLeft() {
        _changeAnimation(_standLeftAnimation);
    }

    void _standShootLeft() {
        _changeAnimation(_standShootLeftAnimation);
    }

    void _walkLeft() {
        _changeAnimation(_walkLeftAnimation);
    }

    void _walkShootLeft() {
        _changeAnimation(_walkShootLeftAnimation);
    }

    void _jumpLeft() {
        _changeAnimation(_jumpLeftAnimation);
    }

    void _jumpShootLeft() {
        _changeAnimation(_jumpShootLeftAnimation);
    }

    void _slideLeft() {
        _changeAnimation(_slideLeftAnimation);
    }

    void _damageLeft() {
        _changeAnimation(_damageLeftAnimation);
    }

    //--------------------------------------------------------------------------------------------

    Animation _buildStandRightAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [
                new Frame(1.55, "mm_stand_1"),
                new Frame(.1,   "mm_stand_2")
                ]);
    }

    Animation _buildStandLeftAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [
                new Frame(1.55, "mm_stand_left_1"),
                new Frame(.1,   "mm_stand_left_2")
                ]);
    }

    Animation _buildStandShootRightAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [new Frame(30, "mm_stand_shoot_1")]);
    }

    Animation _buildStandShootLeftAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [new Frame(30, "mm_stand_shoot_left_1")]);
    }

    Animation _buildWalkRightAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [
                new Frame(.1, "mm_walk_1"),
                new Frame(.1, "mm_walk_2"),
                new Frame(.1, "mm_walk_3"),
                new Frame(.1, "mm_walk_4")
                ]);
    }

    Animation _buildWalkLeftAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [
                new Frame(.1, "mm_walk_left_1"),
                new Frame(.1, "mm_walk_left_2"),
                new Frame(.1, "mm_walk_left_3"),
                new Frame(.1, "mm_walk_left_4")
                ]);
    }

    Animation _buildWalkShootRightAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [
                new Frame(.1, "mm_walk_shoot_1"),
                new Frame(.1, "mm_walk_shoot_2"),
                new Frame(.1, "mm_walk_shoot_3"),
                new Frame(.1, "mm_walk_shoot_4")
                ]);
    }

    Animation _buildWalkShootLeftAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [
                new Frame(.1, "mm_walk_shoot_left_1"),
                new Frame(.1, "mm_walk_shoot_left_2"),
                new Frame(.1, "mm_walk_shoot_left_3"),
                new Frame(.1, "mm_walk_shoot_left_4")
                ]);
    }

    Animation _buildJumpRightAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [new Frame(30, "mm_jump_1")]);
    }

    Animation _buildJumpLeftAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [new Frame(30, "mm_jump_left_1")]);
    }

    Animation _buildJumpShootRightAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [new Frame(30, "mm_jump_shoot_1")]);
    }

    Animation _buildJumpShootLeftAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [new Frame(30, "mm_jump_shoot_left_1")]);
    }

    Animation _buildSlideRightAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [new Frame(30, "mm_slide_1")]);
    }

    Animation _buildSlideLeftAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [new Frame(30, "mm_slide_left_1")]);
    }

    Animation _buildDamageRightAnimation(TextureAtlas textureAtlas) {
        bool loop = false;

        return _buildAnimation(textureAtlas, [
                new Frame(.5, "mm_damage_1"),
                new Frame(2,  "mm_damage_2")
                ], loop);
    }

    Animation _buildDamageLeftAnimation(TextureAtlas textureAtlas) {
        bool loop = false;

        return _buildAnimation(textureAtlas, [
                new Frame(.5, "mm_damage_left_1"),
                new Frame(2,  "mm_damage_left_2")
                ], loop);
    }

    Animation _buildTeleportAnimation(TextureAtlas textureAtlas) {
        bool loop = false;

        return _buildAnimation(textureAtlas, [
                new Frame(.1, "mm_born_1"),
                new Frame(.1, "mm_born_2"),
                new Frame(30, "mm_stand_1")
                ], loop);
    }

    Animation _buildAnimation(TextureAtlas textureAtlas, List<Frame> frames, [bool loop = true]) {
        Animation animation = new Animation(loop);
        String prefix = "mm/";

        for (Frame frame in frames) {
            animation.add(new SpriteAnimable(frame.getTime(),
                    textureAtlas.getBitmapData("${prefix}${frame.getName()}")));
        }

        return animation;
    }

    List<Weapon> _buildWeapons(ResourceManager resourceManager) {
        TextureAtlas textureAtlas = resourceManager.getTextureAtlas("Weapon");
        List<Weapon> weapons = new List<Weapon>();

        weapons.add(new LemonBuster(resourceManager));

        return weapons;
    }
}