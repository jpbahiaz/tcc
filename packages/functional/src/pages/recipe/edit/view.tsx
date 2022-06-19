import { IOProps } from "react-compose-io";
import { MediumPage, SmallPage } from "../../../shared/components/page";
import { EditRecipeIO } from "./io";

type Props = {};

export function EditRecipeView({ _io }: IOProps<EditRecipeIO, Props>) {
  return _io.recipe ? (
    <MediumPage title="">
      <form style={_io.styles.form}>
        <input
          style={_io.styles.input}
          onChange={_io.onFieldChange}
          name="name"
          type="text"
          placeholder="Nome da receita"
          value={_io.fields.name}
        />
        <textarea
          style={_io.styles.textarea}
          onChange={_io.onFieldChange}
          name="description"
          placeholder="Insira a receita aqui"
          value={_io.fields.description}
        />
        <button onClick={_io.onEditRecipe}>Salvar</button>
        <br />
        <button onClick={_io.goBack}>Voltar</button>
      </form>
    </MediumPage>
  ) : (
    <SmallPage title="Receita não existe" >
      <button onClick={_io.goBack}>Voltar</button>
    </SmallPage>
  );
}
