import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/Widgets/cart_item_tile.dart';
import 'package:shopping_cart/models/cart_products.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:
                  context.select<CartItemList, int>((obj) => obj.getlength),
              itemBuilder: (context, index) {
                return CartItemTile(
                  imageLocation:
                      context.read<CartItemList>().imageLocation(index),
                  name: context.read<CartItemList>().name(index),
                  price: context.read<CartItemList>().price(index),
                  quantity: context.read<CartItemList>().quantity(index),
                  index: index,
                  myController: TextEditingController(
                      text: '${context.read<CartItemList>().quantity(index)}'),
                );
              },
            ),
          ),
          SizedBox(
              child: Center(
                child: Text(
                  'Total: Rs. ${context.watch<CartItemList>().getTotal()}',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('The payment is successful'),
                  duration: Duration(seconds: 1),
                ));
                context.read<CartItemList>().clearCart();
              },
              child: Text(
                'Pay Rs. ${context.watch<CartItemList>().getTotal()}',
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
