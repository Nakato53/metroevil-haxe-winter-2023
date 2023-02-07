package;

import utils.Random;
import kha.math.Vector2;
import kha.graphics2.Graphics1;
import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.graphics2.Graphics;
import kha.Image;

import kha.input.Mouse;
class Game {
    public static var TIMER:Timer;

	public var backbuffer:Image;
    public var flashlightImage:Image;
    public var playerImage:Image;
    public var mouse:Vector2;

	public function new() {
        Game.TIMER = new Timer();
		backbuffer = Image.createRenderTarget(Config.GAME_WIDTH, Config.GAME_HEIGHT);

        flashlightImage = Assets.images.flashlight;
        playerImage = Assets.images.player;
        mouse = new Vector2(0,0);
		Mouse.get().notify(null, null, onMouseMove, null);

	}

    public function update(): Void {
        Game.TIMER.update();
       trace( Game.TIMER.deltaTime);
    }

	public function draw(graphics: Graphics): Void {
		
        backbuffer.g2.begin(true, Color.Transparent);
        
		backbuffer.g2.color = Color.Black;
        backbuffer.g2.fillRect(0,0,Config.GAME_WIDTH,Config.GAME_HEIGHT);
		backbuffer.g2.color = Color.White;
        backbuffer.g2.end();

        backbuffer.g1.begin();
        // for (x in (Math.floor(mouse.x) -50)...Math.floor(mouse.x)) {
        //     for(y in Math.floor(mouse.y)-50...Math.floor(mouse.y)+50){
        //         if(x>0 && y> 0 && x<Config.GAME_WIDTH && y < Config.GAME_HEIGHT){
        //             backbuffer.g1.setPixel(x,y,Color.Transparent);
        //         }
        //     }
        // };
        for(x in 0...50){
            for(y in 0...50){
                backbuffer.g1.setPixel(x,y,Color.Transparent);
            }
        }
        backbuffer.g1.end();


        graphics.begin(true, Color.fromBytes(48, 11, 70));
		graphics.color = Color.Red;


        graphics.fillRect(70,80,60,40);
        
		graphics.color = Color.White;
        
        graphics.opacity = 1;
        graphics.drawSubImage(playerImage,mouse.x-16,mouse.y-5,48,0,16,16);
        
      //  graphics.opacity = 0.5;
        graphics.drawImage(backbuffer,0,0);
      //  graphics.drawScaledImage(flashlightImage,mouse.x-175,mouse.y-100,flashlightImage.width+Random.randomRangeFloat(-2,2),flashlightImage.height+Random.randomRangeFloat(-2,2));
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
