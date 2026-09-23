size(220,220);
background(255,255,255);

int xWaarde = 20;
int yWaarde = 20;

for (int i = 0; i < 10; i++) {
  for (int j = 0; j < 10; j++) {
    rect(xWaarde, yWaarde, 20, 20);
    yWaarde = yWaarde + 20;
  }
  yWaarde = 20;
  xWaarde = xWaarde + 20;
}
