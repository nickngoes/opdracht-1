class Spaarpot {
  float saldo;

  Spaarpot(float startSaldo) {
    saldo = max(0, startSaldo);   
  }

  void stort(float bedrag) {
    if (bedrag > 0) {
      saldo += bedrag;
    }
  }

  void neemOp(float bedrag) {
    if (bedrag > 0 && bedrag <= saldo) {
      saldo -= bedrag;
    }
  }
}
