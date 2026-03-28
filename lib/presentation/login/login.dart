// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/CRESCENT-1-superJumbo.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),
          Center(
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ===== Title =====
                  const Text(
                    "SYSTEM LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _loginField(
                    hint: "User ID",
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),
                  _loginField(
                    hint: "Password",
                    icon: Icons.lock_outline,
                    obscure: true,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // بعد التحقق من بيانات تسجيل الدخول يمكنك إضافة منطق التحقق هنا
                        // ثم التوجيه إلى صفحة الترحيب لاختيار الشاشة
                        context.go('/welcome');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _loginField({
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.black.withOpacity(0.8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
