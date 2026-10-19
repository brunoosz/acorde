import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../navigation/presentation/screens/main_scaffold_screen.dart';
import '../../../onboarding/data/repositories/profile_repository.dart';
import '../../../onboarding/presentation/screens/onboarding_screen.dart';
import '../../../../main.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final Animation<double> _letterFade;
  late final Animation<double> _letterScale;
  late final Animation<double> _dotScale;
  late final Animation<double> _textFade;
  late final Animation<Offset> _textSlide;

  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    // Letter 'a' entrance: 0 to 45%
    _letterFade = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
    );
    _letterScale = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
      ),
    );

    // Orange dot '.' pop: 35% to 70% with spring
    _dotScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.35, 0.70, curve: Curves.elasticOut),
      ),
    );

    // Subtitle fade and slide: 55% to 90%
    _textFade = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.55, 0.90, curve: Curves.easeIn),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.55, 0.90, curve: Curves.easeOutCubic),
      ),
    );

    _logoController.forward();
    _checkDestination();
  }

  Future<void> _checkDestination() async {
    // Wait for at least the animation minimum duration
    await Future.wait([
      Future.delayed(const Duration(milliseconds: 1500)),
      ref.read(hasProfileFutureProvider.future).catchError((_) => false),
    ]);

    if (!mounted || _navigated) return;
    _navigated = true;

    final hasProfile = ref.read(hasProfileFutureProvider).value ?? false;
    final targetWidget = hasProfile ? const MainScaffoldScreen() : const OnboardingScreen();

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) => targetWidget,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableAnimations = MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    if (disableAnimations && !_navigated) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkDestination());
    }

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Mark "a."
            AnimatedBuilder(
              animation: _logoController,
              builder: (context, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    // Letter 'a'
                    FadeTransition(
                      opacity: _letterFade,
                      child: ScaleTransition(
                        scale: _letterScale,
                        child: Text(
                          'a',
                          style: AppTypography.titleHuge(
                            color: AppColors.textLight,
                          ).copyWith(fontSize: 96, height: 0.8),
                        ),
                      ),
                    ),
                    // Accent dot '.'
                    ScaleTransition(
                      scale: _dotScale,
                      child: Container(
                        width: 22,
                        height: 22,
                        margin: const EdgeInsets.only(left: 4, bottom: 8),
                        decoration: const BoxDecoration(
                          color: AppColors.celebrationAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            // Tagline
            SlideTransition(
              position: _textSlide,
              child: FadeTransition(
                opacity: _textFade,
                child: Text(
                  'ESPANHOL RIOPLATENSE COM MÚSICA',
                  style: AppTypography.label(
                    color: AppColors.textMuted,
                  ).copyWith(letterSpacing: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Subtle indicator
            FadeTransition(
              opacity: _textFade,
              child: Container(
                width: 40,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.actionGreen,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
