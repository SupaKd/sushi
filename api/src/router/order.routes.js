import { Router } from "express";
import { getAllUserOrders, placeOrder } from "../controllers/order.controller.js";

const router = Router();

router.post("/", placeOrder);
router.get("/", getAllUserOrders);


export default router