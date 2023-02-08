package;

import kha.math.FastVector2;

import Animation.AnimationType;
import utils.Random;
import kha.Assets;
import kha.Color;
import kha.graphics2.Graphics;
import kha.Image;

import kha.input.Mouse;
class Game {
    public static var TIMER:Timer;

    public var flashlightImage:Image;
    public var playerImage:Image;
    public var mouse:FastVector2;

    public var playerAnimation:Animation;

	public function new() {
        Game.TIMER = new Timer();

        flashlightImage = Assets.images.flashlight;
        playerImage = Assets.images.player;

        mouse = new FastVector2();

        playerAnimation = new Animation();
        playerAnimation.setImage(playerImage);
        playerAnimation.setAnimationType(AnimationType.Loop);
        playerAnimation.addFrame({x: 0,y: 0, w: 16, h:16, lifetime: 1/60*4});
        playerAnimation.addFrame({x: 16,y: 0, w: 16, h:16, lifetime: 1/60*4});
        playerAnimation.addFrame({x: 32,y: 0, w: 16, h:16, lifetime: 1/60*4});
        playerAnimation.addFrame({x: 48,y: 0, w: 16, h:16, lifetime: 1/60*30});


		Mouse.get().notify(null, null, onMouseMove, null);

	}

    public function update(): Void {
        Game.TIMER.update();
        playerAnimation.update();
    }

	public function draw(graphics: Graphics): Void {


        graphics.begin(true, Color.fromBytes(48, 11, 70));
		graphics.color = Color.Red;
        graphics.fillRect(70,80,60,40);
		graphics.color = Color.White;

        graphics.drawScaledImage(flashlightImage,mouse.x-175,mouse.y-100,flashlightImage.width+Random.randomRangeFloat(-2,2),flashlightImage.height+Random.randomRangeFloat(-2,2));        
        playerAnimation.drawCurrentFrame(graphics,Math.floor(mouse.x-16),Math.floor(mouse.y-5));

        graphics.end();		


	}
    public function onMouseMove(x:Int, y:Int, cx:Int, cy:Int){
            if (x > 0){
                mouse.x = x/Config.GAME_SCALE;
            }
            if (y > 0){
                mouse.y = y/Config.GAME_SCALE;
            }
        }
}
