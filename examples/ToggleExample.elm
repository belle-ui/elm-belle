module ToggleExample exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Belle.Toggle as Toggle
import Html.Attributes exposing (attribute, property)
import Html.App as App
import Util

type alias Model =
  { firstToggle : Toggle.Model
  , secondToggle : Toggle.Model
  }


init : Model
init =
  let
    config =
      Toggle.defaultConfig
        |> Toggle.setTheme "myfirstToggleTheme"
  in
    { firstToggle = Toggle.initWithConfig False (text "I've read the license agreement") config
    , secondToggle = Toggle.init (text "Whatever")
    }

type Msg
  = ToggleFirst Toggle.Msg
  | ToggleSecond Toggle.Msg

update : Msg -> Model -> Model
update msg previous =
  case msg of
      ToggleFirst toggleMsg ->
        let
          updatedToggle = Toggle.update toggleMsg previous.firstToggle
        in
           { previous | firstToggle = updatedToggle }

      ToggleSecond toggleMsg ->
        let
          updatedToggle = Toggle.update toggleMsg previous.secondToggle
        in
           { previous | secondToggle = updatedToggle }


view : Model -> Html Msg
view model =
  div
    []
    [ div
        []
        [ App.map ToggleFirst (Toggle.view model.firstToggle)
        , App.map ToggleSecond (Toggle.view model.secondToggle)
        , div
          []
          [ text ("firstToggle.checked: " ++ toString model.firstToggle.checked)
          , text ("secondToggle.checked: " ++ toString model.secondToggle.checked)
          ]
        ]

    , Util.stylesheetLink "/rating-example.css"
    ]


main =
  App.beginnerProgram { model = init, view = view, update = update }
