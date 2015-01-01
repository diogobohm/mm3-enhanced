part of escape;

class Animation {

    List<SpriteAnimable> _spriteData;
    Transition _transition;
    int _length;
    int _frame;
    bool _loop;
    Function _updateFunction;
    bool _run;

    Animation(bool loop) {
        _spriteData = new List<SpriteAnimable>();
        _frame = 0;
        _length = 0;
        _run = true;
        _loop = loop;
    }

    void add(SpriteAnimable spriteUnit) {
        _spriteData.add(spriteUnit);
        _length = _spriteData.length;
    }

    void addAll(List<SpriteAnimable> spriteUnits) {
        _spriteData.addAll(spriteUnits);
        _length = _spriteData.length;
    }

    BitmapData getCurrentFrame() {
        return _spriteData.elementAt(_frame).getSpriteData();
    }

    num getCurrentTime() {
        return _spriteData.elementAt(_frame).getTime();
    }

    BitmapData nextFrame() {
        if (_loop) {
            _frame = (_frame + 1) >= _length ? 0 : _frame + 1;
        } else {
            _frame = (_frame + 1) >= _length ? _frame : _frame + 1;
        }
        return _spriteData.elementAt(_frame).getSpriteData();
    }

    void resetFrame() {
        _frame = 0;
    }

    int getLength() {
        return _length;
    }

    Transition getTransition() {
        return _transition;
    }

    void pause() {
        _run = false;
    }

    void start() {
        _run = true;
    }
}