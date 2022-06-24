import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/models/cart_products.dart';
import 'package:shopping_cart/models/products.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    required this.imageLocation,
    required this.name,
    required this.price,
    required this.myController,
    Key? key,
  }) : super(key: key);
  final String imageLocation;
  final String name;
  final int price;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              imageLocation,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Price: $price',
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                  child: TextField(
                    controller: myController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      hintText: '0',
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.minimize),
                        onPressed: () {
                          int val = int.parse((myController.text == '')
                              ? '0'
                              : myController.text);
                          if (val > 0) {
                            val--;
                          }
                          myController.text = val.toString();
                        },
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          int val = int.parse((myController.text == '')
                              ? '0'
                              : myController.text);

                          val++;
                          myController.text = "$val";
                        },
                      ),
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    int val = int.parse(
                        (myController.text == '') ? '0' : myController.text);
                    if (val != 0) {
                      context.read<CartItemList>().addtoCart(CartItem(
                          item: Product(
                              imageLocation: imageLocation,
                              name: name,
                              price: price),
                          quantity: int.parse(myController.text)));
                      myController.clear();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('The Product has been added to the cart'),
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.blue));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'Please select a quantity to be added to the cart',
                        ),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
