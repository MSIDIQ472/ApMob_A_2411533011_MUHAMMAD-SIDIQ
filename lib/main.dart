import 'package:flutter/material.dart';

import 'Praktikum 05/login_screen.dart';
import 'Praktikum 05/main_screen.dart';
import 'Praktikum 05/add_transaction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker Final',
      theme: ThemeData(primarySwatch: Colors.amber),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/': (context) => const MainScreen(),
        '/add': (context) => const AddTransactionScreen(),
      },
    );
  }
}

