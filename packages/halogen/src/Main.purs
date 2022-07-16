module Main where

import Prelude

import AppM (runAppM)
import Component.Router as Router
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Routing.Duplex (parse)
import Routing.Hash (matchesWith)
import Service.Route (routeCodec)
import Store (initialStore)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  -- Run the application
  rootComponent <- runAppM initialStore Router.component
  halogenIO <- runUI rootComponent {} body

  -- Listen to the route changes.
  void $ liftEffect $ matchesWith (parse routeCodec) \old new ->
    when (old /= Just new) $ launchAff_ do
      _response <- halogenIO.query $ H.mkTell $ Router.Navigate new
      pure unit
