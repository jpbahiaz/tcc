import { IOProps } from "react-compose-io";
import { ShowRecipeIO } from "./io";

type Props = {};

export function ShowRecipeView({ _io }: IOProps<ShowRecipeIO, Props>) {
  return (
    <div>
      <div>Hi from show recipe {_io.recipeId}</div>
    </div>
  );
}
