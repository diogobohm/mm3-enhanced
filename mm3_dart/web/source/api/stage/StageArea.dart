part of escape;

class StageArea extends Sprite implements Animatable {

    List<MapSprite> _mapSprites;
    List<MapSprite> _bgSprites;

    int _bgColor;
    int _startXPos;
    int _startYPos;

    StageArea(int bgColor, int startXPos, int startYPos) {
        _bgColor = bgColor;
        _startXPos = startXPos;
        _startYPos = startYPos;

        _mapSprites = new List<MapSprite>();
        _bgSprites = new List<MapSprite>();
    }

    void addMapSprite(MapSprite mapSprite) {
        _mapSprites.add(mapSprite);
    }

    void addBgSprite(MapSprite mapSprite) {
        _bgSprites.add(mapSprite);
    }

    /// Adds sprites in order to assure the Z order
    void pack() {
        for (MapSprite sprite in _bgSprites) {
            addChild(sprite);
        }
        for (MapSprite sprite in _mapSprites) {
            addChild(sprite);
        }
    }

    bool advanceTime(num time) {
        for (MapSprite sprite in _bgSprites) {
            sprite.advanceTime(time);
        }
        for (MapSprite sprite in _mapSprites) {
            sprite.advanceTime(time);
        }

        return true;
    }

    int getStartXPos() {
        return _startXPos;
    }

    int getStartYPos() {
        return _startYPos;
    }

    int getBgColor() {
        return _bgColor;
    }

    Collidable collideWithMap(Collidable origin, num toDownForce, num toRightForce) {
        Rectangle quad = origin.getBoundsHitbox();
        quad.x += toRightForce;
        quad.y += toDownForce;

        for (Collidable sprite in _mapSprites) {
            if (quad.intersects(sprite.getBoundsHitbox())) {
                return sprite;
            }
        }

        return null;
    }

    /*
    bool _collide(Sprite sprite1, Sprite character) {
        return ((sprite1.x >= character.x && sprite1.x <= (character.x + character.width)
                        || (character.x >= sprite1.x && character.x <= (sprite1.x + sprite1.width)))
                && ((sprite1.y >= character.y && sprite1.y <= (character.y + character.height))
                        || (character.y >= sprite1.y && character.y <= (sprite1.y + sprite1.height))));
    }

    bool _collide(Sprite sprite1, Sprite sprite2) {
        num Rect1Top = sprite1.y;
        num Rect1Left = sprite1.x;
        num Rect1Bottom = sprite1.y + sprite1.height;
        num Rect1Right = sprite1.x + sprite1.width;
        num Rect2Top = sprite2.y;
        num Rect2Left = sprite2.x;
        num Rect2Bottom = sprite2.y + sprite2.height;
        num Rect2Right = sprite2.x + sprite2.width;

        return !(
                (Rect1Bottom < Rect2Top) ||
                (Rect1Top > Rect2Bottom) ||
                (Rect1Left > Rect2Right) ||
                (Rect1Right < Rect2Left) );
    }*/
}
