import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/presentation/screens/main_scaffold_screen.dart';
import 'features/onboarding/data/repositories/profile_repository.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
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

class _StartupGate extends ConsumerWidget {
  const _StartupGate();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasProfileAsync = ref.watch(hasProfileFutureProvider);

    return hasProfileAsync.when(
      loading: () => const Scaffold(
        backgroundColor: AppColors.darkBackground,
        body: Center(
          child: CircularProgressIndicator(color: AppColors.actionGreen),
        ),
      ),
      error: (_, __) => const MainScaffoldScreen(),
      data: (hasProfile) {
        if (!hasProfile) {
          return const OnboardingScreen();
        }
        return const MainScaffoldScreen();
      },
    );
  }
}
