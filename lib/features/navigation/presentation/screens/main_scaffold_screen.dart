import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/floating_nav_bar.dart';
import '../../../music/presentation/screens/songs_list_tab.dart';
import '../../../vocab/presentation/screens/vocab_review_screen.dart';
import '../../../settings/presentation/screens/settings_screen.dart';

class MainScaffoldScreen extends StatefulWidget {
  const MainScaffoldScreen({super.key});

  @override
  State<MainScaffoldScreen> createState() => _MainScaffoldScreenState();
}

class _MainScaffoldScreenState extends State<MainScaffoldScreen> {
  int _currentIndex = 0;

  final List<FloatingNavBarItem> _navItems = const [
    FloatingNavBarItem(icon: Icons.music_note_rounded, label: 'Músicas'),
    FloatingNavBarItem(icon: Icons.bookmark_rounded, label: 'Revisão'),
    FloatingNavBarItem(icon: Icons.settings_rounded, label: 'Ajustes'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: const [
              SongsListTab(),
              VocabReviewScreen(),
              SettingsScreen(),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingNavBar(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              items: _navItems,
            ),
          ),
        ],
      ),
    );
  }
}
