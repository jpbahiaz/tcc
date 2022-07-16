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
import Data.Array (concat, fromFoldable, length)
import Data.Map (values)
import Data.Maybe (Maybe(..))
import Data.Recipe (Recipe, Recipes)
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
import Shared.Styles (Style, container)
import Store as Store
import Type.Proxy (Proxy(..))
import Web.Event.Event (preventDefault, stopPropagation)
import Web.UIEvent.MouseEvent (MouseEvent, toEvent)

type Slot p = forall query. H.Slot query Void p

type Input = Unit

data Action
  = CreateRecipe
  | ShowRecipe Int MouseEvent 
  | EditRecipe Int MouseEvent 
  | Receive (Connected Context Input)

type State = { recipes :: Recipes }

type Context = Recipes

deriveState :: Connected Context Input -> State
deriveState { context } = { recipes: context }

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
      HH.div
        [ container ] 
        [ page Large (Just $ "Receitas") $
          [
            HH.div
              [ styles.list ]
              (recipes $ fromFoldable $ values state.recipes)
          , HH.div
              [ styles.actions ]
              [ HH.button
                  [ styles.action, onClick \_ -> CreateRecipe ]
                  [ HH.text "Criar Receita" ]
              ]
          ]
        ]
        where
              recipes :: forall widget . Array Recipe -> Array (HH.HTML widget Action)
              recipes list
                | length list == 0 = [ HH.strong_ [ HH.text "Você não possui receitas" ] ]
                | otherwise = 
                  let 
                    recipeList =
                      map
                        (\recipe -> 
                          [ HH.div
                              [styles.recipe, onClick $ ShowRecipe recipe.id ]
                              [ HH.div_ [ HH.text recipe.name ]
                              , HH.button [ onClick $ EditRecipe recipe.id ] [ HH.text "Editar" ]
                              ]
                          , HH.div [styles.separator] [] 
                          ]
                        )
                        $ list
                  in
                  concat recipeList

    handleAction :: forall slots output . Action -> H.HalogenM State Action slots output m Unit
    handleAction =
      case _ of
           CreateRecipe -> do
              navigate Create
           ShowRecipe id e -> do
              liftEffect $ preventDefault $ toEvent e
              navigate $ Show $ show id
           EditRecipe id e -> do
              liftEffect $ preventDefault $ toEvent e
              liftEffect $ stopPropagation $ toEvent e
              navigate $ Edit $ show id
           Receive input -> do
              H.put $ deriveState input
