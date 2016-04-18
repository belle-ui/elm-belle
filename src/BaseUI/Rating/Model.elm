module BaseUI.Rating.Model (Model, init, initWithConfig) where

import BaseUI.Rating.Config as Config exposing (Config)


type alias Model =
  { value : Int
  , config : Config
  }


init : Int -> Model
init value =
  { value = value
  , config = Config.defaultConfig
  }


initWithConfig : Int -> Config -> Model
initWithConfig value config =
  { value = value
  , config = config
  }
