import 'package:gsheets/gsheets.dart';

class GoogleSheetApi{
  static final _credentials = r'''{
  "type": "service_account",
  "project_id": "flutter-gsheets-398819",
  "private_key_id": "36b79dd332efff65a909b7c843dd71281bf6ae42",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCyvAORncuQNYag\n1od1iBQZQdnox39Rr+xAqcWtQ6WcT7IkMq/dLyt60D916aGCGSgf7M2punX+nOFd\nbEbeJds3P7YiK7/wPrQ8lV07xGQVcULd7fsiEuKILyLUcHscye0P5Y/yHuTgr+a7\nszJgi7s9lhb7bYDra5HHaoWFCJockujmJb2doZf7C+Q0WmfJJpGsxoLe1kpuB6q/\niz3yenD5PqeJfQEbNV7BBNak0xX6eFemkQ/qeJPWgbI6sv+vDXAKO8XR1JIw+owK\n43irUNDRHqiMC2nPSonRn8K/v0u6e/uYA5NVgFB6Mv3yj1P/6Njo/7NG5DyduvGD\neCYXqhl7AgMBAAECggEAAqyObxzJwWATog9jmm4NQu15yaJGdN3pbnQ7yWJUNXj5\nxNHfULNWdrFr6aMzr+MZdxTPZOUtw7/sHT4z9zngxDxXSL6X0gvWHXvsl6rSBoIZ\nyoE3eySGMBxobH48UUtyGQVJuIkeyn/HN3KwY8JjbEH1GRDj12HWHgIpejqNN7Uy\njpaLwMFyxevHBs64WOkj+i253fF5sslQySVbwuwYsNocL11ewvmcGLdvD/0rFuhu\noD9Q0uafjTxW9ReNDLLW2uW+3XBtPTS//clOqTXLFZY1Ds79VAGHKyFxUWjDdYHp\n5sxMYcAU4uZwFaUcBMwvIr/O+CRc5Nku3d8JzUbNDQKBgQDifcikU1MKD90RYXFH\nQ3eAxtyMM0cix2Y96GyYOeyAHHJIvCERKhHL91uyLYIrllYKJ5Rs36aSkMxK21Y6\nXecYxAtXuZfu5nTRc3cWAKOcfNlAq8ij2shi0dblTxjjHg8k8xWAF55Z8rZFPqkw\nTq7DTD8BLNGxEN0Og4JlWHXM7wKBgQDKBWIZ3T+qJpFmMA5KyOsEBXPwOq2qY6gx\n1/7y7j7uZUU+9KOS50BGVVYsUaifLUyXNRz+Xh9M5SIZEB52qdG7u4X/3a0fJO2X\ndxnDhutEaujxE0qzazZCgLwVvm8XeLBas3+3lgKxvIjdwY49TbK52ysIiTXp4S3a\n5E8hqPwUNQKBgQDb3OTf9+8dTmb4j1IKrsicHu9Lvh9o+I4cvLpmT5xwhKzARLgI\n1IDwMhA2eAzryQV+2AsyYS1vC9b1N9SN1kgW94BXSVfe1qJCDMdmeXpZ16yCJgAg\nZ6qsmyzz7wOmvbBP2xVdAhB7GqyrrXdJ6Ken+CUVO+/W5hrhEvKK9QNtywKBgC7s\n9y+Y0+v7D3UUHo3Cg8yoU5jumF5mza/eQ0s8igOoJGCORNyfuK9drSmYQjnPNOY+\noSB4zn53DueRdfIMWjpoQaUAYfFFC6dOM/7V/RokVz2ARK7ObYkfDBFk7bse/p/i\n5/zF7JRKfeQ8zIRy4twHC8Ts0kgkVRluRO9FqGAtAoGBAMWpY4QXlrcPMsxESQ4z\n7GT8kkJkcBw8MPJai71SNfocMlOvK4dI77YQKYj6me2ImxIuzYGi2lCtv7vv2b81\nNml7MzhVPH9wIur9ONGdyq68UDGRzdBZRgCiDdYd52KE1GWLKsDt+qr7y3OmxadI\ncS675grQkHRotmAJNXvVZ9GP\n-----END PRIVATE KEY-----\n",
  "client_email": "expensetracker@flutter-gsheets-398819.iam.gserviceaccount.com",
  "client_id": "104563441157715414399",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/expensetracker%40flutter-gsheets-398819.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

//SpreadSheet Id
  static final _spreadsheetId = '1rGfMdof9Mj2zuv69us8XsjYnRJMFWnQ8lS-6r8CDsJg';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;
//Variable for tracking

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('worksheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
        .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
      await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
      await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
      await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}