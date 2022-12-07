class Report {
  double dailySum = 0;
  double monthlyExpense = 0;
  double monthlyIncome = 0;
  double yearlyExpense = 0;
  double yearlyIncome = 0;
  double lowestExpense = 0;
  double highestExpense = 0;
  double lowestIncome = 0;
  double highestIncome = 0;

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

  resetMonthlyIncome() {
    monthlyIncome = 0;
  }
  addMonthlyIncome(double a) {
    monthlyIncome += a;
  }
  double getMonthlyIncome() {
    return monthlyIncome;
  }

  resetYearlyExpense() {
    yearlyExpense = 0;
  }
  addYearlyExpense(double a) {
    yearlyExpense += a;
  }
  double getYearlyExpense() {
    return yearlyExpense;
  }

  resetYearlyIncome() {
    yearlyIncome = 0;
  }
  addYearlyIncome(double a) {
    yearlyIncome += a;
  }
  double getYearlyIncome() {
    return yearlyIncome;
  }

  resetLowestExpense() {
    lowestExpense = 0;
  }
  addLowestExpense(double a) {
    lowestExpense += a;
  }
  double getLowestExpense() {
    return lowestExpense;
  }

  resetHighestExpense() {
    highestExpense = 0;
  }
  addHighestExpense(double a) {
    highestExpense += a;
  }
  double getHighestExpense() {
    return highestExpense;
  }

  resetLowestIncome() {
    lowestIncome = 0;
  }
  addLowestIncome(double a) {
    lowestIncome += a;
  }
  double getLowestIncome() {
    return lowestIncome;
  }

  resetHighestIncome() {
    highestIncome = 0;
  }
  addHighestIncome(double a) {
    highestIncome += a;
  }
  double getHighestIncome() {
    return highestIncome;
  }
}