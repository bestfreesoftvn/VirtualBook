package assets
{
	import flash.display.Bitmap;
	import Utilities.Utility;

	public class AssetBase
	{
		public static const EnglishLanguage:String = "en_US";
		public static var language:String;
		public function AssetBase()
		{			
		}
		
		public virtual function generateImage(name:String):Bitmap
		{
			return null;
		}
		
		public virtual function getClass():Class
		{
			return AssetBase;
		}
		
		public virtual function getVariableClassByName(name:String):Class
		{
			return null;
		}
		
		public function generateImageByClass(cls:Class):Bitmap
		{
			return new cls() as Bitmap;
		}
		
		public function generateAllImages():Array
		{
			var images:Array = new Array();
			var items:Array = Utility.getAllVariables(getClass());
			items.sort();
			for each (var item:String in items) 
			{
				images.push(generateImage(item));
			}
			
			
			return images;
		}
		
		public function getAllVariableClasses():Array
		{
			var classes:Array = new Array();
			var items:Array = Utility.getAllVariables(getClass());
			items.sort();
			
			for each (var item:String in items) 
			{
				classes.push(getVariableClassByName(item));
			}
			
			
			return classes;
		}
		
		public function getAllVariableNames():Array
		{
			var classes:Array = new Array();
			var items:Array = Utility.getAllVariables(getClass());
			items.sort();
			
			for each (var item:String in items) 
			{
				classes.push(item);
			}
			
			
			return classes;
		}
	}
}