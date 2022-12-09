class Report {
  double monthlyExpense = 0;
  double monthlyIncome = 0;
  double yearlyExpense = 0;
  double yearlyIncome = 0;
  double lowestExpense = 0;
  double highestExpense = 0;
  double lowestIncome = 0;
  double highestIncome = 0;

  void resetMonthlyExpense() {
    monthlyExpense = 0;
  }
  void addMonthlyExpense(double a) {
    monthlyExpense += a;
  }
  void setMonthlyExpense(double a) {
    monthlyExpense = a;
  }
  double getMonthlyExpense() {
    return monthlyExpense;
  }

  void resetMonthlyIncome() {
    monthlyIncome = 0;
  }
  void addMonthlyIncome(double a) {
    monthlyIncome += a;
  }
  void setMontlyIncome(double a) {
    monthlyIncome = a;
  }
  double getMonthlyIncome() {
    return monthlyIncome;
  }

  void resetYearlyExpense() {
    yearlyExpense = 0;
  }
  void addYearlyExpense(double a) {
    yearlyExpense += a;
  }
  void setYearlyExpense(double a) {
    yearlyExpense = a;
  }
  double getYearlyExpense() {
    return yearlyExpense;
  }

  void resetYearlyIncome() {
    yearlyIncome = 0;
  }
  void addYearlyIncome(double a) {
    yearlyIncome += a;
  }
  double getYearlyIncome() {
    return yearlyIncome;
  }

  void resetLowestExpense() {
    lowestExpense = 0;
  }
  void addLowestExpense(double a) {
    lowestExpense += a;
  }
  void setLowestExpense(double a) {
    lowestExpense = a;
  }
  double getLowestExpense() {
    return lowestExpense;
  }

  void resetHighestExpense() {
    highestExpense = 0;
  }
  void addHighestExpense(double a) {
    highestExpense += a;
  }
  void setHighestExpense(double a) {
    highestExpense = a;
  }
  double getHighestExpense() {
    return highestExpense;
  }

  void resetLowestIncome() {
    lowestIncome = 0;
  }
  void addLowestIncome(double a) {
    lowestIncome += a;
  }
  void setLowestIncome(double a) {
    lowestIncome = a;
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
  void setHighestIncome(double a) {
    highestIncome = a;
  }
  double getHighestIncome() {
    return highestIncome;
  }
}