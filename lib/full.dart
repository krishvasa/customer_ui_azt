import 'package:flutter/material.dart';

// --- Menu State Definition ---
enum MenuOption { dashboard, purchases, customers, products }

// --- Main Application Widget ---
void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Retailer Dashboard',
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

// Custom Colors
const Color kSidebarBg = Color(0xFF34495E);
const Color kSelectedSidebarItem = Color(0xFF4A6888);
const Color kPendingOrders = Color(0xFFE67E22);
const Color kRevenue = Color(0xFF34495E);
const Color kLowStock = Color(0xFF2ECC71);
const Color kWholesalerButton = Color(0xFF5DADE2);

// --- Stateful Dashboard Screen ---
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  MenuOption _selectedMenu = MenuOption.dashboard;

  void _onMenuTapped(MenuOption menu) {
    setState(() {
      _selectedMenu = menu;
    });
  }

  Widget _buildBody() {
    switch (_selectedMenu) {
      case MenuOption.dashboard:
        // Pass the navigation callback to the dashboard view
        return DashboardView(onMenuTap: _onMenuTapped);
      case MenuOption.purchases:
        return const PurchasesView();
      case MenuOption.customers:
        return const CustomersView();
      case MenuOption.products:
        return const ProductsView();
      default:
        return DashboardView(onMenuTap: _onMenuTapped);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Sidebar(
            selectedMenu: _selectedMenu,
            onMenuTap: _onMenuTapped,
          ),
          Expanded(
            // This SingleChildScrollView handles the PAGE scrolling
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  const TopBar(),
                  const SizedBox(height: 24),
                  _buildBody(), // Dynamic body content
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 1. Sidebar Widget ---
class Sidebar extends StatelessWidget {
  final MenuOption selectedMenu;
  final Function(MenuOption) onMenuTap;

  const Sidebar({super.key, required this.selectedMenu, required this.onMenuTap});

  Widget _buildSidebarItem(IconData icon, String title, MenuOption menuOption) {
    bool isSelected = selectedMenu == menuOption;

    return InkWell(
      onTap: () => onMenuTap(menuOption),
      child: Container(
        margin: const EdgeInsets.only(top: 8.0, right: 10.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? kSelectedSidebarItem : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        child: Row(
          children: <Widget>[
            Icon(icon, color: isSelected ? Colors.white : Colors.white70),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: MediaQuery.of(context).size.height,
      color: kSidebarBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(Icons.dashboard_customize, color: Colors.white, size: 28),
                SizedBox(width: 10),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildSidebarItem(Icons.dashboard, 'Dashboard', MenuOption.dashboard),
          _buildSidebarItem(Icons.shopping_bag_outlined, 'Purchases', MenuOption.purchases),
          _buildSidebarItem(Icons.people_alt_outlined, 'Customers', MenuOption.customers),
          const SizedBox(height: 20),
          _buildSidebarItem(Icons.inventory_2_outlined, 'Products', MenuOption.products),
        ],
      ),
    );
  }
}

// --- Top Bar ---
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey[500]),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
          ),
        ),
        const Icon(Icons.notifications_none, color: Colors.grey, size: 24),
        const SizedBox(width: 20),
        const Icon(Icons.person_outline, color: Colors.grey, size: 24),
        const SizedBox(width: 10),
        const CircleAvatar(
          backgroundColor: Colors.blueGrey,
          radius: 18,
          child: Icon(Icons.person, color: Colors.white, size: 20),
        ),
      ],
    );
  }
}

// --- Dynamic Content Views ---

// 1. Dashboard View
class DashboardView extends StatelessWidget {
  final Function(MenuOption) onMenuTap; // Callback for navigation
  const DashboardView({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SummaryCardsRow(),
        const SizedBox(height: 24),
        SizedBox(
          height: 450, // Fixed height for the row
          child: RecentActivitySection(onMenuTap: onMenuTap), // Pass callback
        ),
      ],
    );
  }
}

