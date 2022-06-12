import { composeIO } from "react-compose-io";
import { showRecipeIO } from "./io";
import { ShowRecipeView } from "./view";

export const ShowRecipe = composeIO(ShowRecipeView, showRecipeIO);
