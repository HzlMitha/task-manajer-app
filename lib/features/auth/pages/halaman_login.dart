import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nama_aplikasi/features/auth/pages/halaman_daftar.dart';
import 'package:nama_aplikasi/features/dashboard/pages/halaman_utama.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/providers/auth_provider.dart';

class HalamanLogin extends ConsumerStatefulWidget {
  const HalamanLogin({super.key});

  @override
  ConsumerState<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends ConsumerState<HalamanLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    // Taruh Listener di sini
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      if (data.session != null && mounted) {
        // Ganti ke halaman tujuan setelah login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HalamanUtama()),
        );
      }
    });
  }

  @override
  void dispose() {
    // Bersihkan controller saat halaman ditutup
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Task Manager",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () async {
                try {
                  await ref.read(authServiceProvider).signInWithEmail(
                    emailController.text, 
                    passwordController.text
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Gagal: $e")));
                }
              },
              child: const Text("Masuk"),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              icon: const Icon(Icons.login), // Kamu bisa ganti pakai icon Google beneran nanti
              label: const Text("Masuk dengan Google"),
              onPressed: () async {
                try {
                  await ref.read(authServiceProvider).signInWithGoogle();
                  // Jika berhasil, biasanya Supabase otomatis handle session, 
                  // tapi kamu bisa tambahkan navigasi ke home di sini jika perlu.
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Google Login Gagal: $e")),
                  );
                }
              },
            ),
            TextButton(
              onPressed: () {
                // Pindah ke halaman daftar
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HalamanDaftar()));
              },
              child: const Text("Belum punya akun? Daftar di sini"),
            ),
          ],
        ),
      ),
    );
  }
}