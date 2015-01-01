part of escape;

class Camera {
    num _x;
    num _y;
    num _width;
    num _height;
    Rectangle _rectangle;

    Camera(int canvasWidth, int canvasHeight) {
        _x = 0;
        _y = 0;
        _width = canvasWidth;
        _height = canvasHeight;
        _rectangle = new Rectangle(_x, _y, _width, _height);
    }

    void setPosition(num x, num y) {
        _x = x;
        _y = y;
    }

    bool isOutsideView(Collidable target) {
        Rectangle quad = target.getBoundsHitbox();

        return !quad.intersects(getRectangle());
    }

    Rectangle getRectangle() {
        return _rectangle = new Rectangle(_x, _y, _width, _height);
    }
}