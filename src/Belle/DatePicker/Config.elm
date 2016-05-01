module Belle.DatePicker.Config (Config, DateTuple, setMinDate, setMaxDate, setTheme, defaultConfig, defaultTime) where

import Date exposing (Date)
import Time exposing (Time, every, hour)


type alias DateTuple =
  ( Int, Int, Int )


type alias Config =
  { minDate : DateTuple
  , maxDate : DateTuple
  , theme : String
  }


setMinDate : ( Int, Int, Int ) -> Config -> Config
setMinDate minDate config =
  { config | minDate = minDate }


setMaxDate : ( Int, Int, Int ) -> Config -> Config
setMaxDate maxDate config =
  { config | maxDate = maxDate }


setTheme : String -> Config -> Config
setTheme theme config =
  { config | theme = theme }


defaultConfig : Config
defaultConfig =
  { minDate = ( 30, 1, 2015 )
  , maxDate = ( 30, 1, 2017 )
  , theme = "defaultTheme"
  }


defaultTime : Signal Time
defaultTime =
  Time.every Time.hour
