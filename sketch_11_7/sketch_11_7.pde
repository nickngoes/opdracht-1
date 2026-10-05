int[] getallen = {5, 3, 5, 8, 5, 2, 9, 5, 1, 7};

void setup() {
  println(telHoeVaakGetalVoorkomt(5));
  println(telHoeVaakGetalVoorkomt(3));
  println(telHoeVaakGetalVoorkomt(9));
}

int telHoeVaakGetalVoorkomt(int getal) {
  int teller = 0;

  for (int i = 0; i < getallen.length; i++) {
    if (getallen[i] == getal) {
      teller++;
    }
  }

  return teller;
}