// 2. Purchases View
class PurchasesView extends StatelessWidget {
  const PurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Detailed Wholesaler Purchase History',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kSidebarBg),
        ),
        const Divider(height: 30),
        WholesalePurchaseDetailList(), // Use new detailed list
      ],
    );
  }
}

// 3. Customers View
class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Customer Purchase History',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kSidebarBg),
        ),
        const Divider(height: 30),
        CustomerPurchaseDetailList(), // Use new detailed list
      ],
    );
  }
}

// 4. Products View (Unchanged)
class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Inventory and Pricing',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kSidebarBg),
        ),
        const Divider(height: 30),
        ProductDetailTable(),
      ],
    );
  }
}

// --- Component Widgets ---

// Summary Cards (Unchanged)
class SummaryCardsRow extends StatelessWidget {
  const SummaryCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _buildSummaryCard(
            title: 'Pending Orders',
            value: '18',
            subtitle: 'New this week',
            color: kPendingOrders,
            textColor: Colors.white,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildSummaryCard(
            title: 'Revenue (This Month)',
            value: '\$85,840',
            color: kRevenue,
            textColor: Colors.white,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildSummaryCard(
            title: 'Low Stock Items',
            value: '15',
            color: kLowStock,
            textColor: Colors.white,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildActionCard(
            title: 'New Wholssvaler',
            subtitle: 'New Pasta Line',
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    String? subtitle,
    required Color color,
    Color textColor = Colors.black,
  }) {
    return Card(
      color: color,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: textColor.withOpacity(0.9), fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 5),
              Text(
                subtitle,
                // ignore: deprecated_member_use
                style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
  }) {
    return Card(
      color: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            Text(subtitle, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kWholesalerButton,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: const Text(
                'View New Details',
                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Recent Activity Section (Now accepts and passes callback)
class RecentActivitySection extends StatelessWidget {
  final Function(MenuOption) onMenuTap;
  const RecentActivitySection({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: RecentCustomerOrders(onMenuTap: onMenuTap), // Pass callback
        ),
        const SizedBox(width: 24),
        Expanded(
          child: RecentWholesalePurchases(onMenuTap: onMenuTap), // Pass callback
        ),
      ],
    );
  }
}

// --- Table Helper Widget (Used by Dashboard cards) ---
class _TableRow extends StatelessWidget {
  final List<String> cells;
  final bool isHeader;

  const _TableRow(this.cells, {this.isHeader = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cells.map((item) {
          return Expanded(
            child: Text(
              item,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                color: isHeader ? Colors.black54 : Colors.black87,
                fontSize: 14,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// --- Dashboard Sub-Tables (Now clickable and scrollable) ---
class RecentCustomerOrders extends StatelessWidget {
  final Function(MenuOption) onMenuTap;
  const RecentCustomerOrders({super.key, required this.onMenuTap});

  // Added more data to make it scroll
  static const List<List<String>> data = [
    ['1001', 'Nealif', '\$120.00', 'Completed'],
    ['1002', 'Bob Smith', '\$45.50', 'Completed'],
    ['1003', 'Charlie B.', '\$88.00', 'Pending'],
    ['1004', 'Diana P.', '\$210.10', 'Completed'],
    ['1005', 'Evan Green', '\$30.00', 'Completed'],
    ['1006', 'Fiona G.', '\$150.20', 'Completed'],
    ['1007', 'George H.', '\$75.00', 'Shipped'],
    ['1008', 'Hannah I.', '\$90.00', 'Completed'],
    ['1009', 'Ian J.', '\$112.00', 'Pending'],
    ['1010', 'Julia K.', '\$65.80', 'Completed'],
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onMenuTap(MenuOption.customers), // Navigate on tap
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Recent Customer Orders',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _TableRow(['Order ID', 'Customer', 'Total', 'Status'], isHeader: true),
              Expanded(
                // This ListView handles IN-CARD scrolling
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return _TableRow(data[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentWholesalePurchases extends StatelessWidget {
  final Function(MenuOption) onMenuTap;
  const RecentWholesalePurchases({super.key, required this.onMenuTap});

  // Added more data to make it scroll
  static const List<List<String>> data = [
    ['PO-201', 'Global Supply', '15 Items', 'Pending'],
    ['PO-202', 'Food Dist.', '8 Items', 'Completed'],
    ['PO-203', 'Regional Inc.', '22 Items', 'Completed'],
    ['PO-204', 'Bulk Pasta', '10 Items', 'Shipped'],
    ['PO-205', 'Global Supply', '18 Items', 'Completed'],
    ['PO-206', 'Sauce Co.', '5 Items', 'Pending'],
    ['PO-207', 'Regional Inc.', '30 Items', 'Completed'],
    ['PO-208', 'Food Dist.', '12 Items', 'Completed'],
    ['PO-209', 'Global Supply', '9 Items', 'Shipped'],
    ['PO-210', 'Cheese Ltd.', '14 Items', 'Completed'],
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onMenuTap(MenuOption.purchases), // Navigate on tap
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Recent Wholesale Purchases',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              _TableRow(['Order ID', 'Supplier', 'Items', 'Status'], isHeader: true),
              Expanded(
                // This ListView handles IN-CARD scrolling
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return _TableRow(data[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- New Data Models ---

class CustomerPurchase {
  final String name;
  final double totalTransactions;
  final List<String> purchasedProducts;

  CustomerPurchase({
    required this.name,
    required this.totalTransactions,
    required this.purchasedProducts,
  });
}

class WholesalePurchase {
  final String id;
  final String supplier;
  final double totalValue;
  final List<String> purchasedProducts;

  WholesalePurchase({
    required this.id,
    required this.supplier,
    required this.totalValue,
    required this.purchasedProducts,
  });
}

// --- New Detail Lists (for Customers and Purchases pages) ---

// Replaces CustomerDetailTable
class CustomerPurchaseDetailList extends StatelessWidget {
  CustomerPurchaseDetailList({super.key});

  // **DATA LIST EXTENDED TO 30 ENTRIES**
  final List<CustomerPurchase> data = [
    CustomerPurchase(name: 'Alice Johnson', totalTransactions: 560.50, purchasedProducts: ['Spoon', 'Fork', 'Plate (x4)']),
    CustomerPurchase(name: 'Bob Smith', totalTransactions: 120.00, purchasedProducts: ['Mug (x2)']),
    CustomerPurchase(name: 'Charlie Brown', totalTransactions: 980.99, purchasedProducts: ['Spoon (x8)', 'Fork (x8)', 'Knife (x8)', 'Plate (x8)', 'Glass (x8)']),
    CustomerPurchase(name: 'Diana Prince', totalTransactions: 35.00, purchasedProducts: ['Bowl (x2)', 'Spoon (x2)']),
    CustomerPurchase(name: 'Evan Green', totalTransactions: 720.10, purchasedProducts: ['Glass (x12)', 'Mug (x6)']),
    CustomerPurchase(name: 'Fiona Glen', totalTransactions: 88.00, purchasedProducts: ['Knife (x4)', 'Plate (x4)']),
    CustomerPurchase(name: 'George Hill', totalTransactions: 199.50, purchasedProducts: ['Bowl (x6)', 'Mug (x6)']),
    CustomerPurchase(name: 'Hannah Ivy', totalTransactions: 310.00, purchasedProducts: ['Spoon (x10)', 'Plate (x10)']),
    CustomerPurchase(name: 'Ian Jacobs', totalTransactions: 45.00, purchasedProducts: ['Fork (x3)', 'Knife (x3)']),
    CustomerPurchase(name: 'Julia King', totalTransactions: 620.00, purchasedProducts: ['Glass (x20)']),
    CustomerPurchase(name: 'Leo Martin', totalTransactions: 110.20, purchasedProducts: ['Mug (x4)', 'Bowl (x4)']),
    CustomerPurchase(name: 'Mia Nelson', totalTransactions: 230.80, purchasedProducts: ['Plate (x6)', 'Glass (x6)']),
    CustomerPurchase(name: 'Neal O\'Brien', totalTransactions: 80.00, purchasedProducts: ['Spoon (x12)']),
    CustomerPurchase(name: 'Olivia Page', totalTransactions: 510.00, purchasedProducts: ['Full Cutlery Set (x2)', 'Dinner Set (x2)']),
    CustomerPurchase(name: 'PeterQuinn', totalTransactions: 130.40, purchasedProducts: ['Knife (x10)']),
    // --- 15 NEW ENTRIES START HERE ---
    CustomerPurchase(name: 'Quincy Adams', totalTransactions: 95.00, purchasedProducts: ['Mug (x10)']),
    CustomerPurchase(name: 'Rachel Stone', totalTransactions: 125.50, purchasedProducts: ['Spoon (x5)', 'Fork (x5)']),
    CustomerPurchase(name: 'Samuel Tran', totalTransactions: 330.00, purchasedProducts: ['Plate (x12)', 'Bowl (x12)']),
    CustomerPurchase(name: 'Tina Lopez', totalTransactions: 75.80, purchasedProducts: ['Glass (x6)']),
    CustomerPurchase(name: 'Umar Farooq', totalTransactions: 210.00, purchasedProducts: ['Knife (x10)', 'Plate (x5)']),
    CustomerPurchase(name: 'Victoria Chen', totalTransactions: 800.00, purchasedProducts: ['Full Dinner Set (x4)']),
    CustomerPurchase(name: 'Walter White', totalTransactions: 62.00, purchasedProducts: ['Bowl (x4)', 'Spoon (x4)']),
    CustomerPurchase(name: 'Xena Yang', totalTransactions: 140.00, purchasedProducts: ['Mug (x12)']),
    CustomerPurchase(name: 'Yusuf Ahmed', totalTransactions: 290.00, purchasedProducts: ['Glass (x10)', 'Plate (x10)']),
    CustomerPurchase(name: 'Zoe Kravitz', totalTransactions: 55.00, purchasedProducts: ['Fork (x10)']),
    CustomerPurchase(name: 'Aaron Kim', totalTransactions: 180.00, purchasedProducts: ['Spoon (x20)', 'Knife (x10)']),
    CustomerPurchase(name: 'Bella Hadid', totalTransactions: 410.00, purchasedProducts: ['Plate (x15)', 'Glass (x15)']),
    CustomerPurchase(name: 'Chris Evans', totalTransactions: 99.00, purchasedProducts: ['Mug (x8)']),
    CustomerPurchase(name: 'Dev Patel', totalTransactions: 165.00, purchasedProducts: ['Bowl (x10)', 'Spoon (x10)']),
    CustomerPurchase(name: 'Eliza Thorn', totalTransactions: 220.00, purchasedProducts: ['Full Cutlery Set (x2)']),
  ];

  @override
  Widget build(BuildContext context) {
    // This Column is inside the page's SingleChildScrollView.
    // We just add all the cards to it.
    return Column(
      children: data.map((purchase) => _CustomerPurchaseCard(purchase: purchase)).toList(),
    );
  }
}

// Replaces WholesalePurchaseDetailTable
class WholesalePurchaseDetailList extends StatelessWidget {
  WholesalePurchaseDetailList({super.key});

  // **DATA LIST EXTENDED TO 29 ENTRIES**
  final List<WholesalePurchase> data = [
    WholesalePurchase(id: 'PO-201', supplier: 'Global Supply Co.', totalValue: 5200.00, purchasedProducts: ['Spoon (x1000)', 'Fork (x1000)']),
    WholesalePurchase(id: 'PO-202', supplier: 'Food Distributor LLC', totalValue: 8150.00, purchasedProducts: ['Plate (x500)', 'Bowl (x500)', 'Mug (x200)']),
    WholesalePurchase(id: 'PO-203', supplier: 'Regional Grocers', totalValue: 1990.00, purchasedProducts: ['Glass (x300)']),
    WholesalePurchase(id: 'PO-204', supplier: 'Bulk Pasta Inc', totalValue: 3500.00, purchasedProducts: ['Knife (x1000)']),
    WholesalePurchase(id: 'PO-205', supplier: 'Global Supply Co.', totalValue: 7250.00, purchasedProducts: ['Mug (x500)', 'Glass (x500)']),
    WholesalePurchase(id: 'PO-206', supplier: 'Kitchenware Direct', totalValue: 11200.00, purchasedProducts: ['Full Cutlery Set (x200)']),
    WholesalePurchase(id: 'PO-207', supplier: 'Food Distributor LLC', totalValue: 4300.00, purchasedProducts: ['Plate (x400)']),
    WholesalePurchase(id: 'PO-208', supplier: 'Regional Grocers', totalValue: 2100.00, purchasedProducts: ['Bowl (x400)']),
    WholesalePurchase(id: 'PO-209', supplier: 'Global Supply Co.', totalValue: 9500.00, purchasedProducts: ['Spoon (x2000)', 'Fork (x2000)', 'Knife (x2000)']),
    WholesalePurchase(id: 'PO-210', supplier: 'Kitchenware Direct', totalValue: 15000.00, purchasedProducts: ['Dinner Set (x150)']),
    WholesalePurchase(id: 'PO-211', supplier: 'Food Distributor LLC', totalValue: 3200.00, purchasedProducts: ['Mug (x800)']),
    WholesalePurchase(id: 'PO-212', supplier: 'Global Supply Co.', totalValue: 6100.00, purchasedProducts: ['Plate (x1000)']),
    WholesalePurchase(id: 'PO-213', supplier: 'Regional Grocers', totalValue: 1800.00, purchasedProducts: ['Glass (x300)']),
    WholesalePurchase(id: 'PO-214', supplier: 'Kitchenware Direct', totalValue: 8800.00, purchasedProducts: ['Bowl (x1000)', 'Spoon (x1000)']),
    // --- 15 NEW ENTRIES START HERE ---
    WholesalePurchase(id: 'PO-215', supplier: 'Bulk Pasta Inc', totalValue: 4500.00, purchasedProducts: ['Spoon (x1500)']),
    WholesalePurchase(id: 'PO-216', supplier: 'Regional Grocers', totalValue: 3100.00, purchasedProducts: ['Fork (x1000)', 'Knife (x500)']),
    WholesalePurchase(id: 'PO-217', supplier: 'Food Distributor LLC', totalValue: 9200.00, purchasedProducts: ['Plate (x1200)', 'Glass (x1200)']),
    WholesalePurchase(id: 'PO-218', supplier: 'Global Supply Co.', totalValue: 11000.00, purchasedProducts: ['Mug (x2000)']),
    WholesalePurchase(id: 'PO-219', supplier: 'Kitchenware Direct', totalValue: 7600.00, purchasedProducts: ['Bowl (x1500)']),
    WholesalePurchase(id: 'PO-220', supplier: 'Bulk Pasta Inc', totalValue: 2200.00, purchasedProducts: ['Spoon (x500)']),
    WholesalePurchase(id: 'PO-221', supplier: 'Global Supply Co.', totalValue: 13000.00, purchasedProducts: ['Full Cutlery Set (x300)']),
    WholesalePurchase(id: 'PO-222', supplier: 'Regional Grocers', totalValue: 4800.00, purchasedProducts: ['Glass (x1000)']),
    WholesalePurchase(id: 'PO-223', supplier: 'Food Distributor LLC', totalValue: 8100.00, purchasedProducts: ['Plate (x1000)']),
    WholesalePurchase(id: 'PO-224', supplier: 'Kitchenware Direct', totalValue: 19000.00, purchasedProducts: ['Dinner Set (x200)']),
    WholesalePurchase(id: 'PO-225', supplier: 'Global Supply Co.', totalValue: 6500.00, purchasedProducts: ['Mug (x1000)', 'Bowl (x500)']),
    WholesalePurchase(id: 'PO-226', supplier: 'Bulk Pasta Inc', totalValue: 3900.00, purchasedProducts: ['Knife (x1200)']),
    WholesalePurchase(id: 'PO-227', supplier: 'Food Distributor LLC', totalValue: 5300.00, purchasedProducts: ['Fork (x1500)']),
    WholesalePurchase(id: 'PO-228', supplier: 'Regional Grocers', totalValue: 7100.00, purchasedProducts: ['Plate (x800)', 'Glass (x500)']),
    WholesalePurchase(id: 'PO-229', supplier: 'Kitchenware Direct', totalValue: 16500.00, purchasedProducts: ['Spoon (x3000)', 'Bowl (x2000)']),
  ];

  @override
  Widget build(BuildContext context) {
    // This Column is inside the page's SingleChildScrollView.
    return Column(
      children: data.map((purchase) => _WholesalePurchaseCard(purchase: purchase)).toList(),
    );
  }
}

// --- New Card Widgets for Detail Pages ---

class _CustomerPurchaseCard extends StatelessWidget {
  final CustomerPurchase purchase;
  const _CustomerPurchaseCard({required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Name and Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  purchase.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSidebarBg),
                ),
                Text(
                  '\$${purchase.totalTransactions.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kRevenue),
                ),
              ],
            ),
            const Divider(height: 20),
            // Bottom Section: Product List
            const Text(
              'Products Purchased:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            // Product list
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: purchase.purchasedProducts.map((product) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '• $product',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _WholesalePurchaseCard extends StatelessWidget {
  final WholesalePurchase purchase;
  const _WholesalePurchaseCard({required this.purchase});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: ID, Supplier, Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: ID and Supplier
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      purchase.id,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      purchase.supplier,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kSidebarBg),
                    ),
                  ],
                ),
                // Right side: Total
                Text(
                  '\$${purchase.totalValue.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: kRevenue),
                ),
              ],
            ),
            const Divider(height: 20),
            // Bottom Section: Product List
            const Text(
              'Products in Order:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            // Product list
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: purchase.purchasedProducts.map((product) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '• $product',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Product Detail Table (Unchanged from last step) ---

class Product {
  final String name;
  final String price;
  final IconData icon;
  const Product({required this.name, required this.price, required this.icon});
}

class ProductDetailTable extends StatelessWidget {
  const ProductDetailTable({super.key});

  final List<Product> data = const [
    Product(name: 'Spoon', price: '\$1.99', icon: Icons.local_dining_outlined),
    Product(name: 'Fork', price: '\$1.99', icon: Icons.restaurant_outlined),
    Product(name: 'Knife', price: '\$2.49', icon: Icons.restaurant_outlined),
    Product(name: 'Plate', price: '\$5.99', icon: Icons.album_outlined),
    Product(name: 'Glass', price: '\$3.99', icon: Icons.local_bar_outlined),
    Product(name: 'Mug', price: '\$4.50', icon: Icons.local_cafe_outlined),
    Product(name: 'Bowl', price: '\$5.50', icon: Icons.rice_bowl_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Retail Products for Sale',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Divider(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 40,
                    child: Text(
                      'Icon',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Product Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      'Retail Price',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ...data.map((product) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 40,
                      child: Icon(
                        product.icon,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Text(
                        product.price,
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}