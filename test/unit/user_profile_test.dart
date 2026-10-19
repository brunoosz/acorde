import 'package:flutter_test/flutter_test.dart';
import 'package:acorde/features/onboarding/domain/models/user_profile.dart';

void main() {
  group('UserProfile domain tests', () {
    test('toPromptSummary properly formats profile information for AI prompt', () {
      final profile = UserProfile(
        id: 1,
        objective: 'Viagem para Buenos Aires',
        spanishLevel: 2,
        dailyMinutes: 15,
        currentKnowledge: 'Portunhol básico',
        musicPreferences: 'Rock Nacional Argentino, Tango',
        createdAt: DateTime(2026, 1, 1),
      );

      final summary = profile.toPromptSummary();

      expect(summary, contains('Nível de espanhol: 2/10 (Iniciante absoluto'));
      expect(summary, contains('Tempo diário de estudo: 15 minutos'));
      expect(summary, contains('Objetivo principal: Viagem para Buenos Aires'));
      expect(summary, contains('O que já compreende: Portunhol básico'));
      expect(summary, contains('Gêneros musicais preferidos: Rock Nacional Argentino, Tango'));
    });

    test('spanish level descriptions adapt to different score brackets', () {
      final beginner = UserProfile(
        objective: 'Teste',
        spanishLevel: 1,
        dailyMinutes: 10,
        currentKnowledge: 'Zero',
        musicPreferences: 'Tango',
        createdAt: DateTime.now(),
      );
      expect(beginner.toPromptSummary(), contains('Iniciante absoluto'));

      final intermediate = UserProfile(
        objective: 'Teste',
        spanishLevel: 6,
        dailyMinutes: 20,
        currentKnowledge: 'Médio',
        musicPreferences: 'Rock',
        createdAt: DateTime.now(),
      );
      expect(intermediate.toPromptSummary(), contains('Intermediário'));

      final advanced = UserProfile(
        objective: 'Teste',
        spanishLevel: 9,
        dailyMinutes: 30,
        currentKnowledge: 'Avançado',
        musicPreferences: 'Trap',
        createdAt: DateTime.now(),
      );
      expect(advanced.toPromptSummary(), contains('Avançado'));
    });
  });
}
