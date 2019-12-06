class Square {
  float x, y;
  color c;
  float spdX, spdY;
  float size;
  
  Square(float newSpdX, float newSpdY, color newColor) {
   size = 50;
   spdX = newSpdX;
   spdY = newSpdY;
   c = newColor;
   x = width/2;
   y = 0;
  }  
  void move() {
    if (mousePressed) {
    x += spdX;
    y += spdY; 
    }

  }  
  void display() {
    fill(c);
    rect(x, y, size, size);
  }
}
