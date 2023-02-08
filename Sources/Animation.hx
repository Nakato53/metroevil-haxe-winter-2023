import kha.Image;

typedef AnimationFrame = {
    x:Int,
    y:Int,
    w:Int,
    h:Int,
    lifetime:Float
}

enum AnimationType{
    Loop;
    Bounce;
    Reverse;
}

class Animation{

    private var _frames:Array<AnimationFrame>;
    private var _currentFrameIndex:Int;
    private var _currentFrameElapsedTime:Float;
    private var _animationType:AnimationType;
    private var _animationStep:Int;
    private var _image:Image;

    public function new(){
        _frames = new Array<AnimationFrame>();
        _animationType = AnimationType.Loop;
        reset();
    }

    public function setImage(image:Image){
        _image = image;
    }

    public function setAnimationType(animationType:AnimationType){
        _animationType = animationType;
    }

    public function addFrame(frame:AnimationFrame){
        _frames.push(frame);
    }

    public function reset(){
        _currentFrameIndex = 0;
        _animationStep = 1;
        _currentFrameElapsedTime = 0;
    }

    public function update(){
        _currentFrameElapsedTime += Game.TIMER.deltaTime;
        if(_currentFrameElapsedTime > _frames[_currentFrameIndex].lifetime){
            _currentFrameElapsedTime = _currentFrameElapsedTime - _frames[_currentFrameIndex].lifetime;
            _currentFrameIndex = _currentFrameIndex + _animationStep;
            switch (_animationType){
                case Loop:
                    if(_currentFrameIndex >= _frames.length){
                        _currentFrameIndex = 0;
                    };
                case Bounce:
                    if(_currentFrameIndex >= _frames.length || _currentFrameIndex < 0){
                        _animationStep = _animationStep * -1;
                        _currentFrameIndex = _currentFrameIndex + _animationStep;
                    };
                case Reverse:
                    if(_currentFrameIndex > _frames.length){
                        _currentFrameIndex = 0;
                    };
            }
            
        }
    }

    public function getFrame():AnimationFrame{
        return _frames[_currentFrameIndex];
    }

    public function drawCurrentFrame(graphics:kha.graphics2.Graphics, x:Int, y:Int){
        var frame = getFrame();
        graphics.drawSubImage(_image,x,y,frame.x,frame.y,frame.w,frame.h);
    }

}