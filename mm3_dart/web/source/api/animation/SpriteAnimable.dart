part of escape;

class SpriteAnimable {

    num _time;
    BitmapData _spriteData;

    SpriteAnimable(num time, BitmapData spriteData) {
        _spriteData = spriteData;
        _time = time;
    }

    num getTime() {
        return _time;
    }

    BitmapData getSpriteData() {
        return _spriteData;
    }
}