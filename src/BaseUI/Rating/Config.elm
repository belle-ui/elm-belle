module BaseUI.Rating.Config (Config, defaultConfig, setMaxRating, setTheme) where


type alias Config =
  Model


type alias Model =
  { maxRating : Int
  , theme : String
  }


setMaxRating : Int -> Config -> Config
setMaxRating maxRating config =
  { config | maxRating = maxRating }


setTheme : String -> Config -> Config
setTheme theme config =
  { config | theme = theme }


defaultConfig : Config
defaultConfig =
  { maxRating = 6
  , theme = "defaultTheme"
  }
