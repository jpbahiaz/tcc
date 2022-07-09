module Page.About where

import Prelude

import Halogen as H
import Halogen.HTML as HH
import Type.Proxy (Proxy(..))

type Slot p = forall query. H.Slot query Void p

_about = Proxy :: Proxy "about"

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
  { initialState: identity
  , render
  , eval: H.mkEval H.defaultEval
  }

render :: forall state action m. state -> H.ComponentHTML action () m
render _ = HH.h1_ [ HH.text "About Page" ]
