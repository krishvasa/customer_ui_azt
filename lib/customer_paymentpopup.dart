import 'package:flutter/material.dart';
import 'customer_productcards.dart'; // *** IMPORTED PRODUCT CLASS ***

// *** COPIED HELPER FUNCTION FROM MYCART.DART ***
// Made private by adding _
double _parsePrice(String price) {
  try {
    return double.parse(price.replaceAll('₹', ''));
  } catch (e) {
    // Handle any parsing errors gracefully
    return 0.0;
  }
}

// This function shows the confirmation dialog
Future<void> showPaymentConfirmPopup(
    BuildContext context, List<Product> cart) async {
  // *** UPDATED SIGNATURE TO ACCEPT CART ***

  // *** COPIED GROUPING LOGIC FROM MYCART.DART ***
  final Map<String, int> productCounts = {};
  final Map<String, Product> productData = {};
  double grandTotal = 0.0;

  for (final product in cart) {
    productData[product.name] = product;
    productCounts[product.name] = (productCounts[product.name] ?? 0) + 1;
    grandTotal += _parsePrice(product.price);
  }

  final uniqueProductNames = productCounts.keys.toList();
  // *** END OF COPIED LOGIC ***

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // User must tap a button to close
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // *** MODIFIED TITLE TO INCLUDE 'X' BUTTON ***
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.receipt_long_outlined, color: Colors.black87),
                SizedBox(width: 10),
                Text(
                  'Checkout Summary',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.black54),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        // *** MODIFIED CONTENT TO SHOW ITEM LIST AND TOTAL ***
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Constrain the height of the ListView
              SizedBox(
                height: 200, // You can adjust this height
                width: 300, // And this width
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: uniqueProductNames.length,
                  itemBuilder: (context, index) {
                    final productName = uniqueProductNames[index];
                    final product = productData[productName]!;
                    final count = productCounts[productName]!;
                    final double itemPrice = _parsePrice(product.price);
                    final double itemTotal = itemPrice * count;

                    // A simpler ListTile for the popup summary
                    return ListTile(
                      dense: true,
                      leading: Text(
                        'x$count',
                        style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        product.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: Text(
                        '₹${itemTotal.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.black87),
                      ),
                    );
                  },
                ),
              ),
              const Divider(height: 20, thickness: 1, color: Colors.black12),
              // Grand Total Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Grand Total:',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                  Text(
                    '₹${grandTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        // *** MODIFIED ACTIONS TO REMOVE CANCEL BUTTON ***
        actions: <Widget>[
          // Centered Confirm Button
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 55, 214, 92), // Green
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Confirm Payment'),
              onPressed: () {
                // TODO: Add final payment processing logic here

                Navigator.of(context).pop(); // Close the dialog

                // Show a success message after closing the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Payment Successful'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10), // A little spacing
        ],
      );
    },
  );
}