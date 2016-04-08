module Stylesheets (..) where

import Css.File exposing (..)
import Belle.Accordion as Accordion
import Belle.Button as Button
import Belle.Rating as Rating


port files : CssFileStructure
port files =
  toFileStructure
    [ ( "accordion-example.css", compile Accordion.css )
    , ( "button-example.css", compile Button.css )
    , ( "rating-example.css", compile Rating.css )
    ]
