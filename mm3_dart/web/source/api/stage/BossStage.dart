part of escape;

abstract class BossStage {

    List<StageArea> _areas;
    StageArea _currentArea;

    BossStage() {
        _areas = new List<StageArea>();
    }

    void _addStageArea(StageArea area) {
        _areas.add(area);
    }

    void _setCurrentArea(StageArea area) {
        _currentArea = area;
    }

    StageArea getCurentArea() {
        return _currentArea;
    }
}