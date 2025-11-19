import 'package:flutter/material.dart';
import 'consumer_product_model.dart';

class ConsumerProductCard extends StatelessWidget {
  final ConsumerProductModel product;
  final VoidCallback onAddToCart;
  final VoidCallback onRemoveFromCart;
  final List<ConsumerProductModel> cart;

  const ConsumerProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    final int countInCart = cart.where((item) => item.id == product.id).length;

    return Card(
      color: const Color.fromARGB(255, 104, 147, 190),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '₹${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            if (countInCart > 0)
              Center(
                child: Text(
                  'In Cart: $countInCart',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 31, 104, 178),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: countInCart > 0
                        ? const Icon(Icons.add, size: 18)
                        : const Text('Add to Cart'),
                  ),
                ),
                if (countInCart > 0) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onRemoveFromCart,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.remove, size: 18),
                    ),
                  ),
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}