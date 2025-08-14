import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';

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
  String userRole = '';
  bool loading = false;

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => errorText = 'Tüm alanları doldurun.');
      return;
    }

    setState(() {
      loading = true;
      errorText = '';
      userRole = '';
    });

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          int roleId = data['roleId'];
          String roleText = '';
          if (roleId == 0) {
            roleText = 'Admin olarak giriş yaptınız';
          } else if (roleId == 1) {
            roleText = 'Garson olarak giriş yaptınız';
          } else if (roleId == 2) {
            roleText = 'Kasiyer olarak giriş yaptınız';
          } else {
            roleText = 'Bilinmeyen rol';
          }
          setState(() {
            userRole = roleText;
            errorText = '';
          });
        } else {
          setState(() => errorText = data['message'] ?? 'Giriş başarısız.');
        }
      } else {
        setState(() => errorText = 'Sunucu hatası: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => errorText = 'Hata: ${e.toString()}');
    } finally {
      setState(() => loading = false);
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
                if (userRole.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(userRole,
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center),
                  ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: loading ? null : login,
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
