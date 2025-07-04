import { Route, Routes } from "react-router-dom";
import Home from "../pages/home/Home";
import Story from "../pages/others/Story";
import Cart from "../pages/user/Cart";
import Login from "../pages/auth/Login";
import Register from "../pages/auth/Register";
import Dashboard from "../pages/user/dashboard/Dashboard";
import Orders from "../pages/user/orders/Orders";
import Admin from "../pages/admin/Admin";

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
            <Route path="/orders" element={<Orders />} />
            <Route path="/admin" element={<Admin />} />


        </Route>
    </Routes>
  );
}

export default AppRoutes;
