import { useParams } from "react-router-dom";

export function editRecipeIO() {
  const { recipeId } = useParams();
  return { recipeId };
}

export type EditRecipeIO = ReturnType<typeof editRecipeIO>;
