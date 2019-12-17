Snow theboi;
int hi=0;
ArrayList<Snow> snowList = new ArrayList<Snow>();
PImage img;
import processing.sound.*;
SoundFile sound1;
SoundFile sound2;
SoundFile sound3;
SoundFile sound4;
SoundFile sound5;
SoundFile soundlist[] = {sound1, sound2, sound3, sound4, sound5};
ArrayList<SoundFile> soundList = new ArrayList<SoundFile>();
import processing.serial.*;
String myString = null;
Serial myPort;
int NUM_OF_VALUES = 4;
int[] sensorValues;
int blockSize = 125;
boolean[][] pTiles;
int score = 0;
int highScore = 0;
boolean record = false;
float time = 40;
float startTime = 0;
int gameMode = 0;//0=not start 1=start 2=over
boolean keyCTrigger = false;
boolean keyDTrigger = false;
boolean keyETrigger = false;
boolean keyFTrigger = false;
int songList[] = {3,3,3,3,3,3,3,5,1,2,3,4,4,4,4,3,3,5,5,3,2,1,3,3,3,3,3,3,3,5,1,2,3,4,4,4,4,3,3,5,5,3,2,1,3,3,3,3,3,3,3,5,1,2,3,4,4,4,4,3,3,5,5,3,2,1};
int a = 0;


void setup() {
  fullScreen();
  img = loadImage("floatingKeys.jpg");
  sound1 = new SoundFile(this, "Cnote.mp3");
  sound2 = new SoundFile(this, "Dnote.mp3");
  sound3 = new SoundFile(this, "Enote.mp3");
  sound4 = new SoundFile(this, "Fnote.mp3");
  sound5 = new SoundFile(this, "Gnote.mp3");
  
  soundList.add(sound1);
  soundList.add(sound2); 
  soundList.add(sound3);
  soundList.add(sound4); 
  soundList.add(sound5);
  
  
  setupSerial();
  pTiles = new boolean[4][ height - 50 / blockSize + 1];
  for (int i = 0; i < height - 50 / blockSize + 1; i++) {
    int t = int(random(0, 4));
    for (int j = 0; j < 4; j++) {
      if (j == t) {
        pTiles[j][i] = true;
      } else {
        pTiles[j][i] = false;
      }
    }
  }
}


void draw() {
  snowList.add(new Snow());
  
  if(frameCount<200){
    background(0);
    textSize(35);
    fill(255);
    text("Floating Keys Loading!",width/2 - 155,height/2,400,400);
    for(int i = 0; i<snowList.size(); i++) {
    Snow temp = snowList.get(i);
    temp.display();
    temp.checkEdges();
    temp.move();

  }
  
  for(int j = snowList.size()-1; j>=0 ; j--){
    Snow p = snowList.get(j);
    if(p.isDone){
      snowList.remove(j);
    }
    
  }
  
  }
  else {
  
  background(255);
  fill(255);
  fill(50, 205, 50);
  sensorPressed();
  design();
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < height - 50/blockSize+1; j++) {
      if (pTiles[i][j]) {
        fill(177,18,38);
      } else {
        noFill();
      }
      rect(i *100 + width/3.275, height - 50 - blockSize - j*blockSize, 100, blockSize);
    }
  }

  fill(0);

  textSize(18);
  text(score, width - 250, height/2);
  text("Current Score:", width - 375, height/2);
  if(record){
    fill(255,0,0);
  }else{
    fill(128);
  }
  text("High Score:", width - 350, height/2 + 50);
  text(highScore,width - 250,height/2 + 50);

    //text("-10", 50, 750);
  fill(0);
  if(gameMode == 0){
    textSize(35);
    text("Quick! \n Put your hand \n in the box!", width/4 - 250, height/2 - 100);
  }else if(gameMode == 1){
    text((startTime + time * 1000 -millis())/1000,50,750);
    rect(300,150 + 675 - 675 * ((startTime + time * 1000 -millis())/1000) / time,40,675 * ((startTime + time * 1000 -millis())/1000) / time);
    if(startTime + time * 1000 -millis() <= 0){
      gameMode = 2;
      if(highScore < score){
        record = true;
        highScore = score;
      }
    }
  }else if(gameMode == 2){
    text("Game Over",50,750);
    text("Please Press R To Start Over",width / 2 + 280, height - 145);
  }
  }
}

void playSound() {
  soundList.get( songList[a]-1 ).play();
  a++;
  
}

