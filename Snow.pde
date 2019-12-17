class Snow {
  float x, y;
  int c;
  float spdX, spdY;
  float r;
  boolean isDone;
  
  Snow() {
    r = random(5,8);
    spdX = random(-2,2);
    spdY = 5;
    c = int(random(30,255));
    x = random(width);
    y = 0;
    isDone = false;
  }
  
  void checkEdges(){
    if(x<0 || y>height){
      isDone = true;
    }
    
  }
  void move() {
    x += spdX;
    y += spdY;
    
  }
  void display() {

    fill(255,c);
    ellipse(x,y,r,r);
  }
}
