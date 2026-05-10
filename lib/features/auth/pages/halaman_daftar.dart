import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/auth_provider.dart';

class HalamanDaftar extends ConsumerStatefulWidget {
  const HalamanDaftar({super.key});

  @override
  ConsumerState<HalamanDaftar> createState() => _HalamanDaftarState();
}

class _HalamanDaftarState extends ConsumerState<HalamanDaftar> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buat Akun Baru")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password (min. 6 karakter)"),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(authServiceProvider).signUpWithEmail(
                    emailController.text, 
                    passwordController.text
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Pendaftaran berhasil! Silakan cek email untuk verifikasi."))
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Daftar Gagal: $e")));
                }
              },
              child: const Text("Daftar Sekarang"),
            ),
          ],
        ),
      ),
    );
  }
}