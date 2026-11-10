Balloon ballonetje1 = new Balloon(400, 110, 3, 50);
Balloon ballonetje2 = new Balloon(130, 110, 5, 50);
Balloon ballonetje3 = new Balloon(50,  110, 4, 50);
Balloon ballonetje4 = new Balloon(200, 110, 6, 50);
Balloon ballonetje5 = new Balloon(300, 110, 10, 50);

Balloon[] ballonnetje = new Balloon[5];

float paddleX;                
float paddleBreedte = 130;
int score = 0;

void setup()
{
  size(500, 500);
  ballonnetje[0] = ballonetje1;
  ballonnetje[1] = ballonetje2;
  ballonnetje[2] = ballonetje3;
  ballonnetje[3] = ballonetje4;
  ballonnetje[4] = ballonetje5;
}

void draw()
{
  background(0, 0, 0);

 
  paddleX = mouseX - paddleBreedte / 2;
  fill(255, 255, 255);
  rect(paddleX, 460, paddleBreedte, 20);


  for (int i = 0; i < ballonnetje.length; i++)
  {
    ballonnetje[i].Draw();

    if (raaktPaddle(ballonnetje[i]))
    {
      ballonnetje[i].opnieuw();
      score = score + 1;
    }

    if (ballonnetje[i].yPos > height + ballonnetje[i].size)
    {
      ballonnetje[i].opnieuw();
      score = score - 1;
    }
  }

 
  fill(255, 255, 255);
  textSize(24);
  text("Score: " + score, 20, 40);

 
  if(score<0)
  {
    textSize(48);
    background(255,0,0);
    text("GAME LOSE",150, 150);
    noLoop();
  }
  
  if (score >= 10)
  {
    textSize(48);  
     background(0,255,0);
     text("GAME WIN", 150, 150);
     noLoop();
  }
}

boolean raaktPaddle(Balloon a)
{  
  boolean oppaddle = a.yPos > 440 && a.yPos < 490;
  boolean tussenpaddle = a.xPos > paddleX && a.xPos < paddleX + paddleBreedte;
  return oppaddle && tussenpaddle;
}
