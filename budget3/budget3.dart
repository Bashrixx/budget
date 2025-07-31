void main() {
  int income = 1000000;

  Map<String, int> budgetItems = {
    'Rent': 80000,
    'Food': 50000,
    'Transport': 30000,
    'Savings': 100000,
    'Emergencies': 30000,
    'Vacation': 50000,
  };

  displayBudgetSummary(income, budgetItems);
  viewBalance(income, budgetItems);
}

void displayBudgetSummary(int income, Map<String, int> budgetItems) {
  int totalExpenses = budgetItems.values.reduce((a, b) => a + b);
  int remainder = income - totalExpenses;

  print('\n========== MONTHLY BUDGET SUMMARY ==========\n');
  printFunction('INCOME', income, 100);

  print('\n------------ EXPENSE BREAKDOWN ------------\n');
  for (var entry in budgetItems.entries) {
    int percent = (entry.value * 100 ~/ income);
    printFunction(entry.key, entry.value, percent);
  }

  int totalPercent = (totalExpenses * 100 ~/ income);
  int remainderPercent = (remainder * 100 ~/ income);

  print('\n--------------- TOTALS ----------------\n');
  printFunction('Total Expenses', totalExpenses, totalPercent);
  printFunction('Remaining Balance', remainder, remainderPercent);

  print('\n===========================================\n');
}

void printFunction(String label, int amount, int percent) {
  String paddedLabel = label.padRight(20);
  String paddedAmount = 'KES ${amount.toString()}';
  String paddedPercent = '${percent.toString()}%';
  print('$paddedLabel\n Amount: $paddedAmount \n Percentage: $paddedPercent\n');
}

void viewBalance(int income, Map<String, int> budgetItems) {
  int totalExpenses = budgetItems.values.reduce((a, b) => a + b);
  int finalBalance = income - totalExpenses;

  print('\n--- CURRENT BALANCE ---');
  print('KES $finalBalance\n');
}
