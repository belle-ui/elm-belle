module Belle.Rating (view, update, Action, Model, init, initWithConfig, defaultConfig, Config, setTheme, setMaxRating) where

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (classList)
import Html.Events exposing (onClick)
import Signal exposing (Signal, Message)
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


type Action
  = SetValue Int


update : Action -> Model -> Model
update action model =
  case action of
    SetValue value ->
      { model | value = value }



-- View


view : Signal.Address Action -> Model -> Html
view address model =
  let
    classes =
      [ ( "BelleRating", True ) ] ++ [ ( model.config.theme, True ) ]

    createStar =
      (\rating -> viewStar address model rating)

    arrayOfStars =
      Array.initialize model.config.maxRating createStar

    stars =
      Array.toList arrayOfStars
  in
    div
      [ classList classes ]
      stars


viewStar : Signal.Address Action -> Model -> Int -> Html
viewStar address model value =
  span
    [ onClick address (SetValue value) ]
    [ text "★" ]
