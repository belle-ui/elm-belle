module Belle.Tooltip (view, update, Action, Model, init, initWithConfig, defaultConfig, Config, setTheme) where

import Html exposing (Html, Attribute, span, div)
import Html.Attributes exposing (classList)
import Html.Events exposing (onMouseEnter, onMouseLeave)


-- Config


type alias Config =
  { theme : String
  }


setTheme : String -> Config -> Config
setTheme theme config =
  { config | theme = theme }


defaultConfig : Config
defaultConfig =
  { theme = "defaultTheme"
  }



-- Model


type alias Model =
  { config : Config
  , content : Html
  , tooltip : Html
  , active : Bool
  }


init : Html -> Html -> Model
init content tooltip =
  { config = defaultConfig
  , content = content
  , tooltip = tooltip
  , active = False
  }


initWithConfig : Html -> Html -> Config -> Model
initWithConfig content tooltip config =
  { config = config
  , content = content
  , tooltip = tooltip
  , active = False
  }



-- Update


type Action
  = ShowTooltip
  | HideTooltip


update : Action -> Model -> Model
update action model =
  case action of
    ShowTooltip ->
      { model | active = True }

    HideTooltip ->
      { model | active = False }


view : Signal.Address Action -> Model -> Html
view address model =
  let
    classes =
      [ ( "BelleTooltip", True ) ] ++ [ ( model.config.theme, True ) ]

    tooltip =
      if model.active == True then
        [ model.content, model.tooltip ]
      else
        [ model.content ]
  in
    div
      [ classList classes
      , onMouseEnter address ShowTooltip
      , onMouseLeave address HideTooltip
      ]
      tooltip
