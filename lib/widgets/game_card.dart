import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final dynamic product;

  const GameCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final containerHeight = 200.0;

    return Container(
      height: containerHeight,
      margin: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.network(
            product.image,
            width: 130,
            height: containerHeight,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp${product.price}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Stock: ${product.stock}',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  'Category: ${product.categories}',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text('See More'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
