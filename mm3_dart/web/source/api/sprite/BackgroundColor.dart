part of escape;

class BackgroundColor extends DisplayObjectContainer {
    final Bitmap _bgBitmap = new Bitmap();
    int _canvasWidth;
    int _canvasHeight;

    BackgroundColor(int width, int height, int color) {
        this.x = 0;
        this.y = 0;
        _canvasWidth = width;
        _canvasHeight = height;

        addChild(_bgBitmap);
        setColor(color);
    }

    void setColor(int color) {
        _bgBitmap.bitmapData = new BitmapData(_canvasWidth, _canvasHeight, false, color, 1);
    }
}