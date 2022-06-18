import { IOProps } from "react-compose-io";
import { CreateRecipeIO } from "./io";

type Props = {};

export function CreateRecipeView({ _io }: IOProps<CreateRecipeIO, Props>) {
  return (
    <div>
      <div>Hi from create recipe {_io.recipeId}</div>
    </div>
  );
}
