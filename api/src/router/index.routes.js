import { Router } from "express";
import authRoutes from "./auth.routes.js";
import userRoutes from "./user.routes.js";
import categoryRoutes from "./category.routes.js";
import productRoutes from "./product.routes.js";
import orderRoutes from "./order.routes.js";

import adminRoutes from "./admin.routes.js";
import isAdmin from "../middlewares/isAdmin.js";
import verifyToken from "../middlewares/verifyToken.js";

const router = Router();
router.use("/auth", authRoutes);
router.use("/user", verifyToken, userRoutes);
router.use("/category", categoryRoutes);
router.use("/product", productRoutes);
router.use("/order", verifyToken, orderRoutes);
router.use("/admin", verifyToken, isAdmin, adminRoutes);

export default router;