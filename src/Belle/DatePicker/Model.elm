module Belle.DatePicker.Model (Model, init, initWithConfig) where

import Date exposing (Date)
import Belle.DatePicker.Config exposing (Config, DateTuple, defaultConfig)
import Belle.DatePicker.Helpers exposing (validateDate)

type alias Model =
  { value : DateTuple
  , suggesting : DateTuple
  , config : Config
  }


init : DateTuple -> Model
init value =
  { value = validateDate value
  , suggesting = validateDate value
  , config = defaultConfig
  }


initWithConfig : DateTuple -> Config -> Model
initWithConfig value config =
  { value = validateDate value
  , suggesting = validateDate value
  , config = config
  }