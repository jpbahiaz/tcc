import { useParams } from "react-router-dom";

export function createRecipeIO() {
  const { recipeId } = useParams();
  return { recipeId };
}

export type CreateRecipeIO = ReturnType<typeof createRecipeIO>;
