package Common
{
    import Common.Events.MovieClipLoadedEvent;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.ImageDecodingPolicy;
    import flash.system.LoaderContext;

    public class MovieClipContainer extends EventDispatcher
    {
        private var _movieClip:MovieClip;
        private var _loader:Loader;
        private var _context:LoaderContext;
        private var _loop:Boolean;
        private var _autoPlay:Boolean;
        private var _cacheAsBitmap:Boolean;

        public function MovieClipContainer(movieClip:MovieClip = null)
        {
            _movieClip = movieClip;
            _loader = null;
            _context = new LoaderContext();
            _context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
            _context.applicationDomain = ApplicationDomain.currentDomain;
            _context.allowCodeImport = true;
            _loop = false;
            _autoPlay = false;
            _cacheAsBitmap = false;
        }

        public function startMovieClip(loop:Boolean = false):void
        {
            _loop = loop;
            playMovieClip();
        }

        public function stopMovieClip():void
        {
            if (_movieClip.isPlaying)
            {
                _movieClip.stop();
            }
            _movieClip.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        public function createMovieClipFromEmbedFile(mvCls:Class, cacheAsBitmap = false,
                                                     autoPlay:Boolean = false, loop:Boolean = false):void
        {
            initLoader();
            _cacheAsBitmap = cacheAsBitmap;
            _movieClip = null;
            _autoPlay = autoPlay;
            _loop = loop;
            _loader.loadBytes(new mvCls(), _context);
        }

        public function createMovieClipFromExternalFile(filePath:String, cacheAsBitmap = false,
                                                        autoPlay:Boolean = false, loop:Boolean = false):void
        {
            initLoader();
            _cacheAsBitmap = cacheAsBitmap;
            _movieClip = null;
            _autoPlay = autoPlay;
            _loop = loop;
            var req:URLRequest = new URLRequest(filePath);
            _loader.load(req, _context);
        }

        public function getMovieClipImage(width:Number, height:Number):Bitmap
        {
            var bmp:Bitmap = null;
            if (_movieClip != null)
            {
                var bmpData:BitmapData = new BitmapData(width, height, true, 0x00000000);
                bmpData.draw(_movieClip);
                bmp = new Bitmap(bmpData);
            }

            return bmp;
        }

        private function initLoader():void
        {
            if(_loader == null)
            {
                _loader = new Loader();
                _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadCompleted);
            }
        }

        public function getDefaultMovieClipImage():Bitmap
        {
            var bmp:Bitmap = null;
            if (_movieClip != null)
            {
                var bmpData:BitmapData = new BitmapData(Math.floor(_movieClip.width),
                        Math.floor(_movieClip.height), true, 0x00000000);

                bmpData.draw(_movieClip);
                bmp = new Bitmap(bmpData);
            }

            return bmp;
        }

        public function getMovieClip():MovieClip
        {
            return _movieClip;
        }

        private function playMovieClip():void
        {
            if(_movieClip != null)
            {
                stopMovieClip();
                _movieClip.addEventListener(Event.ENTER_FRAME, onEnterFrame);
                _movieClip.play();
            }
        }

        private function onLoadCompleted(e:Event):void
        {
            _movieClip = _loader.content as MovieClip;
            _movieClip.width = _loader.contentLoaderInfo.width;
            _movieClip.height = _loader.contentLoaderInfo.height;
            _movieClip.cacheAsBitmap = _cacheAsBitmap;
            if (_autoPlay)
            {
                playMovieClip();
            }
            dispatchEvent(new MovieClipLoadedEvent());
        }

        private function onEnterFrame(e:Event):void
        {
            if (_movieClip.currentFrame == _movieClip.totalFrames)
            {
                if (!_loop)
                {
                    stopMovieClip();
                }
            }
        }
    }
}