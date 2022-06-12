import { IOProps } from "react-compose-io";
import { ButtonIO } from "./Button.io";

export type ButtonProps = {
  text: string;
  color: string;
  onClick: () => void;
};

export function ButtonView({
  text,
  color,
  _io,
}: IOProps<ButtonIO, ButtonProps>) {
  return (
    <button style={{ background: color }} onClick={_io.onClick}>
      {text}
    </button>
  );
}
