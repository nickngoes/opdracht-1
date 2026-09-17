//1.1

String automerk="BMW";
int leeftijd=6;
float deelsom= 9f/2;

//1.2

println(automerk+","+"dat is vast een dure auto");

//1.3

if(leeftijd<1){
  println("baby");
}
if(leeftijd>=1&&leeftijd<=2);{
  println("dreumes");
}
if(leeftijd>2&&leeftijd<=4){
  println("peuter");
}
if(leeftijd>4&&leeftijd<=6){
  println("kleuter");
}

//1.4

true;
false;
false;
false;

true;
true;
true;
false;

//1.5

true;
true;
false;
true;
true;

//1.6
false;
true;
true;
true;
true;

//1.7
b

//1.8

int temperatuurCelsius = 28;
if (temperatuurCelsius>25&&temperatuurCelsius<30){
  println("warm");
}

// 1.8.1
int temperatuurCelsius = 28;
if (temperatuurCelsius>25&&temperatuurCelsius<30){
  println("warm");
}
if (temperatuurCelsius>=30){
  println("heet");
}
else{
  println("het is nu "+temperatuurCelsius" "+"graden");  
}

//1.9
int speler1Score = 30;
int speler2Score = 30;

if(speler1Score>speler2Score){
  println("speler 1 heeft gewonnen");
}
else if(speler2Score>speler1Score){
  println("speler 2 heeft gewonnen");
}
else if(speler1Score==speler2Score){
  println("het is gelijkspel");
}

//1.10

int x=11;
int y=11;

if (x > 10) {
  x = x - 5;
  if (x > 10 || y <= 10) {
    x++;
    y++;
  } else {
    println("hier wil ik zijn");
  }
}

//1.11
int steen1 = 5;
int steen2 = 6;
int steen3 = 7;
String resultaat = "";

if(steen1==1||steen2==1||steen3==1){
  resultaat = "mis!";
}
else {
  float schade=(steen1+steen2+steen3);
  resultaat=schade+ " HIT!";
}

print(resultaat);

//1.11.1
int steen1 = 6;
int steen2 = 6;
int steen3 = 6;
String resultaat = "";

if(steen1==1||steen2==1||steen3==1){
  resultaat = "Critical MISS!";
}
else {
  float schade=(steen1+steen2+steen3);
  resultaat=schade+ " HIT!";
}
if(steen1==6 && steen2==6 && steen3==6){
  resultaat= "MAX DAMAGE!";
}
print(resultaat);

//1.12
float totaalAantalLessen= 20;
float gevolgdeLessen= 17;
float cijfer= 7;
float percentageLessenGevolgd=(gevolgdeLessen/totaalAantalLessen*100);

if(percentageLessenGevolgd>=80&&cijfer>=5.5){
  println("geslaagd");
}
else{
  println("gezakt");
}

//1.12.1
float totaalAantalLessen= 20;
float gevolgdeLessen= 16;
float cijfer= 5.5;
float percentageLessenGevolgd=(gevolgdeLessen/totaalAantalLessen*100);

if(percentageLessenGevolgd>=80&&cijfer>=5.5){
  println("geslaagd");
}
else{
  println("gezakt");
}
