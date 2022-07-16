import { Fragment } from "react";
import { IOProps } from "react-compose-io";
import { Page } from "../../shared/components/page";
import { container } from "../../shared/styles";
import { HomeIO } from "./io";

type Props = {};

export function HomeView({ _io }: IOProps<HomeIO, Props>) {
  return (
    <div style={container}>
      <Page title="Receitas">
        <div style={_io.styles.list}>
          {_io.recipes.length ? (
            _io.recipes.map((recipe) => (
              <Fragment key={recipe.id}>
                <div
                  onClick={() => _io.onClickRecipe(recipe.id)}
                  style={_io.styles.recipe}
                >
                  <div key={recipe.name}>{recipe.name}</div>
                  <button onClick={(e) => _io.onEditRecipe(e, recipe.id)}>
                    Editar
                  </button>
                </div>
                <div style={_io.styles.separator} />
              </Fragment>
            ))
          ) : (
            <strong>Você não possui receitas</strong>
          )}
        </div>
        <div style={_io.styles.actions}>
          <button onClick={_io.onCreateRecipe} style={_io.styles.action}>
            Criar Receita
          </button>
        </div>
      </Page>
    </div>
  );
}
