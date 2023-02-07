package;

import kha.math.FastVector2;
import kha.Assets;
import kha.Color;
import kha.graphics2.Graphics;
import kha.Image;

import kha.Shaders;
import kha.graphics4.PipelineState;
import kha.graphics4.VertexData;
import kha.graphics4.VertexStructure;
import kha.graphics4.ConstantLocation;


import kha.input.Mouse;
class Game {
    public static var TIMER:Timer;

	public var backbuffer:Image;
    public var flashlightImage:Image;
    public var playerImage:Image;
    public var mouse:FastVector2;

	var resolution:FastVector2;
	var widthID:ConstantLocation;
	var heightID:ConstantLocation;
	var pipeline:PipelineState;
    
	public function new() {
		resolution = new FastVector2(Config.GAME_WIDTH, Config.GAME_HEIGHT);
        Game.TIMER = new Timer();
		backbuffer = Image.createRenderTarget(Config.GAME_WIDTH, Config.GAME_HEIGHT);

        flashlightImage = Assets.images.flashlight;
        playerImage = Assets.images.player;
        mouse = new FastVector2();
		Mouse.get().notify(null, null, onMouseMove, null);

		setupShader();
	}

    public function update(): Void {
        Game.TIMER.update();
       trace( Game.TIMER.deltaTime);
    }

	public function draw(graphics: Graphics): Void {
		
        backbuffer.g2.begin(true, Color.Transparent);
        backbuffer.g2.pipeline = pipeline;
		backbuffer.g4.setFloat(widthID, 179);
        backbuffer.g4.setFloat(heightID,100);
		backbuffer.g2.color = Color.Red;

        backbuffer.g2.fillRect(0,0,Config.GAME_WIDTH,Config.GAME_HEIGHT);

		backbuffer.g2.color = Color.White;
        backbuffer.g2.pipeline = null;
        backbuffer.g2.end();

        // backbuffer.g1.begin();
        // // for (x in (Math.floor(mouse.x) -50)...Math.floor(mouse.x)) {
        // //     for(y in Math.floor(mouse.y)-50...Math.floor(mouse.y)+50){
        // //         if(x>0 && y> 0 && x<Config.GAME_WIDTH && y < Config.GAME_HEIGHT){
        // //             backbuffer.g1.setPixel(x,y,Color.Transparent);
        // //         }
        // //     }
        // // };
        // backbuffer.g1.end();


        graphics.begin(true, Color.fromBytes(48, 11, 70));
		graphics.color = Color.Red;
        graphics.fillRect(70,80,60,40);
		graphics.color = Color.White;
        
        graphics.opacity = 1;
        graphics.drawImage(backbuffer,0,0);

        graphics.opacity = 1;
        
        graphics.drawSubImage(playerImage,mouse.x-16,mouse.y-5,48,0,16,16);
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

        function setupShader(){
            pipeline = new PipelineState();
            pipeline.vertexShader = Shaders.painter_colored_vert;
            pipeline.fragmentShader = Shaders.shaderTest_frag;
    
            var structure = new VertexStructure();
            structure.add('vertexPosition', VertexData.Float3);
            structure.add('vertexColor', VertexData.Float4);
    
            pipeline.inputLayout = [structure];
    
            pipeline.compile();
            widthID = pipeline.getConstantLocation('width');
            heightID = pipeline.getConstantLocation('height');
    
        }
}
