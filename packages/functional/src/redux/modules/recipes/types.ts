export type Recipe = {
  id: string
  name: string;
  description: string;
};

export type NewRecipe = {
  name: string;
  description: string;
}

export type RecipesState = {
  byId: Record<string, Recipe>;
  userRecipes: Record<string, string[]>
};
