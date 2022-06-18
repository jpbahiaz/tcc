import React from "react";
import ReactDOM from "react-dom";
import "./index.css";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import { Login } from "./pages/login";
import { Provider } from "react-redux";
import store from "./redux/store";
import { Home } from "./pages/home";
import { ShowRecipe } from "./pages/recipe/show";
import { EditRecipe } from "./pages/recipe/edit";
import { CreateRecipe } from "./pages/recipe/create";

ReactDOM.render(
  <React.StrictMode>
    <Provider store={store}>
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Login />} />
          <Route path="/home" element={<Home />} />
          <Route path="/recipe/create" element={<CreateRecipe />} />
          <Route path="/recipe/:recipeId" element={<ShowRecipe />} />
          <Route path="/recipe/edit/:recipeId" element={<EditRecipe />} />
        </Routes>
      </BrowserRouter>
    </Provider>
  </React.StrictMode>,
  document.getElementById("root")
);
