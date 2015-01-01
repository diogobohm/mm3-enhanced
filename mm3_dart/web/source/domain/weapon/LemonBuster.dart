part of escape;

class LemonBuster extends Weapon {

    BitmapData _icon;
    ResourceManager _resourceManager;

    LemonBuster(ResourceManager resourceManager) : super(true, false) {
        _resourceManager = resourceManager;
        TextureAtlas textureAtlas = resourceManager.getTextureAtlas("Weapon");
        _icon = textureAtlas.getBitmapData("icon_lemon");
    }

    BitmapData getIcon() {
        return _icon;
    }

    Projectile createProjectile(Character source) {
        return new LemonBusterProjectile(_resourceManager, source);
    }
}