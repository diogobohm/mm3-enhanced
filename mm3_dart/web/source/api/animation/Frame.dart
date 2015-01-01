part of escape;

/**
 * Classe que define informações sobre um frame de animação.
 */
class Frame {

    num _time;
    String _name;

    Frame(num time, String name) {
        _name = name;
        _time = time;
    }

    num getTime() {
        return _time;
    }

    String getName() {
        return _name;
    }
}