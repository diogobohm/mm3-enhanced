part of escape;

abstract class Character extends AnimationManager implements Controllable, Collidable {
    static const num SHOOT_RECOVERY_TIME = .25;
    static const num SLIDE_RECOVERY_TIME = .5;
    static const num MAX_PROJECTILES = 3;
    static const num SHOOT_RECHARGE_TIME = .1;
    static const num JUMP_MAX_INCREMENTS = 5;

    CharacterState _lastState;
    CharacterState _currentState;

    Weapon _currentWeapon;
    List<Weapon> _weapons;
    List<Projectile> _projectiles;

    num toRightForce;
    num toDownForce;

    num _lastShoot;
    num _lastSlide;

    num _jumpIncrements;

    Character() {
        _timeLastFrameChange = 0;
        _timeTotal = 0;
        _lastShoot = 0;
        _lastSlide = 0;
        _animationChanged = true;
        _currentState = new CharacterState(CharacterGroundState.STANDING, CharacterShootState.IDLE,
                CharacterDamageState.IDLE, SpriteDirectionState.RIGHT);
        _lastState = _currentState;
        _projectiles = new List<Projectile>();
        _weapons = new List<Weapon>();

        _jumpIncrements = 0;

        toRightForce = 0;
        toDownForce = 0;
    }

    void setWeaponList(List<Weapon> weapons) {
        _weapons = weapons;
        changeCurrentWeapon(_weapons.first);
    }

    void changeCurrentWeapon(Weapon weapon) {
        _currentWeapon = weapon;
    }

    List<Projectile> getProjectiles() {
        return _projectiles;
    }

    MovementSpeed getWalkSpeed();
    MovementSpeed getSlideSpeed();
    MovementSpeed getJumpSpeed();

    void updateSprite();

    void setStanding() {
        _jumpIncrements = 0;
        _currentState.setGroundState(CharacterGroundState.STANDING);
    }

    void setWalking() {
        _jumpIncrements = 0;
        _currentState.setGroundState(CharacterGroundState.WALKING);
    }

    void setJumping() {
        _currentState.setGroundState(CharacterGroundState.JUMPING);
    }

    void setSliding() {
        _currentState.setGroundState(CharacterGroundState.SLIDING);
        _lastSlide = _timeTotal;
    }

    void setTeleportingDown() {
        _currentState.setGroundState(CharacterGroundState.TELEPORTING_DOWN);
    }

    void setTeleportingUp() {
        _currentState.setGroundState(CharacterGroundState.TELEPORTING_UP);
    }

    void setShooting() {
        _currentState.setShootState(CharacterShootState.SHOOTING);
        _lastShoot = _timeTotal;
        _projectiles.add(_currentWeapon.createProjectile(this));
    }

    void setShootingIdle() {
        _currentState.setShootState(CharacterShootState.IDLE);
    }

    void setLeft() {
        _currentState.setDirectionState(SpriteDirectionState.LEFT);
    }

    void setRight() {
        _currentState.setDirectionState(SpriteDirectionState.RIGHT);
    }

    bool isStanding() {
        return _currentState.getGroundState() == CharacterGroundState.STANDING;
    }

    bool isWalking() {
        return _currentState.getGroundState() == CharacterGroundState.WALKING;
    }

    bool isJumping() {
        return _currentState.getGroundState() == CharacterGroundState.JUMPING;
    }

    bool isSliding() {
        return _currentState.getGroundState() == CharacterGroundState.SLIDING;
    }

    bool isTeleporting() {
        return isTeleportingUp() || isTeleportingDown();
    }

    bool isTeleportingDown() {
        return _currentState.getGroundState() == CharacterGroundState.TELEPORTING_DOWN;
    }

    bool isTeleportingUp() {
        return _currentState.getGroundState() == CharacterGroundState.TELEPORTING_UP;
    }

    bool isShooting() {
        return _currentState.getShootState() == CharacterShootState.SHOOTING;
    }

    bool isToRight() {
        return _currentState.getDirectionState() == SpriteDirectionState.RIGHT;
    }

    void leftKeyEvent() {
        setLeft();

        //Only walk when you can
        if (isStanding() || isWalking()) {
            setWalking();
        }
    }

    void rightKeyEvent() {
        setRight();

        //Only walk when you can
        if (isStanding() || isWalking()) {
            setWalking();
        }
    }

    void noDirectionKeyEvent() {
        //Stopped pressing buttons on mid-air or mid-slide, move on
        if (isWalking()) {
            setStanding();
        }
    }

    bool jumpKeyEvent() {
        //Only set when not in mid-air and not pushed through increments.
        if (!isJumping()) {
            setJumping();
            return true;
        } else if (toDownForce < 0 && _jumpIncrements < JUMP_MAX_INCREMENTS) {
            _jumpIncrements ++;
            setJumping();
            return true;
        }

        return false;
    }

    void noJumpKeyEvent() {
        // If jumping, prevents player from incrementing more jumps (flying)
        if (isJumping()) {
            _jumpIncrements = JUMP_MAX_INCREMENTS;
        }
    }

    bool slideKeyEvent() {
        //Only slide when you can
        if (isStanding() || isWalking()) {
            setSliding();

            return true;
        }

        return false;
    }

    bool shootKeyEvent() {
        if (_canShoot() && !isSliding()) {
            setShooting();

            return true;
        }

        return false;
    }

    Projectile getLastProjectile() {
        return _projectiles.last;
    }

    Rectangle getBoundsHitbox() {
        num xBoundsOffset = (width / 4);
        num xBoundsWidth = 2 * xBoundsOffset;
        num yBoundsOffset = height / 4;
        num yBoundsHeight = 3 * yBoundsOffset;
        return new Rectangle(x + xBoundsOffset, y + yBoundsOffset, xBoundsWidth, yBoundsHeight);
    }

    Rectangle getDamageHitbox() {
        return getBoundsHitbox();
    }

    Rectangle getReflectHitbox() {
        return new Rectangle(x, y, 0, 0);
    }

    bool _canShoot() {
        return _projectiles.length < MAX_PROJECTILES
                && (_timeTotal - _lastShoot) > SHOOT_RECHARGE_TIME;
    }

    void _updateState() {

        if (isShooting()) {
            if ((_timeTotal - _lastShoot) > SHOOT_RECOVERY_TIME) {
                setShootingIdle();
            }
        }
        if (isSliding()) {
            if ((_timeTotal - _lastSlide) > SLIDE_RECOVERY_TIME) {
                setStanding();
            }
        }

        updateSprite();
        //print("Sprite update: "+(_currentState.toString()));
    }
}