module Page.Home where

import Prelude

import CSS.Background (background)
import CSS.Border (border, borderRadius, solid)
import CSS.Color (white)
import CSS.Common (auto)
import CSS.Cursor (cursor, pointer)
import CSS.Display (display, flex)
import CSS.Flexbox (JustifyContentValue(..), flexFlow, justifyContent, nowrap, row, spaceBetween)
import CSS.Font (fontSize)
import CSS.Geometry (height, margin, marginBottom, marginLeft, marginRight, marginTop, padding, width)
import CSS.Overflow (Overflow(..), overflowY)
import CSS.Size (pct, px)
import Data.Array (concat, length)
import Data.Maybe (Maybe(..))
import Data.Recipe (Recipe)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.CSS (style)
import Shared.Html (PageSize(..), page)
import Shared.Styles (Style, container)
import Type.Proxy (Proxy(..))

type Slot p = forall query. H.Slot query Void p

_home = Proxy :: Proxy "home"

styles ::
  { recipe :: Style
  , separator :: Style
  , title :: Style
  , list :: Style
  , actions :: Style
  , action :: Style
  }
styles =
  { recipe: style do
      cursor pointer
      display flex
      flexFlow row nowrap
      justifyContent $ JustifyContentValue spaceBetween
      margin (px 15.0) (px 15.0) (px 15.0) (px 15.0) 
  ,
    separator: style do
      width $ pct 90.0
      height $ px 1.0
      background white
      marginTop $ px 0.0
      marginBottom $ px 0.0
      marginLeft auto
      marginRight auto
  ,
    title: style do
      fontSize $ px 30.0
  ,
    list: style do
      width $ pct 95.0
      margin (px 10.0) (px 10.0) (px 10.0) (px 10.0)
      padding (px 10.0) (px 10.0) (px 10.0) (px 10.0)
      border solid (px 1.0) white
      borderRadius (px 5.0) (px 5.0) (px 5.0) (px 5.0)
      overflowY $ Overflow auto
  ,
    actions: style do
      marginTop auto
      width $ pct 100.0
  ,
    action: style do
      fontSize $ px 22.0
      width $ pct 100.0
  }

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
  { initialState: identity
  , render
  , eval: H.mkEval H.defaultEval
  }

render :: forall state action m. state -> H.ComponentHTML action () m
render _ =
  HH.div
    [ container ]
    [ page Large (Just "Receitas") $
        HH.div
          [styles.list]
          (recipes [ { name: "Bolo do Galba", id: "uga", description: "Descrição Galba" } ])
    ]
    where
          recipes :: forall w i . Array Recipe -> Array (HH.HTML w i)
          recipes list
            | length list == 0 = [ HH.strong_ [ HH.text "Você não possui receitas" ] ]
            | otherwise = 
              let 
                recipeList =
                  map
                    (\recipe -> 
                      HH.div
                        [styles.recipe]
                        [ HH.div_ [ HH.text recipe.name ]
                        , HH.button_ [ HH.text "Editar" ]
                        ]
                    )
                    $ list
              in
              concat [ recipeList, [ HH.div [styles.separator] [] ] ]
