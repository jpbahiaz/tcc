import { createSlice } from "@reduxjs/toolkit";
import { AuthState } from "./types";

const initialState: AuthState = {
  username: "",
  password: "",
  logged: false
};

const authSlice = createSlice({
  name: "auth",
  initialState,
  reducers: {},
});

export const authReducer = authSlice.reducer;
export const authActions = authSlice.actions;
