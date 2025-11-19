import 'package:flutter/material.dart';
import 'customer_productcards.dart'; // Import the new products file

class SearchPage extends StatelessWidget {
  final Function(Product) onAddToCart;
  final Function(Product) onRemoveFromCart; // <-- ADDED THIS
  final List<Product> cart;

  const SearchPage({
    super.key,
    required this.onAddToCart,
    required this.onRemoveFromCart, // <-- ADDED THIS
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SearchMainContent(
        onAddToCart: onAddToCart,
        onRemoveFromCart: onRemoveFromCart, // <-- ADDED THIS
        cart: cart,
      ),
    );
  }
}

class SearchMainContent extends StatelessWidget {
  final Function(Product) onAddToCart;
  final Function(Product) onRemoveFromCart; // <-- ADDED THIS
  final List<Product> cart;

  const SearchMainContent({
    super.key,
    required this.onAddToCart,
    required this.onRemoveFromCart, // <-- ADDED THIS
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Products for you',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Color.fromARGB(179, 17, 28, 175)),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                // Pass ALL required properties to ProductCard
                return ProductCard(
                  product: productList[index],
                  onAddToCart: onAddToCart,
                  onRemoveFromCart: onRemoveFromCart, // <-- ADDED THIS
                  cart: cart,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}