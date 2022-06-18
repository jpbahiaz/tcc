export type Recipe = {
  name: string;
};

export type RecipesState = {
  byId: Record<string, Recipe>;
  userRecipes: Record<string, string[]>
};
