package Common
{
    import br.com.stimuli.loading.BulkLoader;
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.system.ApplicationDomain;
    import flash.system.ImageDecodingPolicy;
    import flash.system.LoaderContext;
    import flash.utils.Dictionary;

    public class MovieClipLoader extends EventDispatcher
    {
        private var _movieClips:Dictionary;
        private var _loader:BulkLoader;
        private var _context:LoaderContext;

        public function MovieClipLoader()
        {
            _movieClips = new Dictionary();
            _loader = new BulkLoader();
            _loader.addEventListener(BulkLoader.COMPLETE, onLoadCompleted);
            _context = new LoaderContext();
            _context.imageDecodingPolicy = ImageDecodingPolicy.ON_LOAD;
            _context.applicationDomain = ApplicationDomain.currentDomain;
            _context.allowCodeImport = true;
        }

        private function onLoadCompleted(e:Event):void
        {
            for (var key:String in _movieClips)
            {
                _movieClips[key] = new MovieClipContainer(_loader.getContent(key) as MovieClip);
            }
        }

        public function getMovieClipContainer(key:String):MovieClipContainer
        {
           return _movieClips[key] as MovieClipContainer;
        }

        public function addMovieClipPathToLoad(key:String, path:String):void
        {
            _movieClips[key] = null;
           _loader.add(path,  {id:key, context: _context});
        }

        public function reset():void
        {
            _movieClips.length = 0;
            _loader.removeAll();
        }

        public function start():void
        {
            _loader.start();
        }
    }
}