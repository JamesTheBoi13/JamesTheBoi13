Ball james;
Ball jame;

ArrayList<Ball> ballList = new ArrayList<Ball>();

void setup() {
  size(1600,900);
  
  for(int i=0; i<100; i++) {
    ballList.add(new Ball(random(-10,10),random(-10,10),color(random(255)) ));
  }
  //james = new Ball(random(-10,10),random(-10,10),color(random(255)) );
  //jame = new Ball(5, 0, color(0,0,255));
  
}

void draw() {
  background(255,255,150);
  //james.display();
  //jame.display();
  //james.move();
  //jame.move();
  for(int i = 0; i<ballList.size(); i++) {
    Ball temp = ballList.get(i);
    temp.display();
    temp.move();
  }
  
}
