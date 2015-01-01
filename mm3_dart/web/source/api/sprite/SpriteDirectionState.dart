part of escape;

/* Enum pattern */
class SpriteDirectionState {
    static const RIGHT = const SpriteDirectionState._(0);
    static const LEFT = const SpriteDirectionState._(1);

    static get values => [RIGHT, LEFT];

    final int value;

    const SpriteDirectionState._(this.value);
}