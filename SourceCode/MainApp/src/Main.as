package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.setTimeout;
	import starling.core.Starling;

	[SWF(width="960",height="640",frameRate="60",backgroundColor="#2f2f2f")]
	public class Main extends Sprite
	{
		private var myStarling:Starling;
		public function Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			setTimeout(initApp,100);
		}

		/**INIT*/
		private function initApp():void
		{
			myStarling = new Starling(Game,stage);
			myStarling.showStats=true;
			myStarling.start();
		}
	}
}