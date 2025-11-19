import 'package:flutter/material.dart';
import 'customer_productcards.dart'; // Import the Product class

class MyCartPage extends StatelessWidget {
  final List<Product> cart;
  final Function(Product) onRemoveFromCart;
  final Function(int) onItemTapped; // *** ADDED FOR NAVIGATION ***

  const MyCartPage({
    super.key,
    required this.cart,
    required this.onRemoveFromCart,
    required this.onItemTapped, // *** ADDED FOR NAVIGATION ***
  });

  @override
  Widget build(BuildContext context) {
    // *** MODIFIED HERE ***

    // Helper function to parse price string like "₹2.99" to a double
    double parsePrice(String price) {
      try {
        return double.parse(price.replaceAll('₹', ''));
      } catch (e) {
        // Handle any parsing errors gracefully
        return 0.0;
      }
    }

    // 1. Create a map to hold the grouped products and their counts.
    final Map<String, int> productCounts = {};
    // 2. Create a map to store the product data (like price) for each unique name.
    final Map<String, Product> productData = {};
    // 3. Calculate the grand total
    double grandTotal = 0.0;

    // 4. Iterate over the raw cart list to populate the maps and grand total
    for (final product in cart) {
      // Add the product data to the map (this will just overwrite with the same data)
      productData[product.name] = product;
      // Increment the count for this product name.
      productCounts[product.name] = (productCounts[product.name] ?? 0) + 1;
      // Add this item's price to the grand total
      grandTotal += parsePrice(product.price);
    }

    // 5. Get a list of unique product names to build the ListView.
    final uniqueProductNames = productCounts.keys.toList();
    // *** END OF MODIFICATION ***

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Cart',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),
            if (cart.isEmpty)
              const Center(
                child: Text(
                  'Your cart is empty.',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
              )
            else
              Expanded(
                // *** MODIFIED HERE ***
                // Build the list using the unique product names.
                child: ListView.builder(
                  // 6. Set the item count to the number of *unique* products.
                  itemCount: uniqueProductNames.length,
                  itemBuilder: (context, index) {
                    // 7. Get the product info for the current index.
                    final productName = uniqueProductNames[index];
                    final product = productData[productName]!;
                    final count = productCounts[productName]!;

                    // *** ADDED PRICE CALCULATION ***
                    final double itemPrice = parsePrice(product.price);
                    final double itemTotal = itemPrice * count;

                    // 8. Return the new ListTile with the count and item total.
                    return Card(
                      color: Colors.grey.shade100,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        // 9. Add a leading widget to show the count.
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
                        // 10. Show individual price and item total
                        subtitle: Text(
                          '${product.price} each (Total: ₹${itemTotal.toStringAsFixed(2)})',
                          style: const TextStyle(color: Colors.black87),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_shopping_cart,
                              color: Colors.red),
                          // This still works, as it removes one instance.
                          onPressed: () => onRemoveFromCart(product),
                        ),
                      ),
                    );
                  },
                ),
              ),
            
            // *** ADDED GRAND TOTAL DISPLAY ***
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
              // *** ADDED CHECKOUT BUTTON ***
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 19, 132, 150),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // Navigate to the checkout page (index 3)
                    onItemTapped(3);
                  },
                  child: const Text('Proceed to Checkout'),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}