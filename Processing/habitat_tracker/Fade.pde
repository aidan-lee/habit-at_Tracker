int fadeWidth = 0;
int fadeSpeed = 10;

// Wipes the screen with a black transition
boolean fade(){
  fill(0);
  rect(0,0,fadeWidth,height);
  if(fadeWidth<width+200){
    fadeWidth+=fadeSpeed;
    fadeSpeed+=2;
    fill(255);
    return false;
  }
  else{
    resetFade();
   return true; 
  }
}

void resetFade(){
  fadeWidth = 0;
  fadeSpeed = 10;
}
