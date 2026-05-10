import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/auth_provider.dart';

class HalamanUtama extends ConsumerWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mengambil data user yang sedang login dari Supabase
    final asyncUserState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task Manager",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              // Memanggil fungsi signOut dari provider
              await ref.read(authServiceProvider).signOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Halo, Selamat Datang!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            asyncUserState.when(
              data: (state) => Text(
                "Email: ${state.session?.user.email ?? 'User'}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              loading: () => const Text(
                "Loading user info...",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              error: (error, stack) => Text(
                "Error: $error",
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            ),
            const SizedBox(height: 30),

            // Area Konten Tugas (Placeholder untuk PBL Semester 4)
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        size: 80,
                        color: Colors.blue,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Belum ada tugas hari ini.",
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Nanti di sini bisa ditambahkan navigasi ke form tambah tugas
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
