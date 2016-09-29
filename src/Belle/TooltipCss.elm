module Belle.TooltipCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (div)

content =
  [ display block
  , position absolute
  , backgroundColor (rgb 10 10 10)
  , color (rgb 255 255 255)
  , padding (px 10)
  , borderRadius (px 2)
  ]

hiddenContent =
  [ display none ]