void sensorPressed() {
  fill(0, 50);
  updateSerial();
 // printArray(sensorValues);
  if (gameMode != 2) {
    if (sensorValues [0] >= 15 && keyCTrigger) {
      keyCTrigger = false;
      rect(100, height - 50, 100, 25);
      pushTile(0);
      playSound();
    }
    if (sensorValues [1] >= 15 && keyDTrigger) {
      keyDTrigger = false;
      rect(200, height - 50, 100, 25);
      pushTile(1);
      playSound();
    }
    if (sensorValues [2] >= 15 && keyETrigger) {
      keyETrigger = false;
      rect(300, height - 50, 100, 25);
      pushTile(2);
      playSound();
    }
    if (sensorValues [3] >= 15 && keyFTrigger) {
      keyFTrigger = false;
      rect(400, height - 50, 100, 25);
      pushTile(3);
      playSound();
    }
    
    if(sensorValues [0] < 15 && keyCTrigger==false){
      keyCTrigger=true;
    }
    if(sensorValues [1] < 15 && keyDTrigger==false){
      keyDTrigger=true;
    }
    if(sensorValues [2] < 15 && keyETrigger==false){
      keyETrigger=true;
    }
    if(sensorValues [3] < 15 && keyFTrigger==false){
      keyFTrigger=true;
    }
  }
  }


void pushTile(int n) {
  if (gameMode == 0) {
    gameMode = 1;
    startTime = millis();
  }
  if (pTiles[n][0]) {
    step();
    score++;
  } else {
    background(255, 0, 0);
    score -= 1;
  }
}

void keyPressed() {
  if (key == 'r'){
    reset();
  }
}

void design() {
  image(img,width/1.5,height/4);
  img.resize(400,250);
  
  fill(0,255,0);
  rect(width/2 - 250, height - 50, 100, 25);
  fill(255);
  rect(width/2 - 230, height - 50, 60, 15);
  fill(255, 255, 0);
  rect(width/2 - 150, height - 50, 100, 25);
  fill(255);
  rect(width/2 - 130, height - 50, 60, 15);
  fill(255, 140, 0);
  rect(width/2 - 50, height - 50, 100, 25);
  fill(255);
  rect(width/2 - 30, height - 50, 60, 15);
  fill(50, 82, 123);
  rect(width/2 + 50, height - 50, 100, 25);
  fill(255);
  rect(width/2 + 70, height - 50, 60, 15);

  line(width/2 - 250, 0, width/2 - 250, height-50);
  line(width/2 - 150, 0, width/2 - 150, height-50);
  line(width/2 - 50, 0, width/2 - 50, height-50);
  line(width/2 + 50, 0, width/2 + 50, height-50);
  line(width/2 + 150, 0, width/2 + 150, height-50);
}

void step() {
  for (int i = 1; i < height - 50 / blockSize + 1; i++) {
    for (int j = 0; j < 4; j++) {
      pTiles[j][i-1] = pTiles[j][i];
    }
  }
  int t = int(random(0, 4));
  for (int j = 0; j < 4; j++) {
    if (j == t) {
      pTiles[j][height - 50 / blockSize] = true;
    } else {
      pTiles[j][height - 50 / blockSize] = false;
    }
  }
}

void reset() {
  score = 0;
  gameMode = 0;
  record = false;
  for (int i = 0; i < height - 50 / blockSize + 1; i++) {
    int t = int(random(0, 4));
    for (int j = 0; j < 4; j++) {
      if (j == t) {
        pTiles[j][i] = true;
      } else {
        pTiles[j][i] = false;
      }
    }
  }
}


void setupSerial() {
 // printArray(Serial.list());
  myPort = new Serial(this, Serial.list()[3], 9600);
  myPort.clear();
  // Throw out the first reading,
  // in case we started reading in the middle of a string from the sender.
  myString = myPort.readStringUntil( 10 );  // 10 = '\n'  Linefeed in ASCII
  myString = null;

  sensorValues = new int[NUM_OF_VALUES];
}



void updateSerial() {
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil( 10 ); // 10 = '\n'  Linefeed in ASCII
    if (myString != null) {
      String[] serialInArray = split(trim(myString), ",");
      if (serialInArray.length == NUM_OF_VALUES) {
        for (int i=0; i<serialInArray.length; i++) {
          sensorValues[i] = int(serialInArray[i]);
        }
      }
    }
  }
}
