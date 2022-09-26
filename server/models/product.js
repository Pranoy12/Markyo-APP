const mongoose = require('mongoose');

const productSchema = mongoose.Schema({
    prodname : {
        required: true,
        type: String,
        trim: true,
    },
    cost: {
        required: true,
        type: String,
    },
});

const Product = mongoose.model("Product",productSchema);
module.exports = {Product,productSchema};