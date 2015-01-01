part of escape;

class SceneManager extends DisplayObjectContainer {
    num _canvasWidth;
    num _halfCanvasWidth;
    num _canvasHeight;
    num _halfCanvasHeight;

    Camera _camera;
    BackgroundColor _backgroundColor;
    Sprite _rootNode;
    Juggler _juggler;

    SceneManager(Juggler juggler, int canvasWidth, int canvasHeight) {
        _canvasWidth = canvasWidth;
        _halfCanvasWidth = (_canvasWidth / 2).abs();

        _canvasHeight = canvasHeight;
        _halfCanvasHeight = (_canvasHeight / 2).abs();

        _camera = new Camera(canvasWidth, canvasHeight);

        _rootNode = new Sprite();
        _juggler = juggler;

        _backgroundColor = new BackgroundColor(canvasWidth, canvasHeight, Color.Black);

        addChild(_backgroundColor);
        addChild(_rootNode);
    }

    Camera getCamera() {
        return _camera;
    }

    void addToScene(Sprite sprite) {
        _rootNode.addChild(sprite);

        if (sprite is StageArea) {
            setBackgroundColor(sprite.getBgColor());
        }

        if (sprite is Animatable) {
            Animatable anim = sprite;
            _juggler.add(anim);
        }
    }

    void removeFromScene(Sprite sprite) {
        _rootNode.removeChild(sprite);


        if (sprite is Animatable) {
            Animatable anim = sprite;
            _juggler.remove(anim);
        }
    }

    void setBackgroundColor(int color) {
        _backgroundColor.setColor(color);
    }

    /**
     * Centers camera around a specific object, aware of scene bounds.
     * There's a small bug, since scene size is dynamic, if a moving sprite exits the scene,
     * the camera can extend the scene view until it gets bigger than halfCanvasWidth/Height
     */
    void centerCamera(DisplayObject sprite) {
        num camX = math.max(0, math.min(sprite.x - _halfCanvasWidth, width - _canvasWidth));
        num camY = math.max(0, math.min(sprite.y - _halfCanvasHeight, height - _canvasHeight));

        //_camera.setPosition(camX, camY);
        _rootNode.x = -camX;
        _rootNode.y = -camY;
    }
}