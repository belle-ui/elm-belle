module Belle.Button (view, update, Action, Model, init, initWithConfig, defaultConfig, Config, setTheme) where

import Html exposing (Html, Attribute, button)
import Html.Attributes exposing (classList)


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
  }


init : Html -> Model
init content =
  { config = defaultConfig
  , content = content
  }


initWithConfig : Html -> Config -> Model
initWithConfig content config =
  { config = config
  , content = content
  }


-- Update


type Action
  = UpdateContent Html


update : Action -> Model -> Model
update action model =
  case action of
    UpdateContent content ->
      { model | content = content }


-- View


view : Signal.Address Action -> Model -> Html
view address model =
  let
    classes =
      [ ( "BelleButton", True ) ] ++ [ ( model.config.theme, True ) ]
  in
    button
      [ classList classes ]
      [ model.content ]
