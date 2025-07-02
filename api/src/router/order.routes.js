import { Router } from "express";
import { getAllUserOrders, placeOrder, getUserOrderById } from "../controllers/order.controller.js";

const router = Router();

router.post("/", placeOrder);
router.get("/", getAllUserOrders);
router.get("/:orderId", getUserOrderById);


export default router