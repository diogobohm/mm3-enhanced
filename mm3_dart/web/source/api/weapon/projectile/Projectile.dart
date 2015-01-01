part of escape;

abstract class Projectile extends AnimationManager implements Collidable {
    static final MovementSpeed PROJECTILE_SPEED = new MovementSpeed(450);

    num _damage;
    SpriteDirectionState _directionState;

    Projectile(num damage, Character character) {
        _damage = damage;
        _directionState = character.isToRight()? SpriteDirectionState.RIGHT : SpriteDirectionState.LEFT;
    }

    bool isToRight() {
        return _directionState == SpriteDirectionState.RIGHT;
    }

    void setToRight() {
        _directionState = SpriteDirectionState.RIGHT;
    }

    void setToLeft() {
        _directionState = SpriteDirectionState.LEFT;
    }

    MovementSpeed getSpeed() {
        return PROJECTILE_SPEED;
    }

    Rectangle getBoundsHitbox() {
        num xBoundsOffset = (width / 4);
        num xBoundsWidth = 2 * xBoundsOffset;
        num yBoundsOffset = height / 4;
        num yBoundsHeight = 2 * yBoundsOffset;
        return new Rectangle(x + xBoundsOffset, y + yBoundsOffset, xBoundsWidth, yBoundsHeight);
    }

    Rectangle getDamageHitbox() {
        return new Rectangle(x, y, 0, 0);
    }

    Rectangle getReflectHitbox() {
        return new Rectangle(x, y, 0, 0);
    }
}