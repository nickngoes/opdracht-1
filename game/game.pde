class Balloon
{
  float xPos;
  float yPos;
  float fallspeed;
  float size;

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
    circle(xPos, yPos, size);
  }

  void opnieuw()
  {
    yPos = -size;
  }
}
  
