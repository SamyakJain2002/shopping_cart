import 'package:flutter/material.dart';
import 'package:shopping_cart/cart_screen.dart';
import 'package:shopping_cart/constants.dart';
import 'package:shopping_cart/models/cart_products.dart';
import 'package:provider/provider.dart';
import 'Widgets/product_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartItemList>(
      create: (_) => CartItemList(),
      child: MaterialApp(
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App'),
        centerTitle: true,
        actions: [
          Center(
            child: SizedBox(
              height: 150,
              width: 40,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const CartScreen();
                  }));
                },
                child: Stack(
                  children: [
                    const Center(
                        child: Icon(Icons.shopping_cart_outlined, size: 30)),
                    (Provider.of<CartItemList>(context).getlength == 0)
                        ? Container()
                        : Positioned(
                            child: Stack(children: [
                              const Icon(
                                Icons.brightness_1,
                                color: Colors.red,
                                size: 20,
                              ),
                              Positioned(
                                child: Text(
                                    '${Provider.of<CartItemList>(context).getlength}'),
                                right: 4,
                              )
                            ]),
                            right: 0,
                          ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductTile(
                name: productList[index].name,
                imageLocation: productList[index].imageLocation,
                price: productList[index].price,
                myController: TextEditingController(),
              );
            }),
      ),
    );
  }
}
