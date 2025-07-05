import pool from "../config/db.js";
import Order from "../models/order.model.js";

// INSERT COMMAND
const placeOrder = async (req, res, next) => {
	const userId = req.user.userId;
	const { total_price, products } = req.body;

	if (!products || !products.length) {
		res.status(400).json({ error: "Aucuns produits dans la commande." });
		return;
	}
	let connection = null;
	try {
		connection = await pool.getConnection();
		await connection.beginTransaction();

		const [orderResult] = await Order.insertOrder(
			connection,
			userId,
			total_price
		);
		const orderId = orderResult.insertId;

		for (const product of products) {
			await Order.insertOrderedProduct(connection, orderId, product);
		}

		await connection.commit();
		connection.release();

		res.status(201).json({
			message: "Commande passée avec succès.",
			orderId,
		});
		return;
	} catch (error) {
		if (connection) {
			await connection.rollback();
			connection.release();
		}
		next(error);
	}
};

// Récupérer une commande spécifique par son ID (pour un utilisateur ou pour un admin)
const getUserOrderById = async (req, res, next) => {
    const userId = req.user.userId;
    const isAdmin = req.user.role === 'admin'; 
    const { orderId } = req.params;

    try {
        const [orderDetails] = await Order.findUserOrderWithDetails(userId, orderId, isAdmin);

        if (!orderDetails.length) {
            res.status(404).json({ error: "Aucune commande trouvée avec ces identifiants." });
            return;
        }

        const orderInfo = {
            id: orderDetails[0].order_id,
            created_at: orderDetails[0].created_at,
            total_price: parseFloat(orderDetails[0].total_price),
            status: orderDetails[0].status,
            products: orderDetails.map((item) => ({
                id: item.product_id,
                name: item.name,
                quantity: item.quantity,
                unit_price: parseFloat(item.unit_price),
            })),
        };

        res.status(200).json({ success: "Commande récupérée", order: orderInfo });
    } catch (error) {
        next(error);
    }
};

// GET COMMAND U
const getAllUserOrders = async (req, res, next) => {
    const user_id = req.user.userId;
    const isAdmin = req.user.role === 'admin'; 

    try {
        const [orders] = await Order.findAllUserOrders(user_id, isAdmin);

        if (!orders) {
            res.status(400).json({ error: "Aucunes commandes pour cet utilisateur." });
            return;
        }
        res.json({ success: "Commandes récupérées", orders });
    } catch (error) {
        next(error);
    }
};

// UPDATE COMMAND
const updateOrderStatus = async (req, res, next) => {
    const { orderId } = req.params;
    const { status } = req.body;

    if (!status) {
        res.status(400).json({ error: "Le statut est requis." });
        return;
    }

    try {
        await Order.updateOrderStatus(orderId, status);
        res.status(200).json({ success: "Statut de la commande mis à jour." });
    } catch (error) {
        next(error);
    }
};

export { placeOrder, getAllUserOrders, getUserOrderById, updateOrderStatus };
