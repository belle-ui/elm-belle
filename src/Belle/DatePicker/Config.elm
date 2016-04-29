module Belle.DatePicker.Config (Config, setMinDate, setMaxDate, setTheme, defaultConfig, defaultTime) where

import Date exposing (Date)
import Time exposing (Time, every, hour)
import Belle.DatePicker.Helpers exposing (maybeDate)

type alias Config =
  { minDate : Maybe Date
  , maxDate : Maybe Date
  , theme : String
  }


setMinDate : String -> Config -> Config
setMinDate minDate config =
  { config | minDate = maybeDate minDate }


setMaxDate : String -> Config -> Config
setMaxDate maxDate config =
  { config | maxDate = maybeDate maxDate }


setTheme : String -> Config -> Config
setTheme theme config =
  { config | theme = theme }


defaultConfig : Config
defaultConfig =
  { minDate = maybeDate "2015/1/1"
  , maxDate = maybeDate "2017/1/1"
  , theme = "defaultTheme"
  }


defaultTime : Signal Time
defaultTime =
  Time.every Time.hour