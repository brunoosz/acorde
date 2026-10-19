import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../controllers/settings_controller.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late final TextEditingController _apiKeyController;
  late final TextEditingController _modelController;
  bool _obscureApiKey = true;

  @override
  void initState() {
    super.initState();
    _apiKeyController = TextEditingController();
    _modelController = TextEditingController();
  }

  @override
  void dispose() {
    _apiKeyController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  void _syncControllers(SettingsState state) {
    if (_apiKeyController.text != state.apiKey) {
      _apiKeyController.text = state.apiKey;
    }
    if (_modelController.text != state.currentModel) {
      _modelController.text = state.currentModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    // Sincroniza campos quando o estado inicial é carregado
    if (!state.isLoading) {
      _syncControllers(state);
    }

    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: AppBar(
        title: Text('AJUSTES', style: AppTypography.titleMedium()),
        backgroundColor: AppColors.darkBackground,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator(color: AppColors.actionGreen))
          : SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CONFIGURAÇÃO DA IA',
                    style: AppTypography.titleLarge(),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Suas chaves são guardadas apenas no dispositivo usando armazenamento seguro criptografado.',
                    style: AppTypography.bodySmall(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 24),

                  // 1. Seleção de Provedor (Pílulas)
                  Text(
                    'PROVEDOR',
                    style: AppTypography.label(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildProviderPill(
                        label: 'Groq (Padrão)',
                        provider: AiProviderType.groq,
                        isSelected: state.selectedProvider == AiProviderType.groq,
                        onTap: () => controller.selectProvider(AiProviderType.groq),
                      ),
                      const SizedBox(width: 8),
                      _buildProviderPill(
                        label: 'Gemini (Google)',
                        provider: AiProviderType.gemini,
                        isSelected: state.selectedProvider == AiProviderType.gemini,
                        onTap: () => controller.selectProvider(AiProviderType.gemini),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Card de Configurações do Provedor Selecionado
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.borderSubtle, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Modelo (editável)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'MODELO',
                              style: AppTypography.label(color: AppColors.textMuted),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.restoreDefaultModel();
                              },
                              child: Text(
                                'Restaurar padrão',
                                style: AppTypography.label(color: AppColors.actionGreen),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _modelController,
                          style: AppTypography.bodyMedium(color: AppColors.textLight),
                          decoration: InputDecoration(
                            hintText: state.selectedProvider.defaultModel,
                            hintStyle: AppTypography.bodyMedium(color: AppColors.textMuted),
                            filled: true,
                            fillColor: AppColors.darkBackground,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: (value) => controller.saveModel(value),
                        ),
                        const SizedBox(height: 20),

                        // Chave de API
                        Text(
                          'CHAVE DE API (${state.selectedProvider.displayName.toUpperCase()})',
                          style: AppTypography.label(color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _apiKeyController,
                          obscureText: _obscureApiKey,
                          style: AppTypography.bodyMedium(color: AppColors.textLight),
                          decoration: InputDecoration(
                            hintText: 'Cole sua chave de API aqui...',
                            hintStyle: AppTypography.bodyMedium(color: AppColors.textMuted),
                            filled: true,
                            fillColor: AppColors.darkBackground,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(100),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureApiKey ? Icons.visibility_off : Icons.visibility,
                                color: AppColors.textMuted,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureApiKey = !_obscureApiKey;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Botão Salvar Chave (#c7ff69)
                        PillButton(
                          label: 'SALVAR CHAVE E MODELO',
                          isExpanded: true,
                          onPressed: () {
                            controller.saveModel(_modelController.text);
                            controller.saveApiKey(_apiKeyController.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Configurações salvas com segurança no aparelho!'),
                                backgroundColor: AppColors.darkSurface,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Aviso de Privacidade & Termos da IA
                  Container(
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
                            const Icon(Icons.shield_outlined, color: AppColors.supportPurple),
                            const SizedBox(width: 8),
                            Text(
                              'PRIVACIDADE E DADOS',
                              style: AppTypography.label(color: AppColors.supportPurple),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Ao gerar planos e aulas, as letras das músicas serão enviadas para o provedor selecionado (${state.selectedProvider.displayName}). Planos gratuitos de certos provedores podem processar o conteúdo para aprimorar seus serviços.',
                          style: AppTypography.bodySmall(color: AppColors.textLight),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Zona de Perigo: Apagar todos os dados
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.darkSurface,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppColors.celebrationAccent, width: 1.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ZONA DE PERIGO',
                          style: AppTypography.label(color: AppColors.celebrationAccent),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Apaga permanentemente do aparelho o banco de dados (músicas, progresso, vocabulário) e todas as chaves de API salvas.',
                          style: AppTypography.bodySmall(color: AppColors.textMuted),
                        ),
                        const SizedBox(height: 16),
                        PillButton(
                          label: 'APAGAR TODOS OS MEUS DADOS',
                          variant: PillButtonVariant.outline,
                          isExpanded: true,
                          onPressed: () => _confirmDeleteAllData(context, controller),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildProviderPill({
    required String label,
    required AiProviderType provider,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.actionGreen : AppColors.darkSurface,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: isSelected ? AppColors.actionGreen : AppColors.borderSubtle,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.label(
              color: isSelected ? AppColors.actionText : AppColors.textLight,
            ),
          ),
        ),
      ),
    );
  }

  void _confirmDeleteAllData(BuildContext context, SettingsController controller) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Text('Apagar todos os dados?', style: AppTypography.titleMedium()),
        content: Text(
          'Esta ação removerá todas as músicas, histórico de aulas, vocabulário e chaves de API salvas localmente. Não é possível desfazer.',
          style: AppTypography.bodyMedium(color: AppColors.textMuted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('CANCELAR', style: AppTypography.label(color: AppColors.textLight)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(ctx).pop();
              await controller.deleteAllUserData();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Todos os dados foram apagados com sucesso.'),
                    backgroundColor: AppColors.darkSurface,
                  ),
                );
              }
            },
            child: Text('APAGAR TUDO', style: AppTypography.label(color: AppColors.celebrationAccent)),
          ),
        ],
      ),
    );
  }
}
