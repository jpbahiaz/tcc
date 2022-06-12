import { composeIO } from "react-compose-io";
import { editRecipeIO } from "./io";
import { EditRecipeView } from "./view";

export const EditRecipe = composeIO(EditRecipeView, editRecipeIO);
