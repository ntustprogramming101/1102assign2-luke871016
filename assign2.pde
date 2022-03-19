final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;

final int HOG_IDLE = 0;
final int HOG_LEFT = 1;
final int HOG_RIGHT = 2;
final int HOG_DOWN = 3;

int soldierLayer,robotLayer;
PVector soldierPosition,cabbagePosition,groundhogPosition;

PImage titleImg,bgImg,gameoverImg,soilImg;
PImage cabbageImg,lifeImg;
PImage soldierImg;
PImage groundhogIdleImg,groundhogDownImg,groundhogLeftImg,groundhogRightImg;
PImage startNormalImg,startHoveredImg,restartNormalImg,restartHoveredImg;

int gameState = GAME_START;
int lifeCount = 2;
int movingFrame = 16;
int groundhogState = HOG_IDLE;

boolean movingDetection;
void setup() {
  // canva setting
	size(640, 480);
  frameRate(60);
	// loadImage
  titleImg = loadImage("IMG/title.jpg");
  bgImg = loadImage("IMG/bg.jpg");
  gameoverImg = loadImage("IMG/gameover.jpg");
  soilImg = loadImage("IMG/soil.png");
  cabbageImg = loadImage("IMG/cabbage.png");
  lifeImg = loadImage("IMG/life.png");
  soldierImg = loadImage("IMG/soldier.png");
  groundhogIdleImg = loadImage("IMG/groundhogIdle.png");
  groundhogDownImg = loadImage("IMG/groundhogDown.png");
  groundhogLeftImg = loadImage("IMG/groundhogLeft.png");
  groundhogRightImg = loadImage("IMG/groundhogRight.png");
  startNormalImg = loadImage("IMG/startNormal.png");
  startHoveredImg = loadImage("IMG/startHovered.png");
  restartNormalImg = loadImage("IMG/restartNormal.png");
  restartHoveredImg = loadImage("IMG/restartHovered.png");
  
  // soldier layer and position
  soldierLayer = int(random(0,4));
  soldierPosition = new PVector(random(width),160+soldierLayer*80);
  
  // groundhog position
  groundhogPosition = new PVector(80*5,80);
  
  // cabbage position
  int cabbageIndexX = int(random(0,8));
  int cabbageIndexY = int(random(0,4));
  cabbagePosition = new PVector(cabbageIndexX * 80 , 160 + cabbageIndexY * 80);
}

void draw() {
	// Switch Game State
  switch(gameState){
    case GAME_START:
		// Game Start
      //titleImg and start button
      image(titleImg,0,0);
      if(mouseX >= 248 && mouseX <= 248+144 && mouseY >= 360 && mouseY <= 360+60){
        image(startHoveredImg,248,360);
        if(mousePressed == true){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormalImg,248,360);
      }
      break;
    case GAME_RUN:
		// Game Run
      // background
      image(bgImg,0,0);
      // life
      for(int i=0;i<lifeCount;i++){
        image(lifeImg,10 + i*70,10); 
      }
      // sun
      noStroke();
      fill(255,255,0);
      ellipse(width-50,50,130,130);
      fill(253,184,19);
      ellipse(width-50,50,120,120);
      // grass
      noStroke();
      fill(124,204,25);
      rect(0,145,width,15);
      // soil
      image(soilImg,0,160);
      // groundhog moving detection
      if(movingFrame==16){
        movingDetection = false;
        groundhogState = HOG_IDLE;
      }else{
        movingDetection = true;
      }
      // groundhog move
      if(movingFrame < 16){
        switch(groundhogState){
          case HOG_LEFT:
            movingFrame += 1;
            groundhogPosition.x-=80/15;
            break;
          case HOG_DOWN:
            movingFrame += 1;
            groundhogPosition.y+=80/15;
            break;
          case HOG_RIGHT:
            movingFrame += 1;
            groundhogPosition.x+=80/15;
            break;
        }
      }
      // groundhog show
      switch(groundhogState){
        case HOG_IDLE:
          image(groundhogIdleImg,groundhogPosition.x,groundhogPosition.y);
          break;
        case HOG_LEFT:
          image(groundhogLeftImg,groundhogPosition.x,groundhogPosition.y);
          break;
        case HOG_RIGHT:
          image(groundhogRightImg,groundhogPosition.x,groundhogPosition.y);
          break;
        case HOG_DOWN:
          image(groundhogDownImg,groundhogPosition.x,groundhogPosition.y);
          break;
      }
      // soldier&groundhog collide detection
      if(groundhogPosition.x < soldierPosition.x+80 &&
         groundhogPosition.x + 80 > soldierPosition.x &&
         groundhogPosition.y < soldierPosition.y + 80 &&
         groundhogPosition.y + 80 > soldierPosition.y){
        groundhogPosition = new PVector(80*5,80);
        movingFrame = 16;
        lifeCount --;
        if(lifeCount == 0){
          gameState = GAME_LOSE;
          break;
        }
      }
      // soldier
      soldierPosition.x += 4;
      if(soldierPosition.x >= width){
        soldierPosition.x = -80;
      }
      image(soldierImg,soldierPosition.x,soldierPosition.y);
      // cabbage&groundhog collide detection
      if(groundhogPosition.x < cabbagePosition.x+80 &&
         groundhogPosition.x + 80 > cabbagePosition.x &&
         groundhogPosition.y < cabbagePosition.y + 80 &&
         groundhogPosition.y + 80 > cabbagePosition.y){
        cabbagePosition = new PVector(-80,-80);
        lifeCount ++;
      }
      // cabbage
      image(cabbageImg,cabbagePosition.x,cabbagePosition.y);
      break;
    case GAME_LOSE:
		// Game Lose
      image(gameoverImg,0,0);
      if(mouseX >= 248 && mouseX <= 248+144 && mouseY >= 360 && mouseY <= 360+60){
        image(restartHoveredImg,248,360);
        if(mousePressed == true){
          lifeCount = 2;
          // soldier layer and position
          soldierLayer = int(random(0,4));
          soldierPosition = new PVector(random(width),160+soldierLayer*80);
          gameState = GAME_RUN;
          // groundhog position
          groundhogPosition = new PVector(80*5,80);
          // cabbage position
          int cabbageIndexX = int(random(0,8));
          int cabbageIndexY = int(random(0,4));
          cabbagePosition = new PVector(cabbageIndexX * 80 , 160 + cabbageIndexY * 80);
        }
      }else{
        image(restartNormalImg,248,360);
      }
      break;
  }
}

void keyPressed(){
  switch(keyCode){
    case LEFT:
      if(!movingDetection && groundhogPosition.x>0){
        movingFrame = 0;
        groundhogState = HOG_LEFT;
      }
      break;
    case RIGHT:
      if(!movingDetection && groundhogPosition.x<width-80){
        movingFrame = 0;
        groundhogState = HOG_RIGHT;
      }
      break;
    case DOWN:
      if(!movingDetection && groundhogPosition.y<height-80){
        movingFrame = 0;
        groundhogState = HOG_DOWN;
      }
      break;
    case SHIFT:
    //debug
      lifeCount = 5;
      groundhogPosition = new PVector(80*5,80);
      movingFrame = 16;
      break;
  }
}

void keyReleased(){
  
}
