import 'package:flutter_test/flutter_test.dart';

int getNextLevel(int currentLevel, bool wasCorrect) {
  if (!wasCorrect) return 1;
  return currentLevel >= 4 ? 4 : currentLevel + 1;
}

int getIntervalDays(int level) {
  const intervals = {1: 1, 2: 3, 3: 7, 4: 14};
  return intervals[level] ?? 14;
}

void main() {
  group('Spaced Repetition Algorithm Tests', () {
    test('Correct answers advance levels: 1 -> 2 -> 3 -> 4 (capped at 4)', () {
      expect(getNextLevel(1, true), 2);
      expect(getIntervalDays(2), 3);

      expect(getNextLevel(2, true), 3);
      expect(getIntervalDays(3), 7);

      expect(getNextLevel(3, true), 4);
      expect(getIntervalDays(4), 14);

      expect(getNextLevel(4, true), 4);
      expect(getIntervalDays(4), 14);
    });

    test('Wrong answer immediately drops back to level 1 (1 day)', () {
      expect(getNextLevel(4, false), 1);
      expect(getIntervalDays(1), 1);

      expect(getNextLevel(3, false), 1);
      expect(getIntervalDays(1), 1);

      expect(getNextLevel(2, false), 1);
      expect(getIntervalDays(1), 1);
    });
  });
}
