module Store where

import Prelude

import Data.Map as Map
import Data.Recipe (Recipe, Recipes)
import Data.Tuple (Tuple(..))

type Store =
  { currentUser :: String
  , currentId :: Int
  , recipes :: Recipes
  }

initialStore :: Store
initialStore =
  { currentUser: "user"
  , currentId: 0
  , recipes: Map.fromFoldable [
    Tuple 412 { name: "Bolo do Galba", id: 412, description: "Descrição Galba\nlets bora\nlets go" }
  ]
  }

data Action
  = RecipeEdited Recipe
  | RecipeCreated Recipe

reduce :: Store -> Action -> Store
reduce store =
    case _ of
       RecipeCreated recipe -> do
          store
            { recipes = Map.insert (store.currentId + 1) recipe store.recipes
            , currentId = store.currentId + 1 
            }
       RecipeEdited recipe -> do
          store { recipes = Map.insert recipe.id recipe store.recipes }
