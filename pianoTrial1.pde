ArrayList<Integer> blocks = new ArrayList<Integer>();
int a=0;
int t=0;
int y;

void setup(){
      
      for( int i =0; i<100; i++){
    blocks.add(int(random(0,4)));
      }
   System.out.println(blocks);
    size(400,400);
    
    

}

void draw(){
  for(int m = 0; m<8; m++){
    for(int n = 0; n<4; n++){
      noFill();
      rect(n*30+150,m*30,30,30);
    }
    
        for(int j = 0; j<100; j++){
     a = blocks.get(j);
     //println(a);
      fill(255,0,0);
      y = 240-j*30;
      
      if(key =='1'){
       y= y+30;
      }
      rect(a*30+150,y,30,30);
    }
    
  }
}
