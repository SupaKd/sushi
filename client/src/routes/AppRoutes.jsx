import { Route, Routes } from "react-router-dom";
import Home from "../pages/home/Home";
import Story from "../pages/Story";
import Cart from "../pages/user/Cart";
import Login from "../pages/auth/Login";
import Register from "../pages/auth/Register";
import Dashboard from "../pages/user/Dashboard";

function AppRoutes() {
  return (
    <Routes>
        <Route>
            <Route path="/" element={<Home />} />
            <Route path="/story" element={<Story />} />
            <Route path="/cart" element={<Cart />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            <Route path="/dashboard" element={<Dashboard />} />
        </Route>
    </Routes>
  );
}

export default AppRoutes;
