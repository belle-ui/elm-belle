module Belle.DatePicker.Model (Model, init, initWithConfig) where

import Date exposing (Date)
import Belle.DatePicker.Config exposing (Config, defaultConfig)
import Belle.DatePicker.Helpers exposing (maybeDate)

type alias Model =
  { value : Maybe Date
  , suggesting : Maybe Date
  , config : Config
  }


init : String -> Model
init value =
  { value = maybeDate value
  , suggesting = maybeDate value
  , config = defaultConfig
  }


initWithConfig : String -> Config -> Model
initWithConfig value config =
  { value = maybeDate value
  , suggesting = maybeDate value
  , config = config
  }