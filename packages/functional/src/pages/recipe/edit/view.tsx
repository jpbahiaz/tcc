import { IOProps } from "react-compose-io";
import { EditRecipeIO } from "./io";

type Props = {};

export function EditRecipeView({ _io }: IOProps<EditRecipeIO, Props>) {
  return (
    <div>
      <div>Hi from edit recipe {_io.recipeId}</div>
    </div>
  );
}
