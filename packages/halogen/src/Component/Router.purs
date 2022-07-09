module Component.Router where

import Prelude

import Data.Either (hush)
import Data.Maybe (Maybe(..), fromMaybe)
import Effect.Class (class MonadEffect, liftEffect)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Page.Home as Home
import Page.Login as Login
import Routing.Duplex (parse)
import Routing.Hash (getHash)
import Service.Navigate (class Navigate, navigate)
import Service.Route (Route(..), routeCodec)
import Web.Event.Event (preventDefault)
import Web.UIEvent.MouseEvent (toEvent, MouseEvent)

type State =
  { route :: Maybe Route
  }

data Query a = Navigate Route a

data Action
  = Initialize
  | GoTo Route MouseEvent

type ChildSlots =
  ( home :: Home.Slot Unit
  , login :: Login.Slot Unit
  )

component
  :: forall i o m
  . MonadEffect m
  => Navigate m
  => H.Component Query i o m
component =
  H.mkComponent
  { initialState: const { route: Nothing }
  , render
  , eval: H.mkEval $ H.defaultEval
    { handleAction = handleAction
    , handleQuery = handleQuery
    , initialize = Just Initialize
    }
  }
  where
    -- Renders a page component depending on which route is matched.
    render :: State -> H.ComponentHTML Action ChildSlots m
    render st = case st.route of
      Nothing -> HH.h1_ [ HH.text "Oh no! That page wasn't found" ]
      Just route -> case route of
        Home -> HH.slot Home._home unit Home.component unit absurd
        Edit id -> HH.text $ "Edit " <> id
        Show id -> HH.text $ "Show " <> id
        Create -> HH.text "Create"
        Login -> HH.slot Login._login unit Login.component unit absurd

handleAction
  :: forall o m
  . MonadEffect m
  => Navigate m
  => Action
  -> H.HalogenM State Action ChildSlots o m Unit
handleAction = case _ of
  -- Handles initialization of the route
  Initialize -> do
    initialRoute <- hush <<< ( parse routeCodec ) <$> H.liftEffect getHash
    navigate $ fromMaybe Home initialRoute
  --  Handles the consecutive route changes.
  GoTo route e -> do
    liftEffect $ preventDefault ( toEvent e )
    mRoute <- H.gets _.route
    when ( mRoute /= Just route ) $ navigate route

handleQuery :: forall a o m. Query a -> H.HalogenM State Action ChildSlots o m ( Maybe a )
handleQuery = case _ of
  -- This is the case that runs every time the brower's hash route changes.
  Navigate route a -> do
    mRoute <- H.gets _.route
    when ( mRoute /= Just route ) $
      H.modify_ _ { route = Just route }
    pure ( Just a )

navbar :: forall a . HH.HTML a Action -> HH.HTML a Action
navbar html =
  HH.div_
  [ HH.ul_
    [ HH.li_
      [ HH.a
        [ HP.href "#"
        , HE.onClick ( GoTo Home )
        ]
        [ HH.text "Home" ]
      ]
    ]
  , html
  ]
