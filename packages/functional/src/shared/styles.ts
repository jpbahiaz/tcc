import { CSSProperties } from "react";

export function css(props: CSSProperties) {
  return props
}

export const container: CSSProperties = {
  width: "100vw",
  height: "100vh",
  display: "flex",
  flexFlow: "column",
  justifyContent: "center",
  alignItems: "center"
}
