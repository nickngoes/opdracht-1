class Balloon
{
  float xPos;
  float yPos;
  float fallspeed;
  float size;
  float r=random(255);
  float g=random(255);
  float b=random(255);


  Balloon(float xPos, float yPos, float fallspeed, float size)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.fallspeed = fallspeed;
    this.size = size;
  }

  void Draw()
{
  yPos += fallspeed;
  fill(r,g,b);
  circle(xPos, yPos, size);
}

  void opnieuw()
  {
    yPos = -size;
    r = random(255);  
    g = random(255);
    b = random(255);
  }
}
  
