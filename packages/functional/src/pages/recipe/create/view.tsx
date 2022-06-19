import { IOProps } from "react-compose-io";
import { MediumPage } from "../../../shared/components/page";
import { CreateRecipeIO } from "./io";

type Props = {};

export function CreateRecipeView({ _io }: IOProps<CreateRecipeIO, Props>) {
  return (
    <MediumPage title="Criar Receita">
      <form style={_io.styles.form}>
        <input style={_io.styles.input} onChange={_io.onFieldChange} name="name" type="text" placeholder="Nome da receita" />
        <textarea style={_io.styles.textarea} onChange={_io.onFieldChange} name="description" placeholder="Insira a receita aqui" />
        <button onClick={_io.onCreateRecipe}>Criar</button>
        <br />
        <button onClick={_io.goBack}>Voltar</button>
      </form>
    </MediumPage>
  );
}
