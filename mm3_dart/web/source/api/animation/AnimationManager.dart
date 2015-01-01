part of escape;

abstract class AnimationManager extends Sprite implements Animatable {

    Animation _currentAnimation;
    Bitmap _currentSprite;

    bool _animationChanged;
    num _timeLastFrameChange;
    num _timeTotal;

    AnimationManager() {
        _timeTotal = 0;
        _timeLastFrameChange = 0;

        BitmapData bmp = new BitmapData(1, 1);

        Animation anim = new Animation(true);
        anim.add(new SpriteAnimable(100, bmp));
        _changeCurrentAnimation(anim);

        _currentSprite = new Bitmap(bmp, PixelSnapping.AUTO);
        addChild(_currentSprite);
    }

    void _updateState();

    bool advanceTime(num time) {
        _timeTotal += time;

        _updateState();

        //print("advanceTime ${_timeTotal - _timeLastFrameChange}");
        if (_animationChanged) {
            //print("animationChanged");
            _changeSpriteFrame(_currentAnimation.getCurrentFrame(), _timeTotal);
            _animationChanged = false;

        } else if (_currentAnimation.getCurrentTime() < (_timeTotal - _timeLastFrameChange)) {
            //print("frameChanged");
            _changeSpriteFrame(_currentAnimation.nextFrame(), _timeTotal);
        }

        return true;
    }

    void _changeSpriteFrame(BitmapData sprite, num timeFrameChange) {
        _currentSprite.bitmapData = sprite;
        _timeLastFrameChange = timeFrameChange;
    }

    void _changeCurrentAnimation(Animation newAnimation) {
        _currentAnimation = newAnimation;
        _animationChanged = true;
    }
}
