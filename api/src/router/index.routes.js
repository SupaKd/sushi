import { Router } from "express";
import authRoutes from "./auth.routes.js";
import userRoutes from "./user.routes.js";
import categoryRoutes from "./category.routes.js";
import productRoutes from "./product.routes.js";
import orderRoutes from "./order.routes.js";

import verifyToken from "../middlewares/verifyToken.js";

const router = Router();
router.use("/auth", authRoutes);
router.use("/user", verifyToken, userRoutes);
router.use("/category", categoryRoutes);
router.use("/product", productRoutes);
router.use("/order", verifyToken, orderRoutes);

export default router;