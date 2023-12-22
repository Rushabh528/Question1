void main() {
  String str = 'The quick brown fox jumps over the lazy dog.';
  int l = str.length;
  print('Characters $l');
  var str1 = str.split(' ');
  int l2 = str1.length;
  print('Words $l2');
  var str2 = str.split('. ');
  int l3 = str2.length;
  print('Sentences $l3');
  int a = 0;
  for (int i = 0; i < str1.length; i++) {
    if (str1[i] == 'The' ||
        str1[i] == 'the' ||
        str1[i] == 'a' ||
        str1[i] == 'A' ||
        str1[i] == 'an' ||
        str1[i] == 'An') a++;
  }
  print('Articles $a');
}
