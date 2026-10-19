import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/widgets/quintet_icon.dart';
import '../../data/repositories/profile_repository.dart';
import '../../domain/models/user_profile.dart';

final userProfileFutureProvider = FutureProvider<UserProfile?>((ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getProfile();
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileFutureProvider);

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text('MEU PERFIL', style: AppTypography.titleMedium()),
        backgroundColor: AppColors.darkBackground,
      ),
      body: profileAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.actionGreen)),
        error: (err, _) => Center(child: Text('Erro ao carregar perfil: $err')),
        data: (profile) {
          if (profile == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Nenhum perfil encontrado.', style: AppTypography.bodyMedium()),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.darkSurface,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: AppColors.actionGreen, width: 2),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${profile.spanishLevel}',
                        style: AppTypography.titleHuge(color: AppColors.actionGreen).copyWith(fontSize: 36),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('NÍVEL DE ESPANHOL', style: AppTypography.label(color: AppColors.textMuted)),
                          const SizedBox(height: 4),
                          Text('Nota ${profile.spanishLevel} de 10', style: AppTypography.titleMedium()),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                _buildInfoCard(
                  title: 'TEMPO DIÁRIO',
                  value: '${profile.dailyMinutes} minutos por dia',
                  icon: QuintetType.vocab,
                ),
                const SizedBox(height: 16),

                _buildInfoCard(
                  title: 'OBJETIVO',
                  value: profile.objective,
                  icon: QuintetType.slang,
                ),
                const SizedBox(height: 16),

                _buildInfoCard(
                  title: 'CONHECIMENTO PRÉVIO',
                  value: profile.currentKnowledge,
                  icon: QuintetType.falseFriends,
                ),
                const SizedBox(height: 16),

                _buildInfoCard(
                  title: 'GOSTOS MUSICAIS',
                  value: profile.musicPreferences,
                  icon: QuintetType.music,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required String value,
    required QuintetType icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              QuintetIcon(type: icon, size: 32),
              const SizedBox(width: 10),
              Text(title, style: AppTypography.label(color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: AppTypography.bodyMedium(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
