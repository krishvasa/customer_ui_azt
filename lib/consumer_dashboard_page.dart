import 'package:flutter/material.dart';
import 'consumer_main_sidebar.dart';
import 'consumer_summary_card.dart';

class ConsumerDashboardPage extends StatefulWidget {
  const ConsumerDashboardPage({super.key});

  @override
  State<ConsumerDashboardPage> createState() => _ConsumerDashboardPageState();
}

class _ConsumerDashboardPageState extends State<ConsumerDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [
          // Sidebar
          const ConsumerMainSidebar(selectedPage: 'dashboard'),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  const Text(
                    'Dashboard',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Summary Cards
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(
                        child: ConsumerSummaryCard(
                          title: 'Recent Orders',
                          value: '8',
                          color: Color.fromARGB(255, 183, 92, 18),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ConsumerSummaryCard(
                          title: 'Account Credit',
                          value: '\$250',
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ConsumerSummaryCard(
                          title: 'Exclusive Deals',
                          value: '5',
                          color: Color.fromARGB(255, 55, 214, 92),
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: ConsumerSummaryCard(
                          title: 'New Arrivals',
                          value: '12',
                          color: Color.fromARGB(255, 19, 132, 150),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Recent Activity Section
                  const Text(
                    'Recent Activity',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        _buildActivityItem(
                          'Order #1234 delivered',
                          '2 hours ago',
                          Icons.check_circle,
                          Colors.green,
                        ),
                        const Divider(),
                        _buildActivityItem(
                          'New deal on Apples',
                          '1 day ago',
                          Icons.local_offer,
                          Colors.orange,
                        ),
                        const Divider(),
                        _buildActivityItem(
                          'Order #1233 shipped',
                          '2 days ago',
                          Icons.local_shipping,
                          Colors.blue,
                        ),
                      ],
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

  Widget _buildActivityItem(String title, String time, IconData icon, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(time, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
    );
  }
}