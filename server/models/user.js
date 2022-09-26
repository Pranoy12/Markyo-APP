const mongoose = require('mongoose');
const { productSchema } = require('./product');

const userSchema = mongoose.Schema({
    name : {
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: 'Please enter valid email address',
        },
    },
    password: {
        required: true,
        type: String,
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },


    //cart
    cart:[
        {
            prodname: {
                required: true,
                type: String,
                trim: true,
            },
            cost: {
                type: String,
                required: true,
            },
        }
    ]
});

const User = mongoose.model('User',userSchema);

module.exports = User;