module Belle.Button exposing (view, update, Msg, Model, init, initWithConfig, defaultConfig, Config, setTheme)

import Html exposing (Html, Attribute, button)
import Html.Attributes exposing (classList)
import Html.Events exposing (onClick)


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
  , content : Html Msg
  }


init : Html Msg -> Model
init content =
  { config = defaultConfig
  , content = content
  }


initWithConfig : Html Msg -> Config -> Model
initWithConfig content config =
  { config = config
  , content = content
  }


-- Update


type Msg
  = ClickButton


update : Msg -> Model -> Model
update msg model =
  case msg of

    ClickButton ->
      model


-- View


view : Model -> Html Msg
view model =
  let
    classes =
      [ ( "BelleButton", True ) ] ++ [ ( model.config.theme, True ) ]
  in
    button
      [ classList classes
      , onClick ClickButton ]
      [ model.content ]
