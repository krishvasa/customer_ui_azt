import 'package:flutter/material.dart';
import 'consumer_product_model.dart';
import 'consumer_main_sidebar.dart';
import 'consumer_product_card.dart';
import 'consumer_search_bar.dart';

class ConsumerSearchProductsPage extends StatefulWidget {
  const ConsumerSearchProductsPage({super.key});

  @override
  State<ConsumerSearchProductsPage> createState() => _ConsumerSearchProductsPageState();
}

class _ConsumerSearchProductsPageState extends State<ConsumerSearchProductsPage> {
  List<ConsumerProductModel> _allProducts = [];
  List<ConsumerProductModel> _filteredProducts = [];
  String _searchQuery = '';
  List<ConsumerProductModel> _cart = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() {
    final List<ConsumerProductModel> dummyProducts = [
      ConsumerProductModel(
        id: 'prod1',
        name: 'Apple',
        price: 40.0,
        imageUrl: 'https://placehold.co/400x400/red/fff?text=Apple',
      ),
      ConsumerProductModel(
        id: 'prod2',
        name: 'Headphone',
        price: 2500.0,
        imageUrl: 'https://placehold.co/400x400/black/fff?text=Headphone',
      ),
      ConsumerProductModel(
        id: 'prod3',
        name: 'Banana',
        price: 8.0,
        imageUrl: 'https://placehold.co/400x400/yellow/000?text=Banana',
      ),
      ConsumerProductModel(
        id: 'prod4',
        name: 'Pencil',
        price: 5.0,
        imageUrl: 'https://placehold.co/400x400/brown/fff?text=Pencil',
      ),
      ConsumerProductModel(
        id: 'prod5',
        name: 'Bottle',
        price: 500.0,
        imageUrl: 'https://placehold.co/400x400/blue/fff?text=Bottle',
      ),
      ConsumerProductModel(
        id: 'prod6',
        name: 'Lock',
        price: 200.0,
        imageUrl: 'https://placehold.co/400x400/grey/fff?text=Lock',
      ),
      ConsumerProductModel(
        id: 'prod7',
        name: 'Marker',
        price: 40.0,
        imageUrl: 'https://placehold.co/400x400/purple/fff?text=Marker',
      ),
      ConsumerProductModel(
        id: 'prod8',
        name: 'Spoon',
        price: 35.0,
        imageUrl: 'https://placehold.co/400x400/silver/000?text=Spoon',
      ),
    ];
    setState(() {
      _allProducts = dummyProducts;
      _filteredProducts = _allProducts;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
      _filteredProducts = _allProducts.where((product) {
        return _searchQuery.isEmpty ||
            product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  void _onAddToCart(ConsumerProductModel product) {
    setState(() {
      _cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onRemoveFromCart(ConsumerProductModel product) {
    setState(() {
      _cart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [
          const ConsumerMainSidebar(selectedPage: 'search'),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Products for you',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 24),
                        ConsumerSearchBar(
                          hintText: 'Search products...',
                          onChanged: _onSearchChanged,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(0),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return ConsumerProductCard(
                          product: product,
                          onAddToCart: () => _onAddToCart(product),
                          onRemoveFromCart: () => _onRemoveFromCart(product),
                          cart: _cart,
                        );
                      },
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