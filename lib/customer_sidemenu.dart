import 'package:flutter/material.dart';

// The shared SideMenu widget
class SideMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const SideMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: double.infinity,
      color: const Color.fromARGB(255, 104, 147, 190),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const SizedBox(height: 30),
          MenuItem(
            icon: Icons.home_outlined,
            title: 'Home',
            isActive: selectedIndex == 0,
            onTap: () => onItemTapped(0),
          ),
          MenuItem(
            icon: Icons.search,
            title: 'Search Products',
            isActive: selectedIndex == 1,
            onTap: () => onItemTapped(1),
          ),
          MenuItem(
            icon: Icons.shopping_cart_checkout_outlined,
            title: 'My Cart',
            isActive: selectedIndex == 2,
            onTap: () => onItemTapped(2),
          ),
          // *** ADDED CHECKOUT MENU ITEM ***
          MenuItem(
            icon: Icons.payment_outlined,
            title: 'Checkout',
            isActive: selectedIndex == 3,
            onTap: () => onItemTapped(3),
          ),
          const Spacer(),
          MenuItem(
            icon: Icons.logout_rounded,
            title: 'Logout',
            // *** UPDATED LOGOUT INDEX ***
            onTap: () => onItemTapped(4), // Special index for logout
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// The shared MenuItem widget, now with an onTap handler
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.black.withOpacity(0.2) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}