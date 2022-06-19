import { ChangeEvent, MouseEvent, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { recipesActions } from "../../../redux/modules/recipes/slice";
import { useAppDispatch, useAppSelector } from "../../../redux/store";
import { css } from "../../../shared/styles";

const styles = {
  form: css({
    display: "flex",
    flexFlow: "column",
    border: "1px solid white",
    borderRadius: "5px",
    padding: "10px",
    width: "95%",
    height: "100%"
  }),
  input: css({
    marginBottom: "20px",
    fontSize: "24px"
  }),
  textarea: css({
    fontSize: "20px",
    height: "100%",
    marginBottom: "10px"
  })
}

export function editRecipeIO() {
  const { recipeId } = useParams();
  const recipe = useAppSelector(state => state.recipes.byId[recipeId || ""])
  const navigate = useNavigate()
  const [fields, setFields] = useState(recipe || { name: "", description: "" })
  const dispatch = useAppDispatch()

  return {
    styles,
    fields,
    recipe,
    goBack: (e: MouseEvent) => {
      e.preventDefault()
      navigate("/")
    },
    onFieldChange: (e: ChangeEvent<HTMLInputElement> | ChangeEvent<HTMLTextAreaElement>) => {
      setFields(prev => ({ ...prev, [e.target.name]: e.target.value }))
    },
    onEditRecipe: (e: MouseEvent) => {
      e.preventDefault()
      dispatch(recipesActions.recipeEdited(fields))
      navigate("/recipe/" + recipeId)
    }
  };
}

export type EditRecipeIO = ReturnType<typeof editRecipeIO>;
