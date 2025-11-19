import 'package:azt/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'consumer_dashboard_page.dart';

class ConsumerHomePage extends StatefulWidget {
  const ConsumerHomePage({super.key});

  @override
  State<ConsumerHomePage> createState() => _ConsumerHomePageState();
}

class _ConsumerHomePageState extends State<ConsumerHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Consumer Hub"),
        backgroundColor: const Color.fromARGB(255, 104, 147, 190),
        foregroundColor: Colors.white,
        elevation: 2,
        actions: [
          // Logout button
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        final authCubit = context.read<AuthCubit>();
                        authCubit.logout();
                      },
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Theme(
        data: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[200],
          dataTableTheme: DataTableThemeData(
            headingRowColor: WidgetStateProperty.all(Colors.blue.shade100),
            dataRowColor: WidgetStateProperty.all(Colors.white),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            titleLarge: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black87),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 104, 147, 190),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        child: Navigator(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const ConsumerDashboardPage(),
            );
          },
        ),
      ),
    );
  }
}