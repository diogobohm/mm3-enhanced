part of escape;

class TopManMap extends BossStage {
    StageArea _area1;

    Animation _macroCeiling1;
    Animation _macroCeiling2;
    Animation _macroGround1;
    Animation _macroGroundRamp1;
    Animation _macroGroundRamp2;
    Animation _macroGroundRamp3;
    Animation _macroPlatform1;
    Animation _macroPlatform2;
    Animation _macroWall1;

    /*
    Animation _ceiling;
    Animation _leaves;

    Animation _platformBigS;
    Animation _platformBigN;
    Animation _platformBigMid;

    Animation _bgLightPanel;
    Animation _bgLightPanelTopConnector;
    Animation _bgLightPanelBottomConnector;
    Animation _bgLightPanelHorizontalConnector;
    Animation _bgLightPanelVerticalConnector;

    Animation _groundN;
    Animation _groundNE;
    Animation _groundNW;
    Animation _groundNEW;

    Animation _groundInnerSE;
    Animation _groundInnerSW;
    Animation _groundInnerSEW;

    Animation _groundLeaves;
    Animation _groundConsole;
    */

    Animation _invisibleWall;

    TopManMap(ResourceManager resourceManager) {
        TextureAtlas textureAtlas = resourceManager.getTextureAtlas("TopManMap");

        _macroCeiling1 = _buildSingleFrameAnimation(textureAtlas, "macro_ceiling1");
        _macroCeiling2 = _buildSingleFrameAnimation(textureAtlas, "macro_ceiling2");
        _macroGround1 = _buildSingleFrameAnimation(textureAtlas, "macro_ground1");
        _macroGroundRamp1 = _buildSingleFrameAnimation(textureAtlas, "macro_ground_ramp1");
        _macroGroundRamp2 = _buildSingleFrameAnimation(textureAtlas, "macro_ground_ramp2");
        _macroGroundRamp3 = _buildSingleFrameAnimation(textureAtlas, "macro_ground_ramp3");
        _macroPlatform1 = _buildSingleFrameAnimation(textureAtlas, "macro_platform_1");
        _macroPlatform2 = _buildSingleFrameAnimation(textureAtlas, "macro_platform_2");
        _macroWall1 = _buildSingleFrameAnimation(textureAtlas, "macro_wall1");

        /*
        _ceiling = _buildCeilingAnimation(textureAtlas);

        _leaves = _buildLeavesAnimation(textureAtlas);

        _platformBigS = _buildPlatformBigSAnimation(textureAtlas);
        _platformBigN = _buildPlatformBigNAnimation(textureAtlas);
        _platformBigMid = _buildPlatformBigMidAnimation(textureAtlas);

        _bgLightPanel = _buildBgLightPanelAnimation(textureAtlas);
        _bgLightPanelTopConnector = _buildBgLightPanelTopConnector(textureAtlas);
        _bgLightPanelBottomConnector = _buildBgLightPanelBottomConnector(textureAtlas);
        _bgLightPanelHorizontalConnector = _buildBgLightPanelHorizontalConnector(textureAtlas);
        _bgLightPanelVerticalConnector = _buildBgLightPanelVerticalConnector(textureAtlas);

        _groundN = _buildGroundNAnimation(textureAtlas);
        _groundNE = _buildGroundNEAnimation(textureAtlas);
        _groundNW = _buildGroundNWAnimation(textureAtlas);
        _groundNEW = _buildGroundNEWAnimation(textureAtlas);

        _groundInnerSE = _buildGroundInnerSEAnimation(textureAtlas);
        _groundInnerSW = _buildGroundInnerSWAnimation(textureAtlas);
        _groundInnerSEW = _buildGroundInnerSEWAnimation(textureAtlas);

        _groundLeaves = _buildGroundLeavesAnimation(textureAtlas);
        _groundConsole = _buildGroundConsoleAnimation(textureAtlas);
        */

        _invisibleWall = _buildInvisibleWall();

        _area1 = _buildStageArea1();
        _addStageArea(_area1);

        _setCurrentArea(_area1);
    }

    StageArea getSprite() {
        return _area1;
    }

