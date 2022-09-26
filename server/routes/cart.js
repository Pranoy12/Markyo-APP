const express= require('express');
const e = require('express');
const {Product} = require('../models/product');
const auth = require('../middlewares/auth');
const User = require('../models/user');

const cartRouter = express.Router();

cartRouter.post("/api/add-to-cart",auth, async (req,res) => {
    try{
        const {prodname,cost} = req.body;
        let prod = new Product({
                        prodname,
                        cost
                    });

        // const product = await Product.find(prodname);

        let user = User.findById(req.user);
        if(user.cart.length == 0) {
            user.cart.push({prod}); 
        } 
        // // else {
        // //     for (let i=0; i<user.cart.length;i++){
                
        // //     }
        // // }
        for (let i=0; i<user.cart.length;i++){
            user.cart.push({prod});
        }
        user = await user.save();
        res.json(user);

    } catch(e) {
        res.status(500).json({error: e.message});
    }
})


module.exports = cartRouter;