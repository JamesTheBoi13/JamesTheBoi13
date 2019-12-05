class Ball {
  float x, y;
  color c;
  float spdX, spdY;
  float r;
  
  Ball(float newSpdX, float newSpdY, color newColor) {
   r = 50;
   spdX = newSpdX;
   spdY = newSpdY;
   c = newColor;
   x = width/2;
   y = height/2;
  }  
  void move() {
    if (mousePressed){
    x += spdX;
    y += spdY; 
    }
  }  
  void display() {
    fill(c);
    ellipse(x, y, r, r);
  }
}
