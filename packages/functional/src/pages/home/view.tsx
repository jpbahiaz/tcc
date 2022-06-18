import { IOProps } from "react-compose-io";
import { HomeIO } from "./io";

type Props = {};

export function HomeView({ _io }: IOProps<HomeIO, Props>) {
  return (
    <div style={_io.styles.container}>
      <div style={_io.styles.recipes} >
        <strong style={_io.styles.title}>Receitas</strong>
        <div style={_io.styles.list}>
          {_io.recipes.length ? _io.recipes.map((recipe) => (
            <>
              <div style={_io.styles.recipe}>
                <div key={recipe.name}>{recipe.name}</div>
                <button>Editar</button>
              </div>
              <div style={_io.styles.separator} />
            </>
          )) : <strong>Você não possui receitas</strong>
          }
        </div>
        <div style={_io.styles.actions}>
          <button onClick={_io.onCreateRecipe} style={_io.styles.action}>Criar Receita</button>
        </div>
      </div>
    </div>
  );
}
