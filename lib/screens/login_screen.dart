import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = false;
  String errorText = '';

  void login() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => errorText = 'Tüm alanları doldurun.');
      return;
    }

    if (email == 'garson@test.com' && password == 'Test123!') {
      Navigator.pushNamed(context, '/garson');
    } else if (email == 'kasiyer@test.com' && password == 'Test123!') {
      Navigator.pushNamed(context, '/kasiyer');
    } else if (email == 'test123@test.com' && password == 'Test123!') {
      Navigator.pushNamed(context, '/admin');
    } else {
      setState(() => errorText = 'Geçersiz giriş.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5EFFF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 420,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color(0xFFCBC3E3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Color(0xFFA294F9),
                    child: Icon(Icons.restaurant, color: Colors.white),
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Giriş Yap',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA294F9)),
                  ),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    'Restoran Yönetim Sistemine Hoş Geldiniz',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 14, color: Color(0xFF2D1B69)),
                  ),
                ),
                SizedBox(height: 24),
                Text('Email', style: TextStyle(color: Colors.black87)),
                SizedBox(height: 6),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email adresinizi girin',
                    filled: true,
                    fillColor: Color(0xFFE5D9F2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                SizedBox(height: 16),
                Text('Şifre', style: TextStyle(color: Colors.black87)),
                SizedBox(height: 6),
                TextField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    hintText: 'Şifrenizi girin',
                    filled: true,
                    fillColor: Color(0xFFE5D9F2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => passwordVisible = !passwordVisible),
                    ),
                  ),
                ),
                if (errorText.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(errorText,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center),
                  ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA294F9),
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Giriş Yap',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot');
                  },
                  child: Text('Şifremi Unuttum'),
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFFA294F9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
