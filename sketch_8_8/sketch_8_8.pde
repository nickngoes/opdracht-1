int a = 0;
int b = 1;

println(a);
println(b);

for (int i = 0; i < 7; i++) {
  int c = a + b;
  println(c);
  a = b;
  b = c;
}
