module BaseUI.Rating (view, init, initWithConfig, update, Action, Model) where

import Html exposing (Html, div, span, text, Attribute)
import Html.Attributes exposing (attribute, classList)
import Html.Events exposing (on, onClick)
import Json.Decode exposing (succeed)
import Signal exposing (Signal, Message)
import Array
import Json.Decode as Json

import BaseUI.Rating.Config as Config exposing (Config)
import BaseUI.Rating.Model as Model exposing (init)


type alias Model = 
  { value : Int
  , config : Config
  }


init = Model.init
initWithConfig = Model.initWithConfig


type Action
  = SetValue Int


update : Action -> Model -> Model
update action model =
  case action of 
    SetValue value ->
      { model | value = value }
      

view : Signal.Address Action -> Model -> Html
view address model =
  let
    classes = [ ("BelleRating", True) ] ++ [ (model.config.theme, True) ]

    createStar = (\rating -> viewStar address model rating)
    arrayOfStars = Array.initialize model.config.maxRating createStar
    stars = Array.toList arrayOfStars
  in
    div
      [ classList classes ]
      stars


viewStar : Signal.Address Action -> Model -> Int -> Html
viewStar address model value = 
  span 
    [ onClick address (SetValue value) ]
    [ text "★" ]

