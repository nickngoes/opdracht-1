void setup() {
  size(220, 200);
  noLoop();
}

void draw() {
  background(255, 255, 255);

  int sizeC = 100;
  for (int i = 0; i < 5; i++) {
    ellipse(200 - sizeC/2, 100, sizeC, sizeC);
    sizeC = sizeC - 20;
  }
}
