part of escape;

abstract class Weapon {
    static const MAX_LEVEL = 100;

    num _level;
    bool _selectable;
    bool _showsBar;

    Weapon(bool selectable, bool showsBar) {
        _level = MAX_LEVEL;
        _selectable = selectable;
        _showsBar = showsBar;
    }

    bool isSelectable() {
        return _selectable;
    }

    void setSelectable(bool selectable) {
        _selectable = selectable;
    }

    bool showsBar() {
        return _showsBar;
    }

    num getLevel() {
        return _level;
    }

    void setLevel(num newLevel) {
        _level = newLevel;
    }

    void decreaseLevel(num spentLevel) {
        _level = math.max(0, _level - spentLevel);
    }

    void increaseLevel(num acquiredLevel) {
        _level = math.min(MAX_LEVEL, _level + acquiredLevel);
    }

    BitmapData getIcon();
    Projectile createProjectile(Character source);
}