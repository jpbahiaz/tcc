import { container, css } from "../../styles";

const styles = {
  container: container,
  content: css({
    display: "flex",
    flexFlow: "column",
    alignItems: "center",
    border: "1px solid white",
    borderRadius: "5px",
    padding: "10px",
    width: "70vw",
    height: "80vh"
  }),
}

export function pageIO() {
  return {
    styles
  };
}

export type PageIO = ReturnType<typeof pageIO>;

export function mediumPageIO() {
  return {
    styles: {
      ...styles,
      content: {
        ...styles.content,
        ...css({
          width: "50vw",
        })
      }
    }
  }
}

export function smallPageIO() {
  return {
    styles: {
      ...styles,
      content: {
        ...styles.content,
        ...css({
          width: "30vw",
          height: "auto"
        })
      }
    }
  }
}
