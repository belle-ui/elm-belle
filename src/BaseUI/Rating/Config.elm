module BaseUI.Rating.Config (Config, defaultConfig, setMaxRating) where

type alias Config = Model

type alias Model = 
  { maxRating : Int
  , theme : String
  }

setMaxRating : Int -> Config -> Config
setMaxRating maxRating config =
  { config | maxRating = maxRating }


defaultConfig : Config
defaultConfig =
  { maxRating = 6
  , theme = "defaultTheme" }