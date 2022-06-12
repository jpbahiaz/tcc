import { FormEvent } from "react";
import { useNavigate } from "react-router-dom";

const styles = {
  container: {
    display: "flex",
    flexFlow: "column",
    width: "100vw",
    height: "100vh",
    alignItems: "center",
    justifyContent: "center",
  },
  login: {
    width: "400px",
    border: "1px solid black",
    borderRadius: "5px",
    padding: "10px",
  },
  form: { display: "flex", flexFlow: "column" },
};

export function loginIO() {
  const navigate = useNavigate();
  return {
    styles,
    onSubmit: (e: FormEvent) => {
      e.preventDefault();
      navigate("home");
    },
  };
}

export type LoginIO = ReturnType<typeof loginIO>;
