import 'package:flutter/material.dart';
import 'customer_dashboard.dart'; // Import the dashboard page
import 'customer_search.dart'; // Import the search page
import 'customer_sidemenu.dart'; // Import the side menu file
import 'customer_mycart.dart'; // Import the new cart page
import 'customer_productcards.dart'; // Import the Product class
import 'customer_checkout.dart'; // *** IMPORTED CHECKOUT PAGE ***

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Dashboard',
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // This list now holds the products in our cart
  final List<Product> _cart = [];

  // Callback function to add a product to the cart
  void _addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });
    // Optional: show a confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Callback function to remove a product from the cart
  void _removeFromCart(Product product) {
    setState(() {
      // This logic removes only the first instance of the product.
      // If you want to remove the *last* instance, you could use:
      // final index = _cart.lastIndexOf(product);
      // if (index != -1) { _cart.removeAt(index); }
      // For this app, .remove() is fine.
      _cart.remove(product);
    });
  }

  void _onItemTapped(int index) {
    // *** UPDATED LOGOUT INDEX ***
    if (index == 4) {
      // ignore: avoid_print
      print('Logout tapped');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   
    final List<Widget> pages = <Widget>[
      const DashboardPage(),
      // *** MODIFIED HERE ***
      // Pass both _addToCart and _removeFromCart to SearchPage
      SearchPage(
        onAddToCart: _addToCart,
        onRemoveFromCart: _removeFromCart, // <-- ADDED THIS
        cart: _cart,
      ),
      MyCartPage(
        cart: _cart,
        onRemoveFromCart: _removeFromCart,
        onItemTapped: _onItemTapped,
      ),
      CheckoutPage(cart: _cart),
    ];

    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SideMenu(
              selectedIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            ),
            Expanded(
              // Using IndexedStack to preserve the state of each page
              // when switching tabs (e.g., scroll position).
              child: IndexedStack(
                index: _selectedIndex,
                // Use the 'pages' list defined above
                children: pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}