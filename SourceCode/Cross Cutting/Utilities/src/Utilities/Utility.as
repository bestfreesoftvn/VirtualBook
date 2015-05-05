package Utilities {
    import flash.utils.describeType;
    import flash.utils.getDefinitionByName;

    public class Utility
    {
        public function Utility()
        {
        }

        public static function getAllProperties(cls:Class):Array
        {
            var items:Array = new Array();
            var description:XML = describeType(cls);

            for each (var a:XML in description.accessor)
            {
                items.push(a.@name);
            }

            return items;
        }

        public static function getAllVariables(cls:Class):Array
        {
            var items:Array = new Array();
            var description:XML = describeType(cls);

            for each (var a:XML in description.factory.variable)
            {
                items.push(a.@name);
            }

            return items;
        }

        public static function getAllConstants(cls:Class):Array
        {
            var items:Array = new Array();
            var description:XML = describeType(cls);

            for each (var a:XML in description.constant)
            {
                items.push(a.@name);
            }

            return items;
        }

        public static function traceClassInfo(cls:Class):void
        {
            var consts:Array = new Array();
            var description:XML = describeType(cls);
            trace(description);
        }

        public static function getPackageName(cls:Class):String
        {
            var description:XML = describeType(cls);
            var typeName:String = description.type.@name;

            for each (var a:XML in description)
            {
                typeName = a.@name;
                break;
            }

            return typeName.substring(0, typeName.indexOf("::"));
        }

        public static function getClassByName(className:String):Class
        {
            var classReference:Class = getDefinitionByName(className) as Class;

            return classReference;
        }


        public static function uintToString(n:uint, length:uint):String
        {
            var s:String = n.toString();
            while (s.length < length)
            {
                s = "0" + s;
            }
            return s;
        }

        public static function randomRange(minNum:Number, maxNum:Number):Number
        {
            return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
        }

    }
}