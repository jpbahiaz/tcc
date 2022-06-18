import { createSelector } from "@reduxjs/toolkit";
import { RootState } from "../../store";

export const selectRecipes = createSelector(
  (state: RootState) => {
    return state.recipes.byId;
  },
  (state: RootState) => {
    return state.recipes.userRecipes;
  },
  (_: any, currentUser: string) => currentUser,
  (recipesById, userRecipes, currentUser) => {
    const recipes = userRecipes[currentUser] || [] 
    return recipes.map((id) => {
      return recipesById[id];
    });
  }
);
