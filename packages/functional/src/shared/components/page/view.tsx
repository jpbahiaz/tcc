import { IOProps } from "react-compose-io";
import { PageIO } from "./io";

type Props = {
  children?: JSX.Element | JSX.Element[]
  title?: string
};

export function PageView({ _io, children, title }: IOProps<PageIO, Props>) {
  return (
    <div style={_io.styles.container}>
      <div style={_io.styles.content}>
        {title && <h1>{title}</h1>}
        {children}
      </div>
    </div>
  );
}
