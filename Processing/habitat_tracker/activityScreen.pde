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

void addCard() {
  ActivityCard newCard = new ActivityCard(cardXOffset, cardYOffset, cardCount);
  cards.add(newCard);
  cardCount++;
  
  cardYOffset += 90;
}

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

boolean isNextButtonHovered() {
  if (mouseX >= nextButtonX && mouseX <= nextButtonX + nextButtonWidth && 
    mouseY >= nextButtonY && mouseY <= nextButtonY + nextButtonHeight) {
    return true;
  } 
  else {
    return false;
  }
}

boolean isPlusButtonHovered() {
  if (mouseX >= plusButtonX && mouseX <= plusButtonX + plusButtonWidth && 
    mouseY >= plusButtonY && mouseY <= plusButtonY + plusButtonHeight) {
    return true;
  } 
  else {
    return false;
  }
}

void checkCicleClick() {
 for (int i = 0; i < cards.size(); i++) { 
    cards.get(i).renderCard();
    if (cards.get(i).isCheckCircleHovered()) {
      cards.get(i).isChecked = !cards.get(i).isChecked;
    }
 }
}

boolean checkDeleteClick() {
  for (int i = 0; i < cards.size(); i++) { 
    if (cards.get(i).isTrashHovered()) {
      println(cards);
      removeCard(i);
      i--;
      return true;
    }
 }
 return false;
}

void removeCard(int index) {
  
  println("removed card for " + index);
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

void removeCircleChecks() {
  sendToArduino();
  for (int i = 0; i < cards.size(); i++) { 
    cards.get(i).isChecked = false; 
  }  
}

void sendToArduino() {
  println("sending");
  for (int i = 0; i < cards.size(); i++) { 
    println(cards.get(i).isChecked);
    if (cards.get(i).isChecked) {
      println("printing " + i);
      myPort.write(i);
      delay(3000);
    }
  }
}

void setCardsOld() {
  for (int i = 0; i < cards.size(); i++) { 
    cards.get(i).isNew = false; 
  }
}

ActivityCard getNewCard() {
  for (int i = 0; i < cards.size(); i++) { 
    ActivityCard card = cards.get(i);
    if (card.isNew) {
      return card;
    }
  }
  return null;
}

void appendCardName(char letter) {
  ActivityCard newCard = getNewCard();
  if (newCard != null) {
    if (newCard.titleText.contains("Task ")) {
      newCard.titleText = "";
    }
    newCard.titleText += letter;
  }
}

void backspaceCardName() {
  ActivityCard newCard = getNewCard();
  if (newCard != null) {
    String currentTitle = newCard.titleText;
    newCard.titleText = currentTitle.substring(0, currentTitle.length() - 1);
  }
}
