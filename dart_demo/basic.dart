const rawString = r'hello world, \n, I have a dream!';
var list = const [1, 2, 3];
var list2 = [4, ...list];
List<num>? list3 = null;
var list4 = [4, 5, ...?list3];

Stream<int> range(int max) async* {
  int i = 0;
  while (i < max) {
    yield i;
    i++;
  }
}

void main() async {
  // list.add(3); Cannot add to an unmodifiable list
  await for (int i in range(10)) {
    print(i);
  }
}
