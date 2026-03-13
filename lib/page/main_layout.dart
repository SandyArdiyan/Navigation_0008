import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;
  final bool showAppBar;

  const MainLayout({
    super.key,
    required this.child,
    this.title = "",
    this.showAppBar = false,
  });

  static const Color primaryColor = Color(0xFF4CAF50);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textTitleColor = Colors.black;
  static const Color textSubtitleColor = Colors.grey;
  static const Color labelColor = Colors.black54;
  static const Color inputFillColor = Color(0xFFF0F0F0);
  static const Color accentOrange = Colors.orange;
  static const Color accentYellow = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: showAppBar
          ? AppBar(
              title: Text(title),
              backgroundColor: primaryColor,
            )
          : null,

      body: child,
    );
  }
}