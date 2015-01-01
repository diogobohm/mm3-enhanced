part of escape;

/* Enum pattern */
class CharacterDamageState {
    static const IDLE = const CharacterDamageState._(0);
    static const DAMAGED = const CharacterDamageState._(1);
    static const INVINCIBLE = const CharacterDamageState._(2);

    static get values => [IDLE, DAMAGED, INVINCIBLE];

    final int value;

    const CharacterDamageState._(this.value);
}