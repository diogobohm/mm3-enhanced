part of escape;

/* Enum pattern */
class CharacterGroundState {
    static const STANDING = const CharacterGroundState._(0);
    static const WALKING = const CharacterGroundState._(1);
    static const JUMPING = const CharacterGroundState._(2);
    static const SLIDING = const CharacterGroundState._(3);
    static const TELEPORTING_DOWN = const CharacterGroundState._(4);
    static const TELEPORTING_UP = const CharacterGroundState._(5);

    static get values => [STANDING, WALKING, JUMPING, SLIDING, TELEPORTING_DOWN, TELEPORTING_UP];

    final int value;

    const CharacterGroundState._(this.value);
}