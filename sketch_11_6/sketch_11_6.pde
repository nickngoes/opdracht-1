int[] getallen = {5, 3, 5, 8, 5, 2, 9, 5, 1, 7};

void setup() {
  int zoekWaarde = 5;
  int teller = 0;

  for (int i = 0; i < getallen.length; i++) {
    if (getallen[i] == zoekWaarde) {
      teller++;
    }
  }

  println(teller);
}
