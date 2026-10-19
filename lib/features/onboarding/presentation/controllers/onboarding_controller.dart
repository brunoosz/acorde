import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/profile_repository.dart';
import '../../domain/models/user_profile.dart';

class OnboardingState {
  final int currentStep;
  final String objective;
  final int spanishLevel; // 0 a 10
  final int dailyMinutes;
  final String currentKnowledge;
  final List<String> musicPreferences;
  final bool isSaving;
  final bool isCompleted;

  const OnboardingState({
    this.currentStep = 0,
    this.objective = 'Aprender por Música e Cultura',
    this.spanishLevel = 3,
    this.dailyMinutes = 15,
    this.currentKnowledge = 'Entendo um pouco de portunhol e leio algumas palavras',
    this.musicPreferences = const ['Rock Nacional Argentino', 'Tango'],
    this.isSaving = false,
    this.isCompleted = false,
  });

  OnboardingState copyWith({
    int? currentStep,
    String? objective,
    int? spanishLevel,
    int? dailyMinutes,
    String? currentKnowledge,
    List<String>? musicPreferences,
    bool? isSaving,
    bool? isCompleted,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      objective: objective ?? this.objective,
      spanishLevel: spanishLevel ?? this.spanishLevel,
      dailyMinutes: dailyMinutes ?? this.dailyMinutes,
      currentKnowledge: currentKnowledge ?? this.currentKnowledge,
      musicPreferences: musicPreferences ?? this.musicPreferences,
      isSaving: isSaving ?? this.isSaving,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return OnboardingController(repo);
});

class OnboardingController extends StateNotifier<OnboardingState> {
  final ProfileRepository _repo;

  OnboardingController(this._repo) : super(const OnboardingState());

  void setObjective(String objective) {
    state = state.copyWith(objective: objective);
  }

  void setSpanishLevel(int level) {
    state = state.copyWith(spanishLevel: level.clamp(0, 10));
  }

  void setDailyMinutes(int minutes) {
    state = state.copyWith(dailyMinutes: minutes);
  }

  void setCurrentKnowledge(String knowledge) {
    state = state.copyWith(currentKnowledge: knowledge);
  }

  void toggleMusicPreference(String genre) {
    final current = List<String>.from(state.musicPreferences);
    if (current.contains(genre)) {
      if (current.length > 1) {
        current.remove(genre);
      }
    } else {
      current.add(genre);
    }
    state = state.copyWith(musicPreferences: current);
  }

  void nextStep() {
    if (state.currentStep < 4) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<void> submitProfile() async {
    state = state.copyWith(isSaving: true);
    await _repo.saveProfile(
      objective: state.objective,
      spanishLevel: state.spanishLevel,
      dailyMinutes: state.dailyMinutes,
      currentKnowledge: state.currentKnowledge,
      musicPreferences: state.musicPreferences.join(', '),
    );
    state = state.copyWith(isSaving: false, isCompleted: true);
  }
}
