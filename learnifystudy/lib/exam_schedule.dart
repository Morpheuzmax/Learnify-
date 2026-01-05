class ExamSchedule {
  static DateTime pspm1Date = DateTime(2025, 10, 22);
  static DateTime pspm2Date = DateTime(2026, 3, 15);

  // Function to update dates (Called by Lecturer)
  static void updateDates(DateTime? pspm1, DateTime? pspm2) {
    if (pspm1 != null) pspm1Date = pspm1;
    if (pspm2 != null) pspm2Date = pspm2;
  }
}