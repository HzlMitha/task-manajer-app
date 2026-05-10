import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import Provider
import 'package:nama_aplikasi/core/providers/auth_provider.dart';
// Import Halaman
import 'package:nama_aplikasi/features/auth/pages/halaman_login.dart';
import 'package:nama_aplikasi/features/dashboard/pages/halaman_utama.dart';

void main() async {
  // 1. Inisialisasi binding Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Load konfigurasi dari file .env
  await dotenv.load(fileName: ".env");

  // 3. Inisialisasi Supabase menggunakan variable dari .env
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    
  );

  // 4. Jalankan aplikasi di dalam ProviderScope agar Riverpod aktif
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Memantau perubahan status login (Session)
    final statusAuth = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: Colors.blue,
      ),
      // Navigasi Otomatis berdasarkan status Auth
      home: statusAuth.when(
        data: (data) {
          // Jika sesi ada (user sudah login), masuk ke Halaman Utama
          if (data.session != null) {
            return const HalamanUtama(); 
          }
          // Jika sesi kosong, arahkan ke Halaman Login
          return const HalamanLogin();
        },
        // Tampilan saat aplikasi sedang mengecek koneksi/sesi
        loading: () => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        // Tampilan jika terjadi error pada provider
        error: (e, st) => Scaffold(
          body: Center(child: Text("Terjadi Kesalahan: $e")),
        ),
      ),
    );
  }
}