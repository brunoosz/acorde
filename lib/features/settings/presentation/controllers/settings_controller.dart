import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/secure_storage_service.dart';
import '../../../../core/database/database_provider.dart';

class SettingsState {
  final AiProviderType selectedProvider;
  final String currentModel;
  final String apiKey;
  final bool hasApiKey;
  final bool privacyNoticeAccepted;
  final bool isLoading;
  final String? message;

  const SettingsState({
    required this.selectedProvider,
    required this.currentModel,
    required this.apiKey,
    required this.hasApiKey,
    required this.privacyNoticeAccepted,
    this.isLoading = false,
    this.message,
  });

  SettingsState copyWith({
    AiProviderType? selectedProvider,
    String? currentModel,
    String? apiKey,
    bool? hasApiKey,
    bool? privacyNoticeAccepted,
    bool? isLoading,
    String? message,
  }) {
    return SettingsState(
      selectedProvider: selectedProvider ?? this.selectedProvider,
      currentModel: currentModel ?? this.currentModel,
      apiKey: apiKey ?? this.apiKey,
      hasApiKey: hasApiKey ?? this.hasApiKey,
      privacyNoticeAccepted: privacyNoticeAccepted ?? this.privacyNoticeAccepted,
      isLoading: isLoading ?? this.isLoading,
      message: message,
    );
  }
}


final settingsControllerProvider =
    StateNotifierProvider<SettingsController, SettingsState>((ref) {
  final storage = ref.watch(secureStorageServiceProvider);
  return SettingsController(ref, storage);
});

class SettingsController extends StateNotifier<SettingsState> {
  final Ref _ref;
  final SecureStorageService _storage;

  SettingsController(this._ref, this._storage)
      : super(const SettingsState(
          selectedProvider: AiProviderType.groq,
          currentModel: 'llama-3.3-70b-versatile',
          apiKey: '',
          hasApiKey: false,
          privacyNoticeAccepted: false,
          isLoading: true,
        )) {
    loadSettings();
  }

  Future<void> loadSettings() async {
    state = state.copyWith(isLoading: true);
    final provider = await _storage.getSelectedProvider();
    final model = await _storage.getModel(provider);
    final apiKey = await _storage.getApiKey(provider) ?? '';
    final privacy = await _storage.isPrivacyNoticeAccepted();

    state = state.copyWith(
      selectedProvider: provider,
      currentModel: model,
      apiKey: apiKey,
      hasApiKey: apiKey.isNotEmpty,
      privacyNoticeAccepted: privacy,
      isLoading: false,
    );
  }

  Future<void> selectProvider(AiProviderType provider) async {
    await _storage.setSelectedProvider(provider);
    final model = await _storage.getModel(provider);
    final apiKey = await _storage.getApiKey(provider) ?? '';

    state = state.copyWith(
      selectedProvider: provider,
      currentModel: model,
      apiKey: apiKey,
      hasApiKey: apiKey.isNotEmpty,
      message: null,
    );
  }

  Future<void> saveApiKey(String key) async {
    await _storage.setApiKey(state.selectedProvider, key);
    state = state.copyWith(
      apiKey: key,
      hasApiKey: key.isNotEmpty,
      message: 'Chave salva com segurança no aparelho!',
    );
  }

  Future<void> saveModel(String model) async {
    await _storage.setModel(state.selectedProvider, model);
    state = state.copyWith(
      currentModel: model,
      message: 'Modelo atualizado!',
    );
  }

  Future<void> restoreDefaultModel() async {
    final defaultModel = state.selectedProvider.defaultModel;
    await saveModel(defaultModel);
  }

  Future<void> setPrivacyNoticeAccepted(bool accepted) async {
    await _storage.setPrivacyNoticeAccepted(accepted);
    state = state.copyWith(privacyNoticeAccepted: accepted);
  }

  /// Apaga todos os dados do SQLite e todas as credenciais do Secure Storage.
  Future<void> deleteAllUserData() async {
    state = state.copyWith(isLoading: true);
    final db = _ref.read(appDatabaseProvider);
    await db.deleteAllUserData();
    await _storage.clearAll();
    await loadSettings();
  }
}
