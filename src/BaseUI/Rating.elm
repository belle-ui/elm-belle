module BaseUI.Rating (view, update, Action, Model, init, initWithConfig) where

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (classList)
import Html.Events exposing (on, onClick)
import Signal exposing (Signal, Message)
import Array
import BaseUI.Rating.Config as Config exposing (Config)
import BaseUI.Rating.Model as Model exposing (init)


{-| Model
-}
type alias Model =
  { value : Int
  , config : Config
  }


init =
  Model.init


initWithConfig =
  Model.initWithConfig


{-| UPDATE
-}
type Action
  = SetValue Int


update : Action -> Model -> Model
update action model =
  case action of
    SetValue value ->
      { model | value = value }


{-| VIEW
-}
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
