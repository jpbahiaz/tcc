import { useEffect } from "react";
import { Route, Routes, useNavigate } from "react-router-dom";
import { Home } from "./pages/home";
import { Login } from "./pages/login";
import { CreateRecipe } from "./pages/recipe/create";
import { EditRecipe } from "./pages/recipe/edit";
import { ShowRecipe } from "./pages/recipe/show";
import { useAppSelector } from "./redux/store";

function App() {
  const currentUser = useAppSelector(state => state.auth.currentUser)
  const navigate = useNavigate()

  useEffect(() => {
    if (!currentUser) {
      navigate("/login")
    }
  }, [currentUser])

  return (
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/recipe/create" element={<CreateRecipe />} />
        <Route path="/recipe/:recipeId" element={<ShowRecipe />} />
        <Route path="/recipe/edit/:recipeId" element={<EditRecipe />} />
      </Routes>
  );
}

export default App;
