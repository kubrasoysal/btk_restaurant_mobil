import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  String message = '';
  String error = '';
  bool loading = false;

  Future<void> sendResetLink() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() => error = 'Lütfen e-posta adresinizi girin.');
      return;
    }

    setState(() {
      loading = true;
      error = '';
      message = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http://<BACKEND_URL>/api/forgot-password'), // ← endpoint'i backend'e göre değiştir
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        setState(() => message = 'Sıfırlama bağlantısı e-posta adresinize gönderildi.');
      } else {
        setState(() => error = 'E-posta gönderilemedi. Tekrar deneyin.');
      }
    } catch (e) {
      setState(() => error = 'Hata: ${e.toString()}');
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
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Color(0xFFFFC93C),
                  child: Icon(Icons.lock_open, color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  'Şifremi Unuttum',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA294F9),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'E-posta adresinizi girin, şifre sıfırlama bağlantısı göndereceğiz',
                  style: TextStyle(fontSize: 14, color: Color(0xFF2D1B69)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-posta Adresi',
                    hintText: 'E-posta adresinizi girin',
                    filled: true,
                    fillColor: Color(0xFFE5D9F2),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                if (error.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(error, style: TextStyle(color: Colors.red)),
                  ),
                if (message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(message, style: TextStyle(color: Colors.green[700])),
                  ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: loading ? null : sendResetLink,
                  child: Text(loading ? 'Gönderiliyor...' : 'Şifre Sıfırlama Bağlantısı Gönder'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48),
                    backgroundColor: Color(0xFFA294F9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Giriş Sayfasına Dön'),
                  style: TextButton.styleFrom(foregroundColor: Color(0xFFA294F9)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
