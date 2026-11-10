class Leerling {
  String naam;
  int leeftijd;

  Leerling(String naam, int leeftijd) {
    this.naam = naam;
    this.leeftijd = leeftijd;
  }

  void printInfo() {
    println("Naam: " + naam + ", Leeftijd: " + leeftijd);
  }
}
