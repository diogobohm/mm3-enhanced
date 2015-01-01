part of escape;

class MovementSpeed {

    num _rate; // pixels/second

    MovementSpeed(num rate) {
        _rate = rate;
    }

    num getMovedPixels(num timeSpan) {
        return _rate * timeSpan;
    }

    num getTimeSpan(num movedPixels) {
        return movedPixels / _rate;
    }
}