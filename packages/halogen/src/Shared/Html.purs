module Shared.Html where

import Prelude

import CSS.Border (border, borderRadius, solid)
import CSS.Color (black)
import CSS.Common (auto, center)
import CSS.Display (display, flex)
import CSS.Flexbox (AlignItemsValue(..), alignItems, flexFlow, nowrap, row)
import CSS.Geometry (height, padding, width)
import CSS.Size (px, vh, vw)
import CSS.Stylesheet (StyleM)
import Data.Maybe (Maybe(..))
import Halogen.HTML as HH
import Halogen.HTML.CSS (style)
import Shared.Styles (Style, container)

data PageSize = 
    Large
  | Medium
  | Small

type PageStyle =
  { container :: Style
  , content :: Style
  }

contentStyles :: StyleM Unit
contentStyles = do
  display flex
  flexFlow row nowrap
  alignItems $ AlignItemsValue center
  border solid (px 1.0) black
  borderRadius (px 5.0) (px 5.0) (px 5.0)  (px 5.0)
  padding (px 10.0) (px 10.0) (px 10.0) (px 10.0)

page :: forall w i . PageSize -> Maybe String -> HH.HTML w i -> HH.HTML w i
page size title html = case size of
  Small ->
    renderPage
      { container: container
      , content: style do
          contentStyles
          width $ vw 30.0
          height $ auto
      } title html
  Medium ->
    renderPage
      { container: container
      , content: style do
          contentStyles
          width $ vw 50.0
          height $ vh 80.0
      } title html
  Large -> renderPage
      { container: container
      , content: style do
          contentStyles
          width $ vw 70.0
          height $ vh 80.0
      } title html


renderPage :: forall w i . PageStyle -> Maybe String -> HH.HTML w i -> HH.HTML w i
renderPage styles title html = 
  HH.div
    [ styles.container ]
    [ HH.div 
        [ styles.content ]
        [ maybeTitle title
        , html
        ]
    ]
    where
          maybeTitle :: Maybe String -> HH.HTML w i
          maybeTitle = case _ of
                            Just value -> HH.h1_ [ HH.text value ]
                            Nothing -> HH.text ""
