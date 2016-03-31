module Stylesheets (..) where

import Css.File exposing (..)
import Belle.Accordion as Accordion
import Belle.Button as Button

port files : CssFileStructure
port files =
  toFileStructure
    [ ( "accordion-example.css", compile Accordion.css )
    , ( "button-example.css", compile Button.css ) ]
