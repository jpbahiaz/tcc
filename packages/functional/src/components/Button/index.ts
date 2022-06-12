import { composeIO } from "react-compose-io";
import { buttonIO } from "./Button.io";
import { ButtonView } from "./Button.view";

export const Button = composeIO(ButtonView, buttonIO);
