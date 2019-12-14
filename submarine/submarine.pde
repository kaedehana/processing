int gseq;
int px = 200;
int py = 420;
int pw = 40;
int ph = 20;
float bx; //ball座標
float by;
float spdx; //ball速度
float spdy;
int bw = 7; //ball幅と高さ
int bh = 7;
boolean phit = false;
int blw = 78;
int blh = 30;
final int BNUM = 25;
boolean[] blf = new boolean[BNUM];
float lastx;
float lasty;
boolean bexist = false;
int score;
int mcnt;
void setup(){
  size(400,500);
  noStroke();
  colorMode(HSB,100,100,100);
  gameInit();
}

void draw(){
  background(0);
  switch(gseq){
    case 0:
      select();
      break;
    case 1:
      gameTitle();
      break;
    case 2:
      gamePlay();
      break;
    default:
      gameOver();
      break;
  }
}

void select(){
  textSize(20);
  fill(0,100,100);
  mcnt++;
  if(mcnt % 50 < 40){
    text("Please select difficulty",100,20);
  }
  fill(0,0,100);
  text("easy: 'a' press",100,50);
  text("difficult: 'b' press",100,80);
}

void keyPressed(){
  if(key=='a'){
    spdx = 2;
    spdy = 2;
    gseq = 1;
  }
  if(key=='b'){
    spdx = 10;
    spdy = 10;
    gseq = 1;
  }
}
void gameInit(){
  gseq = 0;
  bx = 100;
  by = 250;
  spdx = 5;
  spdy = 5;
  phit = false;
  for(int i=0;i<BNUM;i++){
    blf[i] = true;
  }
  bexist = false;
  score = 0;
  mcnt = 0;
}

void gameTitle(){
  playerMove();
  playerDisp();
  blockDisp();
  scoreDisp();
  mcnt++;
  if(mcnt%40 < 30){
    textSize(20);
    fill(20,100,100);
    text("Click to start",140,360);
  }
}

void gamePlay(){
  playerMove();
  playerDisp();
  blockDisp();
  ballMove();
  ballDisp();
  scoreDisp();
}

void gameOver(){
  playerDisp();
  blockDisp();
  scoreDisp();
  textSize(20);
  fill(1,100,100);
  text("GAME OVER",60,300);
  mcnt++;
  if(mcnt%40 < 30){
    textSize(20);
    fill(20,100,100);
    text("Click to retry!",140,360);
  }
}

void playerDisp(){
  fill(0,0,100);
  rect(px,py,pw,ph,5);
}

void playerMove(){
  px = mouseX;
  if(px+pw > width){
    px = width - pw;
  }
}

void ballDisp(){
  imageMode(CENTER);
  fill(0,100,100);
  rect(bx,by,bw,bh);
  imageMode(CORNER);
}

void ballMove(){
  lastx = bx;
  lasty = by;
  bx += spdx;
  by += spdy;
  if(by > height){
    gseq = 3;
  }
  if(by < 0){
    spdy *= -1;
  }
  if(bx < 0 || bx > width){
    spdx *= -1;
  }
  if(!phit && px < bx && px+pw > bx
    && py < by && py+ph > by){
      spdy *= -1;
      phit = true;
      if(!bexist){
        for(int i=0; i<BNUM; i++){
          blf[i] = true;
        }
        score++;
      }
    }
    if(by < py-30){
      phit = false;
    }
}

void blockDisp(){
  int xx,yy;
  bexist = false;
  for(int i=0; i<BNUM; i++){
    if(blf[i]){
      fill(i/5*15,100,100);
      xx = i%5 * (blw+2);
      yy = 50 + i/5 * (blh+2);
      blockHitCheck(i,xx,yy);
      if(blf[i]){
        rect(xx,yy,blw,blh,2);
        bexist = true;
      }
    }
  }
}

void blockHitCheck(int ii,int xx,int yy){
  if(!(xx < bx && xx+blw > bx && yy < by
  && yy+blh > by)){
    return ;
  }
  blf[ii] = false;
  score += 10;
  if(ii < 10){
    score += 10;
  }
  if(xx < lastx && xx+blw > lastx){
    spdy *= -1;
    return ;
  }
  if(yy < lasty && yy+blh > lasty){
    spdx *= -1;
    return ;
  }
  spdx *= -1;
  spdy *= -1;
}

void scoreDisp(){
  textSize(24);
  fill(0,0,100);
  text("score:"+score,10,25);
}

void mousePressed(){
  if(gseq == 1){
    gseq = 2;
  }
  if(gseq == 3){
    gameInit();
  }
}
