import { CSSProperties, MouseEvent } from "react";
import { useNavigate } from "react-router-dom";
import { selectRecipes } from "../../redux/modules/recipes/selectors";
import { useAppSelector } from "../../redux/store";

const styles: Record<string, CSSProperties> = {
  container: {
    width: "100vw",
    height: "100vh",
    display: "flex",
    flexFlow: "column",
    justifyContent: "center",
    alignItems: "center"
  },
  recipes: {
    display: "flex",
    flexFlow: "column",
    border: "1px solid white",
    borderRadius: "5px",
    padding: "10px",
    width: "70vw",
    height: "80vh"
  },
  recipe: {
    display: "flex",
    flexFlow: "row",
    justifyContent: "space-between",
    margin: "15px",
  },
  separator: {
    width: "90%",
    height: "1px",
    // margin: "0 auto",
    background: "white",
    margin: "0 auto"
  },
  title: {
    fontSize: "30px"
  },
  list: {
    margin: "10px",
    padding: "10px",
    border: "1px solid white",
    borderRadius: "5px",
    overflowY: "auto"
  },
  actions: {
    marginTop: "auto",
    width: "100%"
  },
  action: {
    fontSize: "22px",
    width: "100%"
  }
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
      console.log("onCreateRecipe")
    }
  };
}

export type HomeIO = ReturnType<typeof homeIO>;
