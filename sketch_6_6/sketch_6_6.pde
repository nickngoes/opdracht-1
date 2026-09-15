float gamestatus=(66);
boolean quest1= true;
boolean quest2= true;
boolean quest3=false;

if(gamestatus==100){
  println("gefeliciteerd");
}  
else{
  println(gamestatus + "% " +"klaar");
}

if(quest1==true&&quest2==true&&quest3==true){
  println("alles klaar");
}
else{
  println("niet alles klaar");
}
