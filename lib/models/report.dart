class Report {
  double dailySum = 0;
  double monthlyExpense = 0;
  double monthlyIncome = 0;
  double yearlyIncome = 0;
  double yearlyExpense = 0;
  double lowestIncome = 0;
  double lowestExpense = 0;
  double highgestExpense = 0;

  resetDailySum() {
    dailySum = 0;
  }
  addDailySum(double a) {
    dailySum += a;
  }
  double getDailySum() {
    return dailySum;
  }

  resetMonthlyExpense() {
    monthlyExpense = 0;
  }
  addMonthlyExpense(double a) {
    monthlyExpense += a;
  }
  double getMonthlyExpense() {
    return monthlyExpense;
  }
}