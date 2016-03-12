module AccordionExample (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Belle.Accordion as Accordion
import Signal
import StartApp.Simple as StartApp
import Util


type alias AccordionEntry =
  { id : Int
  , expanded : Bool
  , heading : String
  , body : String
  }


main =
  StartApp.start { model = entries, view = view, update = update }


entries : List AccordionEntry
entries =
  [ { id = 0, heading = "First Thing", body = "First Content", expanded = False }
  , { id = 1, heading = "Second Thing", body = "Second Content", expanded = True }
  , { id = 2, heading = "Third Thing", body = "Third Content", expanded = False }
  ]


view address entries =
  let
    accordionOpts =
      { viewHeader = .heading >> text
      , viewPanel = .body >> text
      , setExpanded = (\expanded entry -> Signal.message address (Expand entry))
      , getExpanded = .expanded
      }
  in
    div [ ]
    [ Accordion.view accordionOpts entries
    , Util.stylesheetLink "/accordion-example.css" ]


type Action
  = NoOp
  | Expand AccordionEntry


update action entries =
  case action of
    NoOp ->
      entries

    Expand entry ->
      List.map (expandIf (\{ id } -> id == entry.id)) entries


expandIf : (AccordionEntry -> Bool) -> AccordionEntry -> AccordionEntry
expandIf predicate entry =
  { entry | expanded = predicate entry }
