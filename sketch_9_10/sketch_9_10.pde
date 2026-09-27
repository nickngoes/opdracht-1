void setup() {
  size(300, 200);
  noLoop();
}

void draw() {
  background(255, 255, 255);
  tekenBos();
}

void tekenBos() {
  tekenBoom(50, 200);
  tekenBoom(150, 200);
  tekenBoom(250, 200);
}

void tekenBoom(int x, int y) {
  rect(x - 10, y - 60, 20, 60);
  ellipse(x, y - 90, 80, 80);
}
