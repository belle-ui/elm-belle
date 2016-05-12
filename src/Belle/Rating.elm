module Belle.Rating exposing (view, update, Msg, Model, init, initWithConfig, defaultConfig, Config, setTheme, setMaxRating)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (classList)
import Html.Events exposing (onClick)
import Array


-- Config


type alias Config =
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



-- Model


type alias Model =
  { value : Int
  , config : Config
  }


init : Int -> Model
init value =
  { value = value
  , config = defaultConfig
  }


initWithConfig : Int -> Config -> Model
initWithConfig value config =
  { value = value
  , config = config
  }



-- Update


type Msg
  = SetValue Int


update : Msg -> Model -> Model
update action model =
  case action of
    SetValue value ->
      { model | value = value }



-- View


view : Model -> Html Msg
view model =
  let
    classes =
      [ ( "BelleRating", True ) ] ++ [ ( model.config.theme, True ) ]

    createStar =
      (\rating -> viewStar model rating)

    arrayOfStars =
      Array.initialize model.config.maxRating createStar

    stars =
      Array.toList arrayOfStars
  in
    div
      [ classList classes ]
      stars


viewStar : Model -> Int -> Html Msg
viewStar model value =
  span
    [ onClick (SetValue (value + 1)) ]
    [ text "★" ]
