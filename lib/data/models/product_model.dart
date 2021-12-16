class ProductModel {
  final String name;
  final String price; // PRICE SHOULD BE IN INT OR DOUBLE
  final String image;
  final int productID;
  final bool isFav;
  ProductModel({
    this.name,
    this.price,
    this.image,
    this.productID,
    this.isFav,
  });
  ProductModel.fromMap(Map<String, dynamic> map)
      : this.name = map['name'],
        this.price = map['price'],
        this.image = map['image'],
        this.productID = map['productID'],
        this.isFav = map['isFav'];
}
