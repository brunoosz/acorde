import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/navigation/presentation/screens/main_scaffold_screen.dart';

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
      home: const MainScaffoldScreen(),
    );
  }
}
