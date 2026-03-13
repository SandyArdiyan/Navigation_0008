import 'package:flutter/material.dart';
import 'package:navigasi/main_layout.dart';
import 'package:navigasi/mainui/home.dart';
import 'package:navigasi/auth/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      showAppBar: false,
      child: Container(
        color: MainLayout.backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    /// IMAGE
                    Image.asset(
                      'assets/images/login.png',
                      height: 200,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: MainLayout.primaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 80,
                              color: MainLayout.primaryColor,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    /// TITLE
                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: MainLayout.textTitleColor,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Sign in to your account to continue",
                      style: TextStyle(
                        fontSize: 16,
                        color: MainLayout.textSubtitleColor,
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// EMAIL
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: MainLayout.primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: MainLayout.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: MainLayout.primaryColor,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: MainLayout.inputFillColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        if (!value.contains("@")) {
                          return "Invalid email format";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    /// PASSWORD
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: MainLayout.primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(color: MainLayout.primaryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          borderSide: BorderSide(
                            color: MainLayout.primaryColor,
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: MainLayout.inputFillColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),

                