class ScoreManager {
  static final Map<String, int> _scores = {};

  static void reset() {
    _scores.clear();
  }

  static void saveScore(int semIndex, int chapterIndex, int score) {
    String key = "${semIndex}_$chapterIndex";
    if (!_scores.containsKey(key) || score > _scores[key]!) {
      _scores[key] = score;
    }
  }

  static int getScore(int semIndex, int chapterIndex) {
    String key = "${semIndex}_$chapterIndex";
    return _scores.containsKey(key) ? _scores[key]! : -1;
  }

  static int getOverallPercentage() {
    if (_scores.isEmpty) return 0;

    int totalScore = 0;
    int totalQuizzes = _scores.length;

    _scores.forEach((key, value) {
      totalScore += value;
    });

    double percentage = (totalScore / (totalQuizzes * 10)) * 100;
    return percentage.round();
  }
}