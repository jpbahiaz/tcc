import { CSSProperties, MouseEvent, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { selectRecipes } from "../../redux/modules/recipes/selectors";
import { useAppSelector } from "../../redux/store";
import { css } from "../../shared/styles";

const styles = {
  recipe: css({
    cursor: "pointer",
    display: "flex",
    flexFlow: "row",
    justifyContent: "space-between",
    margin: "15px",
  }),
  separator: css({
    width: "90%",
    height: "1px",
    // margin: "0 auto",
    background: "white",
    margin: "0 auto"
  }),
  title: css({
    fontSize: "30px"
  }),
  list: css({
    width: "95%",
    margin: "10px",
    padding: "10px",
    border: "1px solid white",
    borderRadius: "5px",
    overflowY: "auto"
  }),
  actions: css({
    marginTop: "auto",
    width: "100%"
  }),
  action: css({
    fontSize: "22px",
    width: "100%"
  })
}

export function homeIO() {
  const currentUser = useAppSelector(state => state.auth.currentUser)
  const recipes = useAppSelector(state => selectRecipes(state, currentUser));
  const navigate = useNavigate()

  return {
    styles,
    recipes,
    onCreateRecipe: (e: MouseEvent) => {
      e.preventDefault()
      navigate("/recipe/create")
    },
    onClickRecipe: (recipeId: string) => {
      navigate("/recipe/" + recipeId)
    },
    onEditRecipe: (e: MouseEvent, recipeId: string) => {
      e.preventDefault()
      e.stopPropagation()
      navigate("/recipe/edit/" + recipeId)
    }
  };
}

export type HomeIO = ReturnType<typeof homeIO>;
