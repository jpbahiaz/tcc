module Shared.Styles where

import Prelude

import CSS (display, flex, flexFlow, height, justifyContent, vh, vw, width)
import CSS.Common (center)
import CSS.Flexbox (AlignItemsValue(..), JustifyContentValue(..), alignItems, column, nowrap)
import Halogen.HTML (IProp)
import Halogen.HTML.CSS (style)

type Style = forall t1 t2. IProp ( style :: String | t2 ) t1

container :: Style
container = style do
  width $ vw 100.0
  height $ vh 100.0
  display flex
  flexFlow column nowrap
  justifyContent $ JustifyContentValue center
  alignItems $ AlignItemsValue center
