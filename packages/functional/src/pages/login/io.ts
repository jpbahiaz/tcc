import { ChangeEvent, CSSProperties, FormEvent, SyntheticEvent, useState } from "react";
import { useNavigate } from "react-router-dom";
import { authActions } from "../../redux/modules/auth/slice";
import { useAppDispatch } from "../../redux/store";

const styles: Record<string, CSSProperties> = {
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
  form: { display: "flex", flexFlow: "column", margin: "10px 0" },
  input: {
    marginBottom: "5px"
  }
};

export function loginIO() {
  const navigate = useNavigate();
  const dispatch = useAppDispatch()
  const [fieldData, setFieldData] = useState({ username: '', password: '' })

  return {
    styles,
    onSubmit: (e: FormEvent) => {
      e.preventDefault();
      console.log(fieldData)
      dispatch(authActions.loginSuccess(fieldData))
      navigate("home");
    },
    onFieldChange: (e: ChangeEvent<HTMLInputElement>) => {
      setFieldData(prev => ({ ...prev, [e.target.name]: e.target.value }))
    }
  };
}

export type LoginIO = ReturnType<typeof loginIO>;
