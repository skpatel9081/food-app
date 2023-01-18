class ReviewCartModel {
  String? cartId;
  String? cartImage;
  String? cartName;
  num? cartPrice;
  int? cartQuantity;
  var cartunit;
  // var cartUnit;
  ReviewCartModel(
      {this.cartId,
      // this.cartUnit,
      this.cartImage,
      this.cartName,
      this.cartPrice,
      this.cartQuantity,
      this.cartunit});
}
