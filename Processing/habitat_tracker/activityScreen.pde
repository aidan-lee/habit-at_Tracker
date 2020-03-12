ArrayList<ActivityCard> cards;
int cardCount = 0;

int nextButtonHeight = 70;
int nextButtonWidth = 200;
int nextButtonX = 228;
int nextButtonY = 795;

int plusButtonHeight = 50;
int plusButtonWidth = 50;
int plusButtonX = 560;
int plusButtonY = 20;

int cardXOffset = 50;
int cardYOffset = 170;

void activityScreenSetup() {
  cards = new ArrayList<ActivityCard>();
}

// Draw the activity screen
void activityScreenDraw() {  
 background(255, 242, 222);
 
 textFont(amaticBoldFont, 70);
 fill(56, 138, 102); 
 text("My Tasks", 20, 75);
 image(squiggle, 10, 75);
 
 drawPlus();
 
 for (int i = 0; i < cards.size(); i++) { 
  boolean isHovered = cards.get(i).isCardHovered();
  cards.get(i).renderCard();
 }
 
  drawNextButton();

}

// Called when the user clicks the '+' button
// Adds another activity to the UI
void addCard() {
  ActivityCard newCard = new ActivityCard(cardXOffset, cardYOffset, cardCount);
  cards.add(newCard);
  cardCount++;
  
  cardYOffset += 90;
}

// Draws the '+' button
void drawPlus() {
  if(isPlusButtonHovered()) {
     fill(66, 166, 122);
  }
  else {
      fill(56, 138, 102); 
  }
 rect(plusButtonX, plusButtonY, plusButtonWidth, plusButtonHeight, 20);  
 fill(255, 242, 222);
 textFont(amaticBoldFont, 80);
 text("+", 569, 70);
}
  
// Draws the 'next day' button  
void drawNextButton() {
  if(isNextButtonHovered()) {
     fill(66, 166, 122);
  }
  else {
      fill(56, 138, 102); 
  }
  strokeWeight(2); 
  rect(nextButtonX, nextButtonY, nextButtonWidth, nextButtonHeight, 20);  
  fill(255, 242, 222);
  textFont(amaticBoldFont, 50);
  text("Next Day", 270, 850);
}

// Checks if the 'next day' button is hovered
boolean isNextButtonHovered() {
  if (mouseX >= nextButtonX && mouseX <= nextButtonX + nextButtonWidth && 
    mouseY >= nextButtonY && mouseY <= nextButtonY + nextButtonHeight) {
    return true;
  } 
  else {
    return false;
  }
}

// Checks if the '+' button is hovered 
boolean isPlusButtonHovered() {
  if (mouseX >= plusButtonX && mouseX <= plusButtonX + plusButtonWidth && 
    mouseY >= plusButtonY && mouseY <= plusButtonY + plusButtonHeight) {
    return true;
  } 
  else {
    return false;
  }
}

// Checks if a circle has been clicked on and sets the card's state accordingly 
void checkCicleClick() {
 for (int i = 0; i < cards.size(); i++) { 
    cards.get(i).renderCard();
    if (cards.get(i).isCheckCircleHovered()) {
      cards.get(i).isChecked = !cards.get(i).isChecked;
    }
 }
}

// Checks if the delete icon for a card has been clicked
boolean checkDeleteClick() {
  for (int i = 0; i < cards.size(); i++) { 
    if (cards.get(i).isTrashHovered()) {
      removeCard(i);
      i--;
      return true;
    }
 }
 return false;
}

// Removes the card from the array and adjusts the positioning of the remaining cards
void removeCard(int index) {
  for (int i = 0; i < cards.size(); i++) { 
    if (i > index) {
      cards.get(i).cardY -= 90;
      cards.get(i).checkCircleY -= 90;
      cards.get(i).titleY -= 90;
      cards.get(i).trashY -= 90;
      cards.get(i).renderCard();
    }
 }  
   cards.remove(index);
   cardYOffset -= 90;
}

// After the 'next day' button is pressed, send the checked tasks to the Arduino remove all checks from circles
void removeCircleChecks() {
  sendToArduino();
  for (int i = 0; i < cards.size(); i++) { 
    cards.get(i).isChecked = false; 
  }  
}

// Send task completion data to the Arduino
void sendToArduino() {
  for (int i = 0; i < cards.size(); i++) { 
    println(cards.get(i).isChecked);
    if (cards.get(i).isChecked) {
      myPort.write(i);
      delay(3000);
    }
  }
}

// Set cards as old, so they can no longer be edited 
void setCardsOld() {
  for (int i = 0; i < cards.size(); i++) { 
    cards.get(i).isNew = false; 
  }
}

// Returns the first card marked new 
ActivityCard getNewCard() {
  for (int i = 0; i < cards.size(); i++) { 
    ActivityCard card = cards.get(i);
    if (card.isNew) {
      return card;
    }
  }
  return null;
}

// Appends the letter to the name of the card 
void appendCardName(char letter) {
  ActivityCard newCard = getNewCard();
  if (newCard != null) {
    if (newCard.titleText.contains("Task ")) {
      newCard.titleText = "";
    }
    newCard.titleText += letter;
  }
}

// Removes the last letter from the card title 
void backspaceCardName() {
  ActivityCard newCard = getNewCard();
  if (newCard != null) {
    String currentTitle = newCard.titleText;
    newCard.titleText = currentTitle.substring(0, currentTitle.length() - 1);
  }
}
