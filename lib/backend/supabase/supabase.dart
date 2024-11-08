import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

export 'database/database.dart';

String _kSupabaseUrl = 'https://mvsuioadmjsadkyamdqj.supabase.co';
String _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im12c3Vpb2FkbWpzYWRreWFtZHFqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjczODAyNjMsImV4cCI6MjA0Mjk1NjI2M30.0_FMoLLEmBRDEUWu3eYVkWohG5zbR-_ukE1W3DDmoV4';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        anonKey: _kSupabaseAnonKey,
        debug: false,
      );
}
