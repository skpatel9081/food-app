import 'package:flutter/material.dart';
import 'package:food_app/model/Review_cart.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel e;

  OrderItem({required this.e});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.cartImage!,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e.cartName!,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            e.cartunit,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          Text(
            "₹${e.cartPrice! * e.cartQuantity!}",
          ),
        ],
      ),
      subtitle: Text(e.cartQuantity.toString()),
    );
  }
}
