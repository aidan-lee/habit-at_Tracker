import processing.serial.*;
Serial myPort;
boolean on = false;


boolean started = false;
PFont amaticBoldFont;
PFont amaticRegularFont;
PImage plantImage1;
PImage plantImage2;
PImage plantImage3;
PImage squiggle;
PImage check;
PImage trash; 
PImage hoverTrash;

boolean fading = false;
boolean finishedFading = false;

void setup() {
  size(650, 940);

  startScreenSetup();
  activityScreenSetup();

  // Uncomment when arduino connected
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.buffer(1);
  
  
  amaticBoldFont = createFont("AmaticSC-Bold.ttf", 60);
  amaticRegularFont = createFont("AmaticSC-Regular.ttf", 60);
  plantImage1 = loadImage("plant1.png");
  plantImage2 = loadImage("plant2.png");
  plantImage3 = loadImage("plant3.png");
  squiggle = loadImage("squiggle.png");
  squiggle.resize(620, 40);
  check = loadImage("check.png");
  check.resize(60, 60);
  trash = loadImage("trash.png");
  trash.resize(40, 40);
  hoverTrash = loadImage("hoverTrash.png");
  hoverTrash.resize(40, 40);
}

void draw() {
  if (!started) {
      startScreenDraw();
  }
  else if (fading) {
    boolean finished = fade();
    if (finished) {
      fading = false;
      resetFade();   
      removeCircleChecks();
    }
  }
  else {
    activityScreenDraw();   
  }

}

void keyPressed() {
  if (keyCode == ENTER) {
    println("enter");
    started = true;
    setCardsOld();
  }
  else if (keyCode == DELETE) {
    backspaceCardName();
  }
  else {
    println(key);
    appendCardName(key);
  }
}

void mouseClicked() {
  if (isStartButtonHovered()) {
    started = true;
  }
  else if (isPlusButtonHovered()) {
    addCard();
  }
  else if (isNextButtonHovered()) {
    println("next");
    fading = true;
  }
  else if (checkDeleteClick()) {
    return;
  }
  else {
    checkCicleClick();
  }
}
