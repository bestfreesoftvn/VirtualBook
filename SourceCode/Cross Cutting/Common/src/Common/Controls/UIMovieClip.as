package Common.Controls
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;

    import flash.display.MovieClip;
    import flash.events.Event;
    import mx.controls.SWFLoader;

    public class UIMovieClip extends SWFLoader
    {
        private var _movieClip:MovieClip;
        private  var _autoPlay:Boolean;
        private var _loop:Boolean;
        private var _cacheAsBitmap:Boolean;

        public function UIMovieClip()
        {
            super();
            initLoader();
        }

        public function  setMovieClipSource(sourcePath:String, cacheAsBitmap = false,
                                            autoPlay:Boolean = false, loop:Boolean = false):void
        {
            _cacheAsBitmap = cacheAsBitmap;
            _autoPlay = autoPlay;
            _loop = loop;
            source = sourcePath;
        }

        private function onLoadCompleted(event:Event):void
        {
            _movieClip = content as MovieClip;
            _movieClip.cacheAsBitmap = _cacheAsBitmap;
            if (_autoPlay)
            {
                playMovieClip();
            }
            else
            {
                stopMovieClip();
            }
        }

        public function set autoPlay(value:Boolean):void
        {
            _autoPlay = value;
        }

        public function get autoPlay():Boolean
        {
            return _autoPlay;
        }

        public function set loop(value:Boolean):void
        {
            _loop = value;
        }

        public function get loop():Boolean
        {
            return _loop;
        }

        public function startMovieClip(loop:Boolean = false):void
        {
            _loop = loop;
            playMovieClip();
        }

        public function stopMovieClip():void
        {
            if(_movieClip != null)
            {
                _movieClip.stop();
                _movieClip.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
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

        public function startAnimation(loop:Boolean = false):void
        {
            startMovieClip(loop);
        }

        private function initLoader():void
        {
            addEventListener(Event.COMPLETE, onLoadCompleted);
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

        private function playMovieClip():void
        {
            if(_movieClip != null)
            {
                stopMovieClip();
                _movieClip.addEventListener(Event.ENTER_FRAME, onEnterFrame);
                _movieClip.play();
            }
        }

        private function  scaleToFit():void
        {
            var mcOriginalWidth:Number = _movieClip.width;
            var mcOriginalHeight:Number = _movieClip.height;

            if (width > height)
            {
                _movieClip.scaleX = width / mcOriginalWidth;
                _movieClip.scaleY = _movieClip.scaleX;
            }
            else
            {
                _movieClip.scaleY = height / mcOriginalHeight;
                _movieClip.scaleX = _movieClip.scaleY;
            }
        }
    }
}