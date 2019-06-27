
void main() {
  DateTime today = new DateTime.now();
  DateTime fiftyDaysAgo = today.add(new Duration(days: 2));
  print(fiftyDaysAgo);
}