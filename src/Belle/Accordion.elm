module Belle.Accordion (Accordion, view, css) where

import Html exposing (Html, Attribute, div)
import Html.Attributes exposing (attribute)
import Html.Events exposing (on)
import Signal exposing (Message)
import Json.Decode
import Css exposing (..)
import Css.Elements as Css
import Html.CssHelpers exposing (namespace)

type CssClasses =
  AccordionContentCollapsed | AccordionContentExpanded | AccordionHeader | AccordionEntry

{ class, classList, id } = Html.CssHelpers.namespace ""

css =
  (stylesheet)
    [ (.) AccordionContentCollapsed
        [ Css.height (px 960) ]
    , (.) AccordionContentExpanded
        [ Css.height (px 0) ]
    , (.) AccordionHeader
        [ ]
    , (.) AccordionEntry
        [ ]
    ]

{-| Functions which indicate how to display your `entry` type as an
accordion section.

`viewHeader` and `viewPanel` will be called with each `entry` to render
the title and body of a particular accordion section, respectively.
These functions will be passed a single `entry` and should render it
appropriately. In the simplest case, just use `Html.text` to render text only,
but you might also want to render (for example) an icon in the header or
structured paragraphs in the body.

`setExpanded` will be called to translate header clicks into `Message` values, so you can
update your model as appropriate. It receives a `Bool` indicating whether
the given `entry` is to become expanded, followed by the `entry` itself.

`getExpanded` will be called with an `entry` to determine whether it ought
to be displayed in expanded form.
-}
type alias Accordion entry =
  { viewHeader : entry -> Html
  , viewPanel : entry -> Html
  , setExpanded : Bool -> entry -> Message
  , getExpanded : entry -> Bool
  }


{-| Render an Accordion view.

An accordion is rendered as a list of sections, each with a header and body, and each
with a notion of whether it is expanded or collapsed. When the user clicks
a given header, the accordion sends a `Message` requesting that the section
in question swap its expandedness/collapsedness.

Provide a list of `entry` values, and an `Accordion` record that indicates
how we can display an `entry` as an accordion section.
-}
view : Accordion entry -> List entry -> Html
view accordion entries =
  let
    viewEntry entry =
      let
        expanded =
          accordion.getExpanded entry

        contentClass =
          if expanded then AccordionContentExpanded else AccordionContentCollapsed

        entryHeader =
          div
            [ class [ AccordionHeader ]
            , on
                "click"
                (Json.Decode.succeed ())
                (\_ -> accordion.setExpanded (not expanded) entry)
            ]
            [ accordion.viewHeader entry ]

        entryContent =
          div
            [ class [ contentClass ], role "tabpanel" ]
            [ accordion.viewPanel entry ]
      in
        div
          [ class [ AccordionEntry ]
          , role "tab"
          ]
          [ entryHeader, entryContent ]
  in
    div
      [ role "tablist"
      , attribute "aria-live" "polite"
      ]
      (List.map viewEntry entries)



{- Convenience for making tuples. Looks nicer in conjunction with classList. -}


(=>) : a -> b -> ( a, b )
(=>) =
  (,)



{- Convenience for defining role attributes, e.g. <div role="tabpanel"> -}


role : String -> Attribute
role =
  attribute "role"
