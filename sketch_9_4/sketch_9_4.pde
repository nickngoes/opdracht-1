void setup() {
  size(200, 200);
  tekenVierkant(50, 50, 100, 100);
}

void tekenVierkant(int x, int y, int breedte, int hoogte) {
  line(x, y, x + breedte, y);
  line(x + breedte, y, x + breedte, y + hoogte);
  line(x + breedte, y + hoogte, x, y + hoogte);
  line(x, y + hoogte, x, y);
}
