import { createSlice } from "@reduxjs/toolkit";

const initialState = { 
  isLogged: false, 
  infos: { alias: "", email: "", phone: "", role: "" } 
};

const userSlice = createSlice({
  name: "user",
  initialState,
  reducers: {
    login(state, action) {
      state.isLogged = true;
      state.infos.alias = action.payload.alias;
      state.infos.email = action.payload.email;
      state.infos.phone = action.payload.phone; 
      state.infos.role = action.payload.role;
    },
    logout() {
      return initialState;
    },
    isAdmin(state) {
      return state.infos.role === "admin";
    }
  },
});

export const { login, logout, isAdmin } = userSlice.actions;
export default userSlice.reducer;
