List<int> getDivisibleNumbers(int number) {
  if (number <= 0) {
    return [];
  }

  List<int> numbers = [];

  for (var i = 1; i < number; i++) {
    if (i % 3 == 0 || i % 5 == 0) {
      numbers.add(i);
    }
  }

  return numbers;
}
