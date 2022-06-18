import { IOProps } from "react-compose-io";
import { LoginIO } from "./io";

type Props = {};

export function LoginView({ _io }: IOProps<LoginIO, Props>) {
  return (
    <div style={_io.styles.container}>
      <div style={_io.styles.login}>
        <div>Login</div>
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
      </div>
    </div>
  );
}
