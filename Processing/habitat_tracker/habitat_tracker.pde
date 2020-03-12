import processing.serial.*;
Serial myPort;
boolean on = false;

// Defining global variables, fonts, and images
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
  // Setting the size of the viewport
  size(650, 940);

  // Calling the setup functions for both screens
  startScreenSetup();
  activityScreenSetup();

  // Initializing the connection to the Arduino
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.buffer(1);
  
  // Initializing the global variables 
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

// Continually draws to the screen
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

// Fires on key down. 
// Calls different functions, depending on what was pressed. 
void keyPressed() {
  if (keyCode == ENTER) {
    started = true;
    setCardsOld();
  }
  else if (keyCode == BACKSPACE) {
    backspaceCardName();
  }
  else {
    appendCardName(key);
  }
}

// Fires when mouse was clicked
// Detects what was clicked on and calls an appropriate function
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
