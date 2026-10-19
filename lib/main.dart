import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/data/repositories/profile_repository.dart';
import 'features/splash/presentation/screens/splash_screen.dart';

final hasProfileFutureProvider = FutureProvider<bool>((ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.hasProfile();
});

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: AcordeApp(),
    ),
  );
}

class AcordeApp extends StatelessWidget {
  const AcordeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acorde',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}

