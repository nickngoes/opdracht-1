void setup() {
  float resultaat = gemiddelde(6, 8);
  println(resultaat);
}

float gemiddelde(int cijfer1, int cijfer2) {
  float gemiddeld = (cijfer1 + cijfer2) / 2.0;
  return gemiddeld;
}
