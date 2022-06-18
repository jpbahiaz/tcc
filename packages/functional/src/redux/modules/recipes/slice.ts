import { createSlice } from "@reduxjs/toolkit";
import { RecipesState } from "./types";

const initialState: RecipesState = {
  byId: { "uga-id-1": { name: "Receita teste" } },
  userRecipes: {}
};

const recipesSlice = createSlice({
  name: "recipes",
  initialState,
  reducers: {},
});

export const recipesReducer = recipesSlice.reducer;
export const recipesActions = recipesSlice.actions;
