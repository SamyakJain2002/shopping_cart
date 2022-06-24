class Product {
  Product(
      {required this.imageLocation, required this.name, required this.price});
  String name;
  String imageLocation;
  int price;
}

class CartItem {
  CartItem({required this.item, required this.quantity});
  Product item;
  int quantity;
}
