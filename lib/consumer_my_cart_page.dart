import 'package:flutter/material.dart';
import 'consumer_product_model.dart';
import 'consumer_main_sidebar.dart';

class ConsumerMyCartPage extends StatefulWidget {
  const ConsumerMyCartPage({super.key});

  @override
  State<ConsumerMyCartPage> createState() => _ConsumerMyCartPageState();
}

class _ConsumerMyCartPageState extends State<ConsumerMyCartPage> {
  // TODO: This should be shared state with search page
  // For now, using empty list
  List<ConsumerProductModel> _cart = [];

  void _onRemoveFromCart(ConsumerProductModel product) {
    setState(() {
      _cart.remove(product);
    });
  }

  double _parsePrice(double price) {
    return price;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, int> productCounts = {};
    final Map<String, ConsumerProductModel> productData = {};
    double grandTotal = 0.0;

    for (final product in _cart) {
      productData[product.name] = product;
      productCounts[product.name] = (productCounts[product.name] ?? 0) + 1;
      grandTotal += _parsePrice(product.price);
    }

    final uniqueProductNames = productCounts.keys.toList();

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [
          const ConsumerMainSidebar(selectedPage: 'cart'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'My Cart',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_cart.isEmpty)
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'Your cart is empty.',
                            style: TextStyle(color: Colors.black54, fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  else
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: uniqueProductNames.length,
                                itemBuilder: (context, index) {
                                  final productName = uniqueProductNames[index];
                                  final product = productData[productName]!;
                                  final count = productCounts[productName]!;
                                  final double itemPrice = _parsePrice(product.price);
                                  final double itemTotal = itemPrice * count;

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
                                        '₹${itemPrice.toStringAsFixed(2)} each (Total: ₹${itemTotal.toStringAsFixed(2)})',
                                        style: const TextStyle(color: Colors.black87),
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.remove_shopping_cart,
                                            color: Colors.red),
                                        onPressed: () => _onRemoveFromCart(product),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
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
                                      const Color.fromARGB(255, 19, 132, 150),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ConsumerCheckoutPage(),
                                    ),
                                  );
                                },
                                child: const Text('Proceed to Checkout'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}