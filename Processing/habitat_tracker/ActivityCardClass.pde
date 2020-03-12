// The ActivityCard class
// Contains all data and functionality pertaining to the tasks on the activity screen

class ActivityCard {
  int cardX;
  int cardY;
  int cardHeight; 
  int cardWidth;
  
  int checkCircleX;
  int checkCircleY;
  int checkCircleDiameter;
  
  int titleX;
  int titleY;
  String titleText;
  
  int boxX;
  int boxY;
  int boxHeight;
  int boxWidth;
  
  int trashX;
  int trashY;
  int trashWidth;
  
  boolean isChecked = false;
  boolean isNew;
  
  ActivityCard(int xOffset, int yOffset, int count) {
    this.cardX = xOffset;
    this.cardY = yOffset - 15;
    this.cardHeight = 40;
    this.cardWidth = 600;
    
    this.checkCircleX = xOffset;
    this.checkCircleY = yOffset;
    this.checkCircleDiameter = 40;
    
    this.titleX = xOffset + 50;
    this.titleY = yOffset + 15;
    this.titleText = "Task " + count;
    
    this.boxX = xOffset + 40;
    this.boxY = yOffset - 25;
    this.boxHeight = 50;
    this.boxWidth = 300;
  
    this.trashX = cardX + 515;
    this.trashY = cardY - 10;
    this.trashWidth = 40;
    
    this.isNew = true;
  }
  
  // Draw the card on the screen
  void renderCard() {
    stroke(0, 0, 0);
    strokeWeight(2);
      
    if(isCheckCircleHovered()) {
     fill(230, 218, 200);
    }
    else {
        fill(255, 242, 222);
    }
    
    circle(this.checkCircleX, this.checkCircleY, this.checkCircleDiameter);
    if (this.isNew) {
      rect(this.boxX, this.boxY, this.boxWidth, this.boxHeight);
    }
    fill(0, 0, 0); 
    textFont(amaticBoldFont, 40);
    text(this.titleText, this.titleX, this.titleY);
    
    if (isChecked) {
      image(check, this.checkCircleX - 29, this.checkCircleY - 30);
    }
    
    if (isCardHovered()) {
      if (isTrashHovered()) {
        image(hoverTrash, trashX, trashY);
      }
      else {
        image(trash, trashX, trashY);
      }
    }
  }
  
  // Checks if the mouse pointer is hovering over a circle 
  boolean isCheckCircleHovered() {
    float disX = checkCircleX - mouseX;
    float disY = checkCircleY - mouseY;
    if(sqrt(sq(disX) + sq(disY)) < checkCircleDiameter/2 ) {
      return true;
    } else {
      return false;
    }
  }
  
  // Checks if the mouse pointer is hovering over the card itself 
  boolean isCardHovered() {
    if (mouseX >= cardX && mouseX <= cardX + cardWidth && 
      mouseY >= cardY && mouseY <= cardY + cardHeight) {
      return true;
    } 
    else {
      return false;
    }
  }
  
  // Checks if the mouse poitner is hovering over the trash icon
  boolean isTrashHovered() {     
    if (mouseX >= this.trashX && mouseX <= this.trashX + this.trashWidth && 
      mouseY >= this.trashY && mouseY <= this.trashY + this.trashWidth) {
      return true;
    } 
    else {
      return false;
    }
  }
 
  
}
