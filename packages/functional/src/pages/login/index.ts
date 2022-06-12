import { composeIO } from "react-compose-io";
import { loginIO } from "./io";
import { LoginView } from "./view";

export const Login = composeIO(LoginView, loginIO);
