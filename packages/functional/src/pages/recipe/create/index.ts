import { composeIO } from "react-compose-io";
import { createRecipeIO } from "./io";
import { CreateRecipeView } from "./view";

export const CreateRecipe = composeIO(CreateRecipeView, createRecipeIO);
