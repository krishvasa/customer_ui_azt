import 'package:flutter/material.dart';
import 'consumer_dashboard_page.dart';
import 'consumer_search_products_page.dart';
import '../pages/consumer/consumer_my_cart_page.dart';
import '../pages/consumer/consumer_checkout_page.dart';
import 'consumer_sidebar_item.dart';

class ConsumerMainSidebar extends StatelessWidget {
  final String selectedPage;

  const ConsumerMainSidebar({
    super.key,
    required this.selectedPage,
  });

  @override
  Widget build(BuildContext context) {
    void navigateTo(Widget page) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, anim1, anim2) => page,
          transitionDuration: Duration.zero,
        ),
      );
    }

    return Container(
      width: 250,
      color: const Color.fromARGB(255, 104, 147, 190),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            color: const Color.fromARGB(255, 104, 147, 190),
            child: const Icon(Icons.shopping_basket, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 10),

          // Dashboard
          ConsumerSidebarItem(
            icon: Icons.home_outlined,
            text: 'Home',
            isSelected: selectedPage == 'dashboard',
            onTap: selectedPage == 'dashboard'
                ? null
                : () => navigateTo(const ConsumerDashboardPage()),
          ),

          // Search Products
          ConsumerSidebarItem(
            icon: Icons.search,
            text: 'Search Products',
            isSelected: selectedPage == 'search',
            onTap: selectedPage == 'search'
                ? null
                : () => navigateTo(const ConsumerSearchProductsPage()),
          ),

          // My Cart
          ConsumerSidebarItem(
            icon: Icons.shopping_cart_checkout_outlined,
            text: 'My Cart',
            isSelected: selectedPage == 'cart',
            onTap: selectedPage == 'cart'
                ? null
                : () => navigateTo(const ConsumerMyCartPage()),
          ),

          // Checkout
          ConsumerSidebarItem(
            icon: Icons.payment_outlined,
            text: 'Checkout',
            isSelected: selectedPage == 'checkout',
            onTap: selectedPage == 'checkout'
                ? null
                : () => navigateTo(const ConsumerCheckoutPage()),
          ),
        ],
      ),
    );
  }
}