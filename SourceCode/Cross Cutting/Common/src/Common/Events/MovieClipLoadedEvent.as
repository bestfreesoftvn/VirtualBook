package Common.Events
{
    import flash.events.Event;

    public class MovieClipLoadedEvent extends Event
    {
        public static const MOVIE_CLIP_LOADED:String = "MovieClipLoadedEvent";

        public function MovieClipLoadedEvent(type:String = MOVIE_CLIP_LOADED, bubbles:Boolean = false, cancelable:Boolean = false)
        {
            super(type, bubbles, cancelable);
        }
    }
}