module Page.Login where

import Prelude

import Effect.Class (class MonadEffect, liftEffect)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events (onClick)
import Service.Navigate (class Navigate, navigate)
import Service.Route (Route(..))
import Type.Proxy (Proxy(..))
import Web.Event.Event (preventDefault)
import Web.HTML.HTMLElement (offsetHeight)
import Web.UIEvent.MouseEvent (MouseEvent, toEvent)

type Slot id = forall query . H.Slot query Void id

data Action =
  GoHome MouseEvent

_login = Proxy :: Proxy "login"

component :: forall q i o m .
  Navigate m
  => MonadEffect m
  => H.Component q i o m
component =
  H.mkComponent
    { initialState: identity
    , render 
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }
    where
      render :: forall state . state -> H.ComponentHTML Action () m
      render _ = HH.div_
        [ HH.h1_ [ HH.text "Login" ]
        , HH.button [ onClick GoHome ] [ HH.text "Go Home!"]
        ]

      handleAction :: forall state output . Action -> H.HalogenM state Action () output m Unit
      handleAction = case _ of
        GoHome e -> do
           liftEffect $ preventDefault (toEvent e)
           navigate Home

