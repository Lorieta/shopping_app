void main() {
  final list = [1, 2, 3];
  final item = list.where((e) => e == 2).firstOrNull;
  print(item);
}
