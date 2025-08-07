import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/reset_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restoran Uygulama',
      theme: ThemeData(fontFamily: 'Arial'),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
        '/admin': (context) => const Scaffold(
              body: Center(child: Text('Admin Dashboard')),
            ),
        '/garson': (context) => const Scaffold(
              body: Center(child: Text('Garson Sayfası')),
            ),
        '/kasiyer': (context) => const Scaffold(
              body: Center(child: Text('Kasiyer Sayfası')),
            ),
      },
    );
  }
}
