class ProductModel {
  String productName;
  String productImage;
  num productPrice;
  String productId;
  int productQuantity;
  List<dynamic>? productUnit;
  String? unit;
  String? productDescription;
  ProductModel(
      {required this.productName,
      required this.productImage,
      this.productDescription,
      required this.productPrice,
      this.unit,
      required this.productId,
      required this.productQuantity,
      this.productUnit});
}
