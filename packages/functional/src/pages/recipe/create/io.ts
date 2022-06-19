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

export function createRecipeIO() {
  const currentUser = useAppSelector(state => state.auth.currentUser)
  const [fields, setField] = useState({
    name: "",
    description: ""
  })
  const dispatch = useAppDispatch()
  const navigate = useNavigate()

  return {
    styles,
    onFieldChange: (e: ChangeEvent<HTMLInputElement> | ChangeEvent<HTMLTextAreaElement>) => {
      setField(prev => ({ ...prev, [e.target.name]: e.target.value }))
    },
    onCreateRecipe: (e: MouseEvent) => {
      e.preventDefault()
      dispatch(recipesActions.recipeCreated({ recipe: fields, user: currentUser }))
      navigate("/")
    },
    goBack: () => {
      navigate("/")
    }
  };
}

export type CreateRecipeIO = ReturnType<typeof createRecipeIO>;
