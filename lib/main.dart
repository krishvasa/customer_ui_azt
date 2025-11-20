/*import 'package:flutter/material.dart';
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
} */

import 'package:flutter/material.dart';
import 'sfdashboard.dart'; // Import the dashboard page
import 'sfsearch.dart'; // Import the search page
import 'sfsidemenu.dart'; // Import the side menu file
import 'sfcart.dart'; // Import the new cart page
import 'sfproductcards.dart'; // Import the Product class
import 'sfcheckout.dart'; // Import checkout page
import 'sfrecentorders.dart'; // Import the new orders page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  // This list holds the products in our cart
  final List<Product> _cart = [];
  
  // This list holds the confirmed orders (List of Lists)
  final List<List<Product>> _recentOrders = [];

  // Callback to add a product to the cart
  void _addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Callback to remove a product from the cart
  void _removeFromCart(Product product) {
    setState(() {
      _cart.remove(product);
    });
  }

  // Logic to handle successful payment
  void _handlePaymentSuccess() {
    setState(() {
      if (_cart.isNotEmpty) {
        // Create a copy of current cart and add to orders
        _recentOrders.insert(0, List.from(_cart));
        // Clear the cart
        _cart.clear();
      }
    });
  }

  void _onItemTapped(int index) {
    // Logout is now index 5 because we added "Your Orders" at 4
    if (index == 5) {
      debugPrint('Logout tapped');
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define the pages
    final List<Widget> pages = <Widget>[
      DashboardPage(
        onNavigate: _onItemTapped, // Pass the navigation callback
      ),
      SearchPage(
        onAddToCart: _addToCart,
        onRemoveFromCart: _removeFromCart,
        cart: _cart,
      ),
      MyCartPage(
        cart: _cart,
        onRemoveFromCart: _removeFromCart,
        onItemTapped: _onItemTapped,
      ),
      CheckoutPage(
        cart: _cart,
        onPaymentSuccess: _handlePaymentSuccess, // Pass the callback
      ),
      RecentOrdersPage(
        orders: _recentOrders, // Pass the history
      ),
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
              // IndexedStack preserves state when switching tabs
              child: IndexedStack(
                index: _selectedIndex,
                children: pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}