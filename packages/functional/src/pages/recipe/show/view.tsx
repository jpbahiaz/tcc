import { Fragment } from "react";
import { IOProps } from "react-compose-io";
import { Page, SmallPage } from "../../../shared/components/page";
import { ShowRecipeIO } from "./io";

type Props = {};

export function ShowRecipeView({ _io }: IOProps<ShowRecipeIO, Props>) {
  return _io.recipe ? (
    <Page title={_io.recipe.name}>
      <div style={_io.styles.description}>
        {_io.recipe.description.split(/\n|\r\n/).map((frag, index) => (
          <Fragment key={index}>
            {frag}
            <br />
          </Fragment>
        ))}
      </div>
      <button onClick={_io.goBack}>Voltar</button>
    </Page>
  ) : (
    <SmallPage title="Receita não existe" >
      <button onClick={_io.goBack}>Voltar</button>
    </SmallPage>
  );
}
