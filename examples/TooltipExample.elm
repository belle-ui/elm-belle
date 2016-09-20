module TooltipExample exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.App as App
import Belle.Tooltip as Tooltip


type alias Model =
  { firstTooltip: Tooltip.State }


init : Model
init =
  { firstTooltip = False }



type Msg
  = NoOp
  | UpdateTooltip Tooltip.Msg


update : Msg -> Model -> Model
update msg model =
  case msg of
    NoOp ->
      model

    UpdateTooltip msg ->
      { model | firstTooltip = Tooltip.update msg model.firstTooltip}


view : Model -> Html Msg
view model =
  let
    content = div [] [ text "hey I'm a tooltip" ]
    trigger = div [] [ text "Hover me pls" ]
    tooltip = Tooltip.view model.firstTooltip (trigger, content)
  in
    div
      []
      [ div [] [ App.map UpdateTooltip tooltip ] ]


main =
  App.beginnerProgram { model = init , view = view , update = update }
