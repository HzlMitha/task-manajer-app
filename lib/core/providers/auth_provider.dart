import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_provider.dart';
import '../../features/auth/services/auth_service.dart';

// 1. Provider untuk Service (Logika Login)
final authServiceProvider = Provider<AuthService>((ref) {
  // Mengambil instance Supabase dari provider sebelah
  final supabase = ref.watch(supabaseProvider);
  return AuthService(supabase);
});

// 2. Provider untuk memantau status login (sudah login/belum)
final authStateProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(supabaseProvider).auth.onAuthStateChange;
});