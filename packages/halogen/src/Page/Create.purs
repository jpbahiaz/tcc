module Page.Create where

import Prelude

import CSS.Border (border, borderRadius, solid)
import CSS.Color (white)
import CSS.Display (display, flex)
import CSS.Flexbox (column, flexFlow, nowrap)
import CSS.Font (fontSize)
import CSS.Geometry (height, marginBottom, padding, width)
import CSS.Size (pct, px)
import Data.Maybe (Maybe(..))
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Class.Console (log)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.CSS (style)
import Halogen.HTML.Events (onClick, onValueInput)
import Halogen.HTML.Properties (placeholder)
import Halogen.Store.Connect (Connected, connect)
import Halogen.Store.Monad (class MonadStore, updateStore)
import Halogen.Store.Select (Selector, selectEq)
import Service.Navigate (class Navigate, navigate)
import Service.Route (Route(..))
import Shared.Html (PageSize(..), page)
import Shared.Styles (Style)
import Store as Store
import Type.Proxy (Proxy(..))
import Web.Event.Event (preventDefault)
import Web.UIEvent.MouseEvent (MouseEvent, toEvent)

type Input = Unit

type State =
  { currentId :: Int
  , fields :: { name :: String, description :: String }
  }

data Action
  = GoBack MouseEvent
  | Receive (Connected Context Input)
  | CreateRecipe MouseEvent
  | ChangeName String
  | ChangeDescription String

type Slot p = forall query. H.Slot query Void p

type Context = Int

deriveState :: Connected Context Input -> State
deriveState { context } =
  { currentId: context
  , fields : { name: "", description: ""}
  }

_create = Proxy :: Proxy "create"

styles ::
  { form :: Style
  , input :: Style
  , textarea :: Style
  }
styles =
  { form: style do
      display flex 
      flexFlow column nowrap
      border solid (px 1.0) white
      borderRadius (px 5.0) (px 5.0) (px 5.0) (px 5.0)
      padding (px 10.0) (px 10.0) (px 10.0) (px 10.0)
      width $ pct 95.0
      height $ pct 100.0

  , input: style do
      marginBottom (px 20.0)
      fontSize $ px 24.0
  , textarea: style do
      fontSize $ px 20.0
      height $ pct 100.0
      marginBottom $ px 10.0
  }

selectCurrentId :: Selector Store.Store Context
selectCurrentId = selectEq _.currentId

component :: forall q o m.
  Navigate m
  => MonadEffect m
  => MonadStore Store.Action Store.Store m
  => H.Component q Input o m
component = connect selectCurrentId $
  H.mkComponent
  { initialState: deriveState
  , render
  , eval: H.mkEval $ H.defaultEval
    { handleAction = handleAction
    , receive = Just <<< Receive
    }
  }
  where
        render :: forall slots . State -> H.ComponentHTML Action slots m
        render _ =
                  page Medium (Just "Criar Receita") $
                    [ 
                      HH.form 
                        [styles.form]
                        [ HH.input
                            [ styles.input
                            , placeholder "Nome da receita"
                            , onValueInput ChangeName
                            ]
                        , HH.textarea
                            [ styles.textarea
                            , placeholder "Insira a receita aqui"
                            , onValueInput ChangeDescription
                            ]
                        , HH.button [ onClick CreateRecipe ] [ HH.text "Criar" ]
                        , HH.br_
                        , HH.button [ onClick GoBack ] [ HH.text "Voltar" ]
                        ]
                    ]

        handleAction :: forall out. Action -> H.HalogenM State Action () out m Unit
        handleAction =
          case _ of
               GoBack e -> do
                  liftEffect $ preventDefault $ toEvent e
                  navigate Home
               Receive input -> do
                  H.put $ deriveState input
               ChangeName val -> do
                  H.modify_ \st -> st { fields = st.fields { name = val }}
               ChangeDescription val -> do
                  H.modify_ \st -> st { fields = st.fields { description = val }}
               CreateRecipe e -> do
                  liftEffect $ preventDefault $ toEvent e
                  st <- H.get
                  liftEffect $ log $ show st
                  updateStore $ Store.RecipeEdited {
                    id: st.currentId + 1,
                    name: st.fields.name,
                    description: st.fields.description
                  } 
                  navigate $ Show $ show $ st.currentId + 1
