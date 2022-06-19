import { IOProps } from "react-compose-io";
import { SmallPage } from "../../shared/components/page";
import { LoginIO } from "./io";

type Props = {};

export function LoginView({ _io }: IOProps<LoginIO, Props>) {
  return (
    <SmallPage title="Login">
      <form style={_io.styles.form} onSubmit={_io.onSubmit}>
        <input
          style={_io.styles.input}
          onChange={_io.onFieldChange}
          placeholder="Usuário"
          type="text"
          name="username"
          autoComplete="off"
        />
        <input
          style={_io.styles.input}
          onChange={_io.onFieldChange}
          placeholder="Senha"
          type="password"
          name="password"
          autoComplete="off"
        />
        <button type="submit">Entrar</button>
      </form>
    </SmallPage>
  );
}
