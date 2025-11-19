import 'package:flutter/material.dart';
import 'customer_productcards.dart'; // *** IMPORTED PRODUCT CLASS ***

class CheckoutPage extends StatelessWidget {
  // *** ADDED CART LIST ***
  final List<Product> cart;

  // *** UPDATED CONSTRUCTOR ***
  const CheckoutPage({super.key, required this.cart});

  // *** COPIED HELPER FUNCTION FROM MYCART.DART ***
  double parsePrice(String price) {
    try {
      return double.parse(price.replaceAll('₹', ''));
    } catch (e) {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> productCounts = {};
    final Map<String, Product> productData = {};
    double grandTotal = 0.0;

    for (final product in cart) {
      productData[product.name] = product;
      productCounts[product.name] = (productCounts[product.name] ?? 0) + 1;
      grandTotal += parsePrice(product.price);
    }

    final uniqueProductNames = productCounts.keys.toList();
    // *** END OF COPIED LOGIC ***

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        // *** UPDATED LAYOUT ***
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Checkout Summary',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),
            if (cart.isEmpty)
              const Center(
                child: Text(
                  'Your cart is empty. Nothing to check out.',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              )
            else
              // *** ADDED LISTVIEW FOR ITEMS ***
              Expanded(
                child: ListView.builder(
                  itemCount: uniqueProductNames.length,
                  itemBuilder: (context, index) {
                    final productName = uniqueProductNames[index];
                    final product = productData[productName]!;
                    final count = productCounts[productName]!;
                    final double itemPrice = parsePrice(product.price);
                    final double itemTotal = itemPrice * count;

                    // Use a simpler ListTile for checkout
                    return Card(
                      color: Colors.grey.shade100,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 104, 147, 190),
                          child: Text(
                            'x$count',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        title: Text(
                          product.name,
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          '${product.price} each (Total: ₹${itemTotal.toStringAsFixed(2)})',
                          style: const TextStyle(color: Colors.black87),
                        ),
                        // No remove button on this page
                      ),
                    );
                  },
                ),
              ),

            // *** ADDED TOTAL AND PAY BUTTON ***
            if (cart.isNotEmpty) ...[
              const Divider(height: 30, thickness: 1, color: Colors.black12),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Grand Total: ₹${grandTotal.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 55, 214, 92), // Green for Pay
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Payment done'),
                        backgroundColor: Color.fromARGB(255, 11, 187, 34),
                      ),
                    );
                  },
                  child: const Text('Pay Now'),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}