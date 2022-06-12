import { useParams } from "react-router-dom";

export function showRecipeIO() {
  const { recipeId } = useParams();
  return { recipeId };
}

export type ShowRecipeIO = ReturnType<typeof showRecipeIO>;
