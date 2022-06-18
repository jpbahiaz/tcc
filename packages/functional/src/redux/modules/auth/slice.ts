import { createSlice, PayloadAction } from "@reduxjs/toolkit";
import { AuthState } from "./types";

const initialState: AuthState = {
  currentUser: ""
};

const authSlice = createSlice({
  name: "auth",
  initialState,
  reducers: {
    loginSuccess: (state, action: PayloadAction<{username: string}>) => {
      state.currentUser = action.payload.username
    }
  },
});

export const authReducer = authSlice.reducer;
export const authActions = authSlice.actions;
