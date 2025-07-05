import express from "express";
import { getAll } from "../controllers/user.controller.js";
import { updateOrderStatus, getAllUserOrders,getUserOrderById } from "../controllers/order.controller.js";
import isAdmin from "../middlewares/isAdmin.js";

const router = express.Router();

// Routes pour consulter et supprimer les utilisateurs.
router.get("/user", isAdmin, getAll);

// Routes pour consulter ou modifier le statut des commandes.
router.get("/orders", isAdmin, getAllUserOrders); 
router.get("/orders/:orderId", isAdmin, getUserOrderById); 
router.put("/orders/:orderId/status", isAdmin, updateOrderStatus);

export default router;
