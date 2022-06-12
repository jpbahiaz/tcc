import { IOProps } from "react-compose-io";
import { HomeIO } from "./io";

type Props = {};

export function HomeView({ _io }: IOProps<HomeIO, Props>) {
  return (
    <div>
      <h1>Receitas</h1>
      {_io.recipes.map((recipe) => (
        <div key={recipe.name}>{recipe.name}</div>
      ))}
    </div>
  );
}
