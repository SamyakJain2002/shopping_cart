import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart/models/cart_products.dart';

class CartItemTile extends StatelessWidget {
  const CartItemTile(
      {required this.imageLocation,
      required this.name,
      required this.quantity,
      required this.price,
      required this.index,
      required this.myController,
      Key? key})
      : super(key: key);
  final String name;
  final String imageLocation;
  final int price;
  final int index;
  final int quantity;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: Column(children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: Image.asset(imageLocation)),
                Expanded(
                    child: Column(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Rs. $price',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                )),
              ],
            ),
          ),
          Expanded(
            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 5),
                        child: TextField(
                          controller: myController,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
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
                    ),
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        int val = int.parse(myController.text);
                        if (val == 0) {
                          context.read<CartItemList>().removeFromCart(index);
                        } else {
                          context.read<CartItemList>().updateCart(index, val);
                        }
                      },
                      child: const Text('Update'),
                    )),
                  ],
                ),
              ),
              Expanded(
                  child: TextButton(
                onPressed: () {
                  context.read<CartItemList>().removeFromCart(index);
                },
                child: const Text(
                  'Remove from cart',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10))),
              ))
            ]),
          ),
        ]),
      ),
    );
  }
}
