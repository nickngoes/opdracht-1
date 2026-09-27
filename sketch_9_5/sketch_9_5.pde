void setup() {
  String resultaat = samenvoegen("Dit ", "is ", "een ", "zin.");
  println(resultaat);
}

String samenvoegen(String s1, String s2, String s3, String s4) {
  String geheel = s1 + s2 + s3 + s4;
  return geheel;
}
