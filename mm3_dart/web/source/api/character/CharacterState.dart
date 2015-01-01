part of escape;

/* Enum pattern */
class CharacterState {
    CharacterGroundState _groundState;
    CharacterShootState _shootState;
    CharacterDamageState _damageState;
    SpriteDirectionState _directionState;

    CharacterState(CharacterGroundState groundState, CharacterShootState shootState,
            CharacterDamageState damageState, SpriteDirectionState directionState) {
        _groundState = groundState;
        _shootState = shootState;
        _damageState = damageState;
        _directionState = directionState;
    }

    CharacterGroundState getGroundState() {
        return _groundState;
    }

    void setGroundState(CharacterGroundState groundState) {
        _groundState = groundState;
    }

    CharacterShootState getShootState() {
        return _shootState;
    }

    void setShootState(CharacterShootState shootState) {
        _shootState = shootState;
    }

    CharacterDamageState getDamageState() {
        return _damageState;
    }

    void setDamageState(CharacterDamageState damageState) {
        _damageState = damageState;
    }

    SpriteDirectionState getDirectionState() {
        return _directionState;
    }

    void setDirectionState(SpriteDirectionState directionState) {
        _directionState = directionState;
    }

    bool equals(CharacterState other) {
        return _groundState == other.getGroundState()
                && _shootState == other.getShootState()
                && _damageState == other.getDamageState()
                && _directionState == other.getDirectionState();
    }


    String toString() {
        return "Direction "+_directionState.value.toString()+" Shooting "+_shootState.value.toString()+
                ", Ground "+_groundState.value.toString()+", Damage "+_damageState.value.toString();
    }
}