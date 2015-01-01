part of escape;

class LemonBusterProjectile extends Projectile {
    static const DAMAGE = 1;

    Animation _leftAnimation;
    Animation _rightAnimation;

    LemonBusterProjectile(ResourceManager resourceManager, Character character) : super(DAMAGE, character) {
        TextureAtlas textureAtlas = resourceManager.getTextureAtlas("Weapon");

        _leftAnimation = _buildLeftAnimation(textureAtlas);
        _rightAnimation = _buildLeftAnimation(textureAtlas);

        x = character.x;
        y = character.y + (character.height / 3);

        if (isToRight()) {
            x += character.width;
        } else {
            x -= character.width;
        }
    }

    void _updateState() {
        if (isToRight()) {
            _changeAnimation(_rightAnimation);
            return;
        }

        _changeAnimation(_leftAnimation);
    }

    void _changeAnimation(Animation _newAnimation) {
        if (_currentAnimation != _newAnimation) {
           print("Projectile setting "+_newAnimation.toString()+" animation");
           _changeCurrentAnimation(_newAnimation);
        }
    }

    Animation _buildLeftAnimation(TextureAtlas textureAtlas) {
        bool loop = false;

        return _buildAnimation(textureAtlas, [new Frame(30, "lemon_left")], loop);
    }

    Animation _buildRightAnimation(TextureAtlas textureAtlas) {
        bool loop = false;

        return _buildAnimation(textureAtlas, [new Frame(30, "lemon")], loop);
    }

    Animation _buildAnimation(TextureAtlas textureAtlas, List<Frame> frames, [bool loop = true]) {
        Animation animation = new Animation(loop);
        String prefix = "";

        for (Frame frame in frames) {
            animation.add(new SpriteAnimable(frame.getTime(),
                    textureAtlas.getBitmapData("${prefix}${frame.getName()}")));
        }

        return animation;
    }
}