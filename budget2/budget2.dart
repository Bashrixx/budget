import 'dart:io';
void main() {
  print("Enter your starting income: ");
  String? input = stdin.readLineSync();
  int income = int.tryParse(input ?? '') ?? 0;

  Map<String, int> budgetItems = {
        'Rent': 80000,
        'Food': 50000,
        'Transport': 30000,
        'Savings': 100000,
        'Emergencies': 30000,
        'Vacation': 50000,
  };

  

  List<Map<String, dynamic>> transactions = [];

  bool running = true;

  while (running) {
    print('\n====== Budget Menu ======');
    print('1. View Monthly Summary');
    print('2. Add Transaction (Income or Expense)');
    print('3. View Current Balance');
    print('4. List All Transactions');
    print('5. Exit');
    stdout.write('Choose an option: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        displayBudgetSummary(income, budgetItems);
        running = false;
        break;
      case '2':
        addTransaction(transactions);
        running = false;
        break;
      case '3':
        viewBalance(income, budgetItems, transactions);
        running = false;
        break;
      case '4':
        listTransactions(transactions);
        running = false;
        break;
      case '5':
        print('Exiting... Goodbye!');
        running = false;
        break;
      default:
        print('Invalid option. Try again.');
    }
  }
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

  print('\n===========================================');
}

void printFunction(String label, int amount, int percent) {
  String paddedLabel = label.padRight(20);
  String paddedAmount = 'KES ${amount.toString()}';
  String paddedPercent = '${percent.toString()}%';
  print('$paddedLabel  \n Amount: $paddedAmount \n Percentage: $paddedPercent\n');
}

void addTransaction(List<Map<String, dynamic>> transactions) {
  stdout.write('Enter transaction type (income/expense): ');
  String? type = stdin.readLineSync()?.toLowerCase();

  if (type != 'income' && type != 'expense') {
    print('Invalid type. Only "income" or "expense" allowed.');
    return;
  }

  stdout.write('Enter description: ');
  String? desc = stdin.readLineSync();

  stdout.write('Enter amount: ');
  String? amountInput = stdin.readLineSync();
  int? amount = int.tryParse(amountInput ?? '');

  if (amount == null || desc == null || desc.isEmpty) {
    print('Invalid input. Transaction not saved.');
    return;
  }

  if (type == 'expense') {
    amount = -amount.abs(); // make sure it's negative
  }

  transactions.add({
    'type': type,
    'description': desc,
    'amount': amount,
  });

  print('Transaction added!');
}

void viewBalance(int income, Map<String, int> budgetItems, List<Map<String, dynamic>> transactions) {
  int totalExpenses = budgetItems.values.reduce((a, b) => a + b);
  int manualBalance = transactions.fold(0, (sum, tx) => sum + (tx['amount'] as int));
  int finalBalance = income - totalExpenses + manualBalance;

  print('\n--- Current Balance ---');
  print('KES $finalBalance');
}

void listTransactions(List<Map<String, dynamic>> transactions) {
  if (transactions.isEmpty) {
    print('No manual transactions yet.');
    return;
  }

  print('\n--- All Manual Transactions ---');
  print('Type     | Description         | Amount');
  print('----------------------------------------');

  for (var tx in transactions) {
    String paddedType = (tx['type'] as String).padRight(9);
    String paddedDesc = (tx['description'] as String).padRight(20);
    String paddedAmount = 'KES ${(tx['amount'] as int).toString()}'.padLeft(10);
    print('$paddedType| $paddedDesc| $paddedAmount');
  }
}
