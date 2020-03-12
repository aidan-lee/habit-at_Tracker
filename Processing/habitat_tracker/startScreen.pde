boolean startButtonHover = false;
int startButtonHeight = 70;
int startButtonWidth = 200;
int startButtonX = 228;
int startButtonY = 646;

void startScreenSetup() {
}

// Draws the start screen
void startScreenDraw() {
  background(255, 242, 222);
 
  fill(56, 138, 102);
  
  textFont(amaticBoldFont, 90);
 
  text("Task Tracker", 190, 200);
  
  image(plantImage1, 240, 300);
  image(plantImage2, 420, 335);
  image(plantImage3, 130, 315);
  
  strokeWeight(2);
  
  if (isStartButtonHovered()) {
     fill(66, 166, 122);
  }
  else {
      fill(56, 138, 102); 
  }
  rect(228, 646, 200, 70, 20);  
    
  fill(255, 242, 222);
  textFont(amaticBoldFont, 50);
  text("Get Started", 250, 700);

}

// Checks if the start button is hovered 
boolean isStartButtonHovered() {
  if (mouseX >= startButtonX && mouseX <= startButtonX + startButtonWidth && 
    mouseY >= startButtonY && mouseY <= startButtonY + startButtonHeight) {
    return true;
  } 
  else {
    return false;
  }
}
