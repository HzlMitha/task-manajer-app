import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider untuk mengakses Supabase Client di mana saja
final supabaseProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});