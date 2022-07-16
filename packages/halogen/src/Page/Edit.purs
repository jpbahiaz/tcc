module Page.Edit where

import Prelude

import CSS (marginBottom)
import CSS.Border (border, borderRadius, solid)
import CSS.Color (white)
import CSS.Display (display, flex)
import CSS.Flexbox (column, flexFlow, nowrap)
import CSS.Font (fontSize)
import CSS.Geometry (height, marginBottom, padding, width)
import CSS.Size (pct, px)
import Data.Either (Either(..))
import Data.Int (fromString)
import Data.Map as Map
import Data.Maybe (Maybe(..))
import Data.Recipe (Recipes, Recipe)
import Data.String.Regex (Regex, regex, split)
import Data.String.Regex.Flags (noFlags)
import Effect.Class (liftEffect)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.CSS (style)
import Halogen.HTML.Events (onClick)
import Halogen.Store.Connect (Connected, connect)
import Halogen.Store.Monad (class MonadStore)
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

type State = { id :: String, recipes :: Recipes }

data Action
  = GoBack MouseEvent
  | Receive (Connected Context Input)

type Slot p = forall query. H.Slot query Void p

type Context = Recipes

deriveState :: Connected Context Input -> State
deriveState { input, context } = { id: input, recipes: context }

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
  => MonadStore Store.Action Store.Store m
  => H.Component q Input o m
component = connect selectRecipes $
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
        render state =
          case maybeRecipe of
               Just recipe -> do
                  page Medium Nothing $
                    [ 
                      HH.form 
                        [styles.form]
                        (description recipe)
                    , HH.button [ onClick GoBack ] [ HH.text "Salvar" ]
                    , HH.br_
                    , HH.button [ onClick GoBack ] [ HH.text "Voltar" ]
                    ]
               Nothing -> do
                  page Small (Just "Receita não existe") $
                    [
                      HH.button [ onClick GoBack ] [ HH.text "Voltar" ]
                    ]
            where
                  maybeRecipe :: Maybe Recipe 
                  maybeRecipe = do
                     intId <- fromString state.id
                     Map.lookup intId state.recipes
                  description :: forall w i . Recipe -> Array (HH.HTML w i)
                  description rec = do 
                     partial <- do
                        case reg of
                          Right rx -> split rx rec.description
                          Left _ -> []
                     [HH.text partial, HH.br_]
                     where
                        reg :: Either String Regex
                        reg = regex "\n|\r\n" noFlags
                           

        handleAction :: forall out. Action -> H.HalogenM State Action () out m Unit
        handleAction =
          case _ of
               GoBack e -> do
                  liftEffect $ preventDefault $ toEvent e
                  navigate Home
               Receive input -> do
                  H.put $ deriveState input

