import 'dart:math';

var fakeData = [
  {'name': 'Aakash', 'phoneNumber': '987654321'},
  {'name': 'Mukul', 'phoneNumber': '963852741'},
  {'name': 'Shlok', 'phoneNumber': '741852963'}
];

fakeRepo() {
  return Future.delayed(const Duration(seconds: 2), () {
    final empty = Random().nextBool();

    return empty ? [] : fakeData;
  });
}
