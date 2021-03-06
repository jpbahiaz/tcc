module Page.Edit where

import Prelude

import CSS.Border (border, borderRadius, solid)
import CSS.Color (white)
import CSS.Display (display, flex)
import CSS.Flexbox (column, flexFlow, nowrap)
import CSS.Font (fontSize)
import CSS.Geometry (height, marginBottom, padding, width)
import CSS.Size (pct, px)
import Data.Int (fromString)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Recipe (Recipes, Recipe)
import Effect.Class (class MonadEffect, liftEffect)
import Effect.Class.Console (log)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.CSS (style)
import Halogen.HTML.Events (onClick, onValueInput)
import Halogen.HTML.Properties (value)
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

type Input = String

type State =
  { id :: String
  , recipes :: Recipes
  , fields :: { name :: String, description :: String }
  }

data Action
  = GoBack MouseEvent
  | Receive (Connected Context Input)
  | Initialize
  | Save MouseEvent
  | ChangeName String
  | ChangeDescription String

type Slot p = forall query. H.Slot query Void p

type Context = Recipes

deriveState :: Connected Context Input -> State
deriveState { input, context } =
  { id: input
  , recipes: context
  , fields : { name: "", description: ""}
  }

_edit = Proxy :: Proxy "edit"

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

selectRecipes :: Selector Store.Store Context
selectRecipes = selectEq _.recipes

component :: forall q o m.
  Navigate m
  => MonadEffect m
  => MonadStore Store.Action Store.Store m
  => H.Component q Input o m
component = connect selectRecipes $
  H.mkComponent
  { initialState: deriveState
  , render
  , eval: H.mkEval $ H.defaultEval
    { handleAction = handleAction
    , receive = Just <<< Receive
    , initialize = Just Initialize
    }
  }
  where
        render :: forall slots . State -> H.ComponentHTML Action slots m
        render state =
          case maybeRecipe of
               Just recipe -> do
                  page Medium Nothing $
                    [ 
                      HH.form 
                        [styles.form]
                        [ HH.input [styles.input, value recipe.name, onValueInput ChangeName]
                        , HH.textarea
                            [ styles.textarea
                            , value recipe.description
                            , onValueInput ChangeDescription
                            ]
                        , HH.button [ onClick Save ] [ HH.text "Salvar" ]
                        , HH.br_
                        , HH.button [ onClick GoBack ] [ HH.text "Voltar" ]
                        ]
                    ]
               Nothing -> do
                  page Small (Just "Receita n??o existe") $
                    [
                      HH.button [ onClick GoBack ] [ HH.text "Voltar" ]
                    ]
            where
                  maybeRecipe :: Maybe Recipe 
                  maybeRecipe = do
                     intId <- fromString state.id
                     Map.lookup intId state.recipes
                         

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
               Save e -> do
                  liftEffect $ preventDefault $ toEvent e
                  st <- H.get
                  liftEffect $ log $ show st
                  case (maybeId st) of
                       Just id -> do
                          updateStore $ Store.RecipeEdited {
                            id,
                            name: st.fields.name,
                            description: st.fields.description
                          } 
                          navigate $ Show st.id
                       Nothing -> do
                          liftEffect $ log "Could not parse id"


               Initialize -> do 
                  state <- H.get
                  case (findRecipe state) of
                       Just rec -> do
                          H.modify_ \st -> st {
                            fields = st.fields {
                              name = rec.name,
                              description = rec.description
                            }
                          }
                       Nothing -> do
                          liftEffect $ log "No recipe was found"
          where        
            maybeId :: State -> Maybe Int
            maybeId state = fromString state.id

            findRecipe :: State -> Maybe Recipe 
            findRecipe st = do
               intId <- maybeId st
               Map.lookup intId st.recipes

            



