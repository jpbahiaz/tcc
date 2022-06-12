import { selectRecipes } from "../../redux/modules/recipes/selectors";
import { useAppSelector } from "../../redux/store";

export function homeIO() {
  const recipes = useAppSelector(selectRecipes);
  return {
    recipes,
  };
}

export type HomeIO = ReturnType<typeof homeIO>;
