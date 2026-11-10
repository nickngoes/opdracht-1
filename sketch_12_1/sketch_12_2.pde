class Rechthoek {
  float breedte;
  float hoogte;
  float x;
  float y;

  Rechthoek(float breedte, float hoogte, float x, float y) {
    this.breedte = breedte;
    this.hoogte = hoogte;
    this.x = x;
    this.y = y;
  }

  void teken() {
    rect(x, y, breedte, hoogte);
  }
}
