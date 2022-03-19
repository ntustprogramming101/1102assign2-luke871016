PImage bgImg,groundhogImg,lifeImg,robotImg,soilImg,soldierImg;
int soldierLayer,robotLayer;
PVector soldierPosition,robotPosition;
float laserBegin,laserEnd,laserOffset,laserLength = 30;
float launchOffset = 25;
void setup() {
	size(640, 480);
  // loadImage
  bgImg = loadImage("img/bg.jpg");
  groundhogImg = loadImage("img/groundhog.png");
  lifeImg = loadImage("img/life.png");
  robotImg = loadImage("img/robot.png");
  soilImg = loadImage("img/soil.png");
  soldierImg = loadImage("img/soldier.png");
  
  // soldier layer and
  soldierLayer = int(random(0,4));
  soldierPosition = new PVector(random(width),160+soldierLayer*80);
  
  // robot layer and position
  robotLayer = int(random(0,4));
  robotPosition = new PVector(random(160,width-80),160+robotLayer*80);
}

void draw() {
  // background
  image(bgImg,0,0);
  
  // life
  image(lifeImg,10,10);
  image(lifeImg,80,10);
  image(lifeImg,150,10);
  
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
  
  // groundhog
  image(groundhogImg,width/2-40,80);
  
  // soldier
  soldierPosition.x += 4;
  if(soldierPosition.x >= width){
      soldierPosition.x = -80;
    }
  image(soldierImg,soldierPosition.x,soldierPosition.y);
  
  // robot
  image(robotImg,robotPosition.x,robotPosition.y);
  
  // laser
  strokeWeight(10);
  stroke(255,0,0);
  laserOffset += 2;
  if(laserOffset >= 180){
    laserOffset = 0;
  }
  if(laserOffset <= 20){
    laserBegin = robotPosition.x + launchOffset;
    laserEnd = laserBegin - laserOffset;
  }else{
    laserBegin = robotPosition.x + launchOffset - laserOffset + laserLength;
    laserEnd = laserBegin - laserLength;
  }
  line(laserBegin,robotPosition.y + 40,laserEnd,robotPosition.y + 40);
}
