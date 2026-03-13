import 'package:flutter/material.dart';
import 'package:navigasi/auth/login.dart';
import 'package:navigasi/mainui/home.dart';
import 'package:navigasi/page/order_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4D51ED)),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/order': (context) => const OrderPage(),
      },
    );
  }
}