package;

import kha.Assets;
import kha.Image;
import kha.Scheduler;
import kha.System;
import kha.Scaler;
class Main {
	
	public static function main() {

		System.start({title: Config.GAME_TITLE, width: Config.GAME_WIDTH*Config.GAME_SCALE, height: Config.GAME_HEIGHT*Config.GAME_SCALE}, function (_) {
			Assets.loadEverything(function () {

				var game:Game = new Game();
				var backbuffer:Image = Image.createRenderTarget(Config.GAME_WIDTH, Config.GAME_HEIGHT);

				Scheduler.addTimeTask(function () { game.update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (frames) {
					
					//render on backbuffer
					var graphics = backbuffer.g2;
					game.draw(graphics);	

					//render on window frame
					frames[0].g2.begin(true, Color.fromBytes(48, 11, 70));
					Scaler.scale(backbuffer, frames[0], System.screenRotation);
					frames[0].g2.end();
				
				});
			});
		});
	}
}
