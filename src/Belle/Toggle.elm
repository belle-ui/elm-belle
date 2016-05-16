module Belle.Toggle exposing (view, update, Msg, Model, init, initWithConfig, defaultConfig, Config, setTheme)

import Html exposing (Html, Attribute, div)
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
  , checked: Bool
  , content: Html Msg 
  }


init : Html Msg -> Model
init content =
  { config = defaultConfig
  , content = content
  , checked = False
  }


initWithConfig : Bool -> Html Msg -> Config -> Model
initWithConfig checked content config =
  { config = config
  , content = content
  , checked = checked
  }

-- Update

type Msg 
  = Toggle

update : Msg -> Model -> Model
update msg model =
  case msg of

    Toggle ->
      { model | checked = not model.checked }


-- View

view : Model -> Html Msg
view model =
  let
    classes =
      [ ( "BelleToggle", True ) ] ++ [ ( model.config.theme, True ) ]
  in
    div
      [ classList classes
      , onClick Toggle ]
      [ model.content ]
