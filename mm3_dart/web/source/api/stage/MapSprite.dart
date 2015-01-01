part of escape;

class MapSprite extends AnimationManager implements Collidable {

    Animation _animation;

    MapSprite(int mapX, int mapY, Animation animation) {
        _animation = animation;
        this.x = mapX;
        this.y = mapY;

        _changeCurrentAnimation(_animation);
    }

    Rectangle getBoundsHitbox() {
        return new Rectangle(x, y, width, height);
    }

    Rectangle getDamageHitbox() {
        return new Rectangle(x, y, 0, 0);
    }

    Rectangle getReflectHitbox() {
        return new Rectangle(x, y, 0, 0);
    }

    // No need to define this function
    void _updateState() {}
}