import { Router } from "express";
import { getInfos, update, remove } from "../controllers/user.controller.js";

const router = Router();

router.get("/", getInfos);
router.patch("/", update);
router.delete("/", remove);

export default router;