    Animation _buildCeilingAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ceiling");
    }

    Animation _buildLeavesAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "leaves");
    }

    Animation _buildPlatformBigSAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "platform_big_s");
    }

    Animation _buildPlatformBigNAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "platform_big_n");
    }

    Animation _buildPlatformBigMidAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "platform_big_mid");
    }

    Animation _buildBgLightPanelAnimation(TextureAtlas textureAtlas) {
        return _buildAnimation(textureAtlas, [
                new Frame(.25, "light_panel_1"),
                new Frame(.25, "light_panel_2"),
                new Frame(.25, "light_panel_3"),
                new Frame(.25, "light_panel_4"),
                ]);
    }

    Animation _buildBgLightPanelTopConnector(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "light_panel_connector_up_small");
    }

    Animation _buildBgLightPanelBottomConnector(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "light_panel_connector_down_small");
    }

    Animation _buildBgLightPanelHorizontalConnector(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "light_panel_connector_horizontal");
    }

    Animation _buildBgLightPanelVerticalConnector(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "light_panel_connector_vertical");
    }

    Animation _buildGroundNAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ground_n");
    }

    Animation _buildGroundLeavesAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ground_leaves");
    }

    Animation _buildGroundConsoleAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ground_metal");
    }

    Animation _buildGroundNWAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ground_nw");
    }

    Animation _buildGroundNEAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ground_ne");
    }

    Animation _buildGroundNEWAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ground_new");
    }

    Animation _buildGroundInnerSEAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ground_inner_se");
    }

    Animation _buildGroundInnerSWAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ground_inner_sw");
    }

    Animation _buildGroundInnerSEWAnimation(TextureAtlas textureAtlas) {
        return _buildSingleFrameAnimation(textureAtlas, "ground_inner_sew");
    }

    Animation _buildInvisibleWall() {
        bool loop = false;
        Animation animation = new Animation(loop);

        animation.add(new SpriteAnimable(4, new BitmapData(1, Game.CANVAS_HEIGHT)));
        return animation;
    }

    Animation _buildSingleFrameAnimation(TextureAtlas textureAtlas, String spriteName) {
        bool loop = false;

        return _buildAnimation(textureAtlas, [
                new Frame(30, spriteName)
                ], loop);
    }

    Animation _buildAnimation(TextureAtlas textureAtlas, List<Frame> frames, [bool loop = true]) {
        Animation animation = new Animation(loop);
        String prefix = "top_";

        for (Frame frame in frames) {
            animation.add(new SpriteAnimable(frame.getTime(),
                    textureAtlas.getBitmapData("${prefix}${frame.getName()}")));
        }

        return animation;
    }


    StageArea _buildStageArea1() {
        int stageStartX = 128;
        int stageStartY = Game.CANVAS_HEIGHT - 140;
        int bgColor = 0xFF3FBFFF;

        StageArea area = new StageArea(bgColor, stageStartX, stageStartY);

        area.addMapSprite(new MapSprite(0, 0, _invisibleWall));

        area.addMapSprite(new MapSprite(0, 0, _macroCeiling1));
        area.addMapSprite(new MapSprite(176, 48, _macroCeiling2));
        area.addMapSprite(new MapSprite(496, 48, _macroCeiling2));
        area.addMapSprite(new MapSprite(816, 48, _macroCeiling2));
        area.addMapSprite(new MapSprite(1136, 48, _macroCeiling2));

        area.addMapSprite(new MapSprite(0, 368, _macroGround1));
        area.addMapSprite(new MapSprite(624, 304, _macroGroundRamp1));
        area.addMapSprite(new MapSprite(688, 240, _macroGroundRamp2));
        area.addMapSprite(new MapSprite(1392, 272, _macroGroundRamp3));

        area.addMapSprite(new MapSprite(1584, 208, _macroPlatform1));
        area.addMapSprite(new MapSprite(1776, 144, _macroPlatform2));

        area.addMapSprite(new MapSprite(1968, 0, _macroWall1));

        area.pack();

        return area;
    }

    /*
    StageArea _buildStageArea1() {
        int stageStartX = 128;
        int stageStartY = Game.CANVAS_HEIGHT - 140;

        num curX = 0;
        num curY = 0;
        StageArea area = new StageArea(stageStartX, stageStartY);

        area.addMapSprite(new MapSprite(0, 0, _invisibleWall));

        for (num i = 0; i < 4; i++) {
            area.addMapSprite(new MapSprite(curX, curY, _ceiling));
            curX += _ceiling.getCurrentFrame().width;
            area.addMapSprite(new MapSprite(curX, curY, _platformBigS));
            curX += _platformBigS.getCurrentFrame().width;
        }

        for (num i = 0; i < 3; i++) {
            area.addMapSprite(new MapSprite(curX, curY, _ceiling));
            curX += _ceiling.getCurrentFrame().width;
        }

        curX = 16;
        curY = _ceiling.getCurrentFrame().height;
        area.addBgSprite(new MapSprite(curX, curY, _bgLightPanelTopConnector));
        curY += _bgLightPanelTopConnector.getCurrentFrame().height;
        area.addBgSprite(new MapSprite(curX, curY, _bgLightPanel));
        curY += _bgLightPanel.getCurrentFrame().height;
        area.addBgSprite(new MapSprite(curX, curY, _bgLightPanel));
        curY += _bgLightPanel.getCurrentFrame().height;
        area.addBgSprite(new MapSprite(curX, curY, _bgLightPanelBottomConnector));


        num groundBottomY = Game.CANVAS_HEIGHT - _groundLeaves.getCurrentFrame().height;
        curX = 0;
        curY = groundBottomY - _groundN.getCurrentFrame().height;
        for (num i = 0; i < 10; i++) {
            area.addMapSprite(new MapSprite(curX, curY, _groundN));
            curX += _groundN.getCurrentFrame().width;
        }

        num groundStepY = curY - _groundNW.getCurrentFrame().height;
        area.addMapSprite(new MapSprite(curX, curY, _groundInnerSE));
        area.addMapSprite(new MapSprite(curX, groundStepY, _groundNW));

        curX += _groundN.getCurrentFrame().width;

        num leavesBottomY = groundBottomY - _leaves.getCurrentFrame().height;
        num groundTopStepInnerY = leavesBottomY - _groundInnerSEW.getCurrentFrame().height;
        num groundTopStepY = groundTopStepInnerY - _groundNEW.getCurrentFrame().height;
        area.addMapSprite(new MapSprite(curX, leavesBottomY, _leaves));
        area.addMapSprite(new MapSprite(curX, groundTopStepInnerY, _groundInnerSEW));
        area.addMapSprite(new MapSprite(curX, groundTopStepY, _groundNEW));
        curX += _groundLeaves.getCurrentFrame().width;

        area.addMapSprite(new MapSprite(curX, curY, _groundInnerSW));
        area.addMapSprite(new MapSprite(curX, groundStepY, _groundNE));
        curX += _groundInnerSE.getCurrentFrame().width;

        for (num i = 0; i < 9; i++) {
            area.addMapSprite(new MapSprite(curX, curY, _groundN));
            curX += _groundN.getCurrentFrame().width;
        }

        num platformBigMidY = Game.CANVAS_HEIGHT - _platformBigMid.getCurrentFrame().height;
        num platformBigNY = platformBigMidY - _platformBigN.getCurrentFrame().height;
        area.addMapSprite(new MapSprite(curX, platformBigMidY, _platformBigMid));
        area.addMapSprite(new MapSprite(curX, platformBigNY, _platformBigN));
        curX += _platformBigMid.getCurrentFrame().width;

        for (num i = 0; i < 6; i++) {
            area.addMapSprite(new MapSprite(curX, curY, _groundN));
            curX += _groundN.getCurrentFrame().width;
        }

        curX = 0;
        num groundLeavesWidth = _groundLeaves.getCurrentFrame().width;

        area.addMapSprite(new MapSprite(curX, groundBottomY, _groundLeaves));
        curX += groundLeavesWidth;
        area.addMapSprite(new MapSprite(curX, groundBottomY, _groundConsole));
        curX += groundLeavesWidth;

        for (num i = 0; i < 4; i++) {
            for (num j = 0; j < 4; j++) {
                area.addMapSprite(new MapSprite(curX, groundBottomY, _groundLeaves));
                curX += groundLeavesWidth;
            }
            area.addMapSprite(new MapSprite(curX, groundBottomY, _groundConsole));
            curX += groundLeavesWidth;
        }

        area.pack();

        return area;
    }
    */
}
