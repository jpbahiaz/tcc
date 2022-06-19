import { ChangeEvent, FormEvent, useState } from "react";
import { useNavigate } from "react-router-dom";
import { authActions } from "../../redux/modules/auth/slice";
import { useAppDispatch } from "../../redux/store";
import { css } from "../../shared/styles";

const styles = {
  container: css({
    display: "flex",
    flexFlow: "column",
    width: "100vw",
    height: "100vh",
    alignItems: "center",
    justifyContent: "center",
  }),
  login: css({
    width: "400px",
    border: "1px solid white",
    borderRadius: "5px",
    padding: "10px",
  }),
  form: css({
    display: "flex",
    flexFlow: "column",
    margin: "10px 0",
    width: "100%"
  }),
  input: css({
    marginBottom: "5px"
  }),
  title: css({
    fontSize: "22px"
  })
};

export function loginIO() {
  const navigate = useNavigate();
  const dispatch = useAppDispatch()
  const [fieldData, setFieldData] = useState({ username: '', password: '' })

  return {
    styles,
    onSubmit: (e: FormEvent) => {
      e.preventDefault();
      dispatch(authActions.loginSuccess(fieldData))
      navigate("/");
    },
    onFieldChange: (e: ChangeEvent<HTMLInputElement>) => {
      setFieldData(prev => ({ ...prev, [e.target.name]: e.target.value }))
    }
  };
}

export type LoginIO = ReturnType<typeof loginIO>;
