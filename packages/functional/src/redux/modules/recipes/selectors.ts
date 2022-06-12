import { createSelector } from "@reduxjs/toolkit";
import { RootState } from "../../store";

export const selectRecipes = createSelector(
  (state: RootState) => {
    return state.recipes.byId;
  },
  (recipesById) => {
    return Object.keys(recipesById).map((id) => {
      return recipesById[id];
    });
  }
);
