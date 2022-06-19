import { MouseEvent } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { useAppSelector } from "../../../redux/store";
import { css } from "../../../shared/styles";

const styles = {
  description: css({
    padding: "0 50px",
    marginBottom: "30px"
  })
}

export function showRecipeIO() {
  const { recipeId } = useParams();
  const recipe = useAppSelector(state => state.recipes.byId[recipeId || ''])
  const navigate = useNavigate()

  return {
    styles,
    recipe,
    goBack: (e: MouseEvent) => {
      e.preventDefault()
      navigate("/")
    }
  };
}

export type ShowRecipeIO = ReturnType<typeof showRecipeIO>;
