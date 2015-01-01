part of escape;

/* Enum pattern */
class CharacterShootState {
    static const IDLE = const CharacterShootState._(0);
    static const SHOOTING = const CharacterShootState._(1);

    static get values => [IDLE, SHOOTING];

    final int value;

    const CharacterShootState._(this.value);
}