import { configureStore } from "@reduxjs/toolkit";
import authReducer from "../features/authslice";
import menuReducer from "../features/menuSlice";
import cartReducer from "../features/cartSlice";


const store = configureStore({
	reducer: {
		auth: authReducer,
		user: authReducer,
		menu: menuReducer,
		cart: cartReducer,

	},
});

export default store;
