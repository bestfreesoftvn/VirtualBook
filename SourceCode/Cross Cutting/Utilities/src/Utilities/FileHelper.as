package Utilities
{
    import flash.display.BitmapData;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.geom.Matrix;
    import flash.utils.ByteArray;
    import mx.graphics.codec.PNGEncoder;

    public class FileHelper
    {
        public static function validFileName(file:String):String
        {
            var pt:RegExp = /\\/g;
            var validFileName:String = file.replace(pt, "/");
            return validFileName;
        }

        public static function getAllFileInFolder(folder:String, fileType:String):Array
        {
            var desktop:File = File.applicationDirectory.resolvePath(folder);
            var files:Array = desktop.getDirectoryListing();
            var ret:Array = new Array();
            for (var i:uint = 0; i < files.length; i++)
            {
                if (files[i].nativePath.indexOf(fileType) != -1)
                {
                    var file:String;
                    if (files[i].nativePath.indexOf("\\") != -1)
                    {
                        file = files[i].nativePath.replace(File.applicationDirectory.nativePath + "\\", "");
                        ret.push(file);
                    }
                    else if (files[i].nativePath.indexOf("/") != -1)
                    {
                        file = files[i].nativePath.replace(File.applicationDirectory.nativePath + "/", "");
                        ret.push(file);
                    }
                }
            }
            return ret;
        }

        public static function getNativePathInApplicationFolder(file:String):String
        {
            return File.applicationDirectory.resolvePath(file).nativePath;
        }

        public static function saveImageToPngFile(bitmapData:BitmapData, path:String):void
        {
            var ec:PNGEncoder = new PNGEncoder();
            var file:File = File.documentsDirectory.resolvePath(path);
            var ba:ByteArray = ec.encode(bitmapData);
            var fileAccess:FileStream = new FileStream();
            fileAccess.open(file, FileMode.WRITE);
            fileAccess.writeBytes(ba, 0, ba.length);
            fileAccess.close();
        }

        public static function saveResizeImageToPngFile(bitmapData:BitmapData, newWidth:uint, newHeight:uint, path:String):void
        {
            var bd:BitmapData = new BitmapData(newWidth, newHeight, true, 0x0);

            var mt:Matrix = new Matrix();
            mt.scale(newWidth / bitmapData.width, newHeight / bitmapData.height);
            bd.draw(bitmapData, mt);

            var ec:PNGEncoder = new PNGEncoder();
            var file:File = File.documentsDirectory.resolvePath(path);
            var ba:ByteArray = ec.encode(bd);
            var fileAccess:FileStream = new FileStream();
            fileAccess.open(file, FileMode.WRITE);
            fileAccess.writeBytes(ba, 0, ba.length);
            fileAccess.close();
        }

        public static function getFilePathInDocumentFolder(nativeFilePath:String):String
        {
            return File.documentsDirectory.resolvePath(nativeFilePath).nativePath;
        }
    }
}