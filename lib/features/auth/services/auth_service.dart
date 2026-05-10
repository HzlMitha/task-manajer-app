import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase;
  AuthService(this._supabase);

  static const String kRedirectUrl = 'io.supabase.flutter://google-auth';

  Future<void> signInWithGoogle() async {
    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: kRedirectUrl,
    );
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> signUpWithEmail(String email, String password) async {
  await _supabase.auth.signUp(
    email: email, 
    password: password,
  );
}

Future<void> signInWithEmail(String email, String password) async {
  await _supabase.auth.signInWithPassword(
    email: email,
    password: password,
  );
}
}
