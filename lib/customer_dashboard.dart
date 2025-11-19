import 'package:flutter/material.dart';

// This is the main content for your dashboard.
// The Scaffold and SideMenu are now handled by main.dart.
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // We set the background color here for this specific page
    return Container(
      color: const Color.fromARGB(5, 31, 104, 178),
      child: const DashboardMainContent(),
    );
  }
}

// Renamed from MainContent to be specific
class DashboardMainContent extends StatelessWidget {
  const DashboardMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InfoCard(
                    title: 'Recent Orders',
                    color: const Color.fromARGB(255, 183, 92, 18),
                    child: Container(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InfoCard(
                    title: 'Account Credit',
                    color: const Color(0xFF2C3E50),
                    child: Container(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InfoCard(
                    title: 'Exclusive Deals',
                    color: const Color.fromARGB(255, 55, 214, 92),
                    child: Container(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: InfoCard(
                    title: 'New Arrivals',
                    color: const Color.fromARGB(255, 19, 132, 150),
                    child: Container(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final Color color;
  final Widget child;

  const InfoCard({
    super.key,
    required this.title,
    required this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(child: child),
        ],
      ),
    );
  }
}