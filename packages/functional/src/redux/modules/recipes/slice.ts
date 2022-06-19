import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { NewRecipe, Recipe, RecipesState } from "./types";
import { v4 } from "uuid"

const initialState: RecipesState = {
  byId: {},
  userRecipes: {
    "jp": []
  }
};

const recipesSlice = createSlice({
  name: "recipes",
  initialState,
  reducers: {
    recipeCreated: (state, action: PayloadAction<{ recipe: NewRecipe, user: string }>) => {
      const id = v4()
      state.byId[id] = { ...action.payload.recipe, id }
      state.userRecipes[action.payload.user] ?
        state.userRecipes[action.payload.user].push(id)
        : state.userRecipes[action.payload.user] = [id]
    },
    recipeEdited: (state, action: PayloadAction<Recipe>) => {
      state.byId[action.payload.id] = action.payload
    }
  },
});

export const recipesReducer = recipesSlice.reducer;
export const recipesActions = recipesSlice.actions;
