module Data.Recipe where

import Data.Map (Map)

type Recipe = 
  { id :: Int
  , name :: String
  , description :: String
  }

type Recipes = Map Int Recipe
