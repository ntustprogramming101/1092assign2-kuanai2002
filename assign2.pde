//pic
PImage title, bg, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage soil, life, cabbage, soldier, groundhogDown, groundhogIdle, groundhogLeft, groundhogRight;

//variation
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

//button
final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

//keyboard
boolean downPressed, rightPressed, leftPressed = false;

//groundhog
int groundhogX = 320, groundhogY = 80;
float groundhogWidth = 80;
float groundhogHeight = 80;
final int upPhoto = 0;
final int downPhoto = 1;
final int leftPhoto = 2;
final int rightPhoto = 3;
int showPhoto = upPhoto;

//soldier
int y = 160;
int soldierX = 80;
int soldierY = y + floor(random(4))*80;
float soldierWidth = 80;
float soldierHeight = 80;
float soldierSpeed;

//cabbage
int cabbageX = floor(random(7))*80;
int cabbageY = y + floor(random(4))*80;

//life
int hp = 2;

void setup() {
  size(640, 480, P2D);
  // Enter Your Setup Code Here
  title = loadImage("img/title.jpg");
  bg = loadImage("img/bg.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  soil = loadImage("img/soil.png");
  life = loadImage("img/life.png");
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  
  soldierSpeed = 5;
}

void draw() {
  
  image(title, 0, 0);
  
  // Switch Game State
  switch(gameState){
    
    // Game Start
    case GAME_START:
    
      if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){        
        image(startHovered, 248, 360);
        if(mousePressed){
          gameState = GAME_RUN;
        }
      }else{
        image(startNormal, 248, 360);
      }
      break;
                  
    // Game Run
    case GAME_RUN:
      
      //background
      image(bg, 0, 0);
      
      //soil
      image(soil, 0, 160);
      
      //grass
      noStroke();
      fill(124, 204, 25);
      rect(0, 145, 640, 15);
      
      //sun
      noStroke();
      fill(255, 255, 0);
      ellipse(590, 50, 130, 130);
      fill(253, 184, 19);
      ellipse(590, 50, 120, 120);
                 
      //soldier
      if(groundhogX < soldierX && groundhogX+80 > soldierX -80
      && groundhogY < soldierY+80 && groundhogY+80 > soldierY){
        if(hp == 1){
          hp -= 1;
          gameState = GAME_OVER;
          groundhogX = 320;
          groundhogY = 80;
        }
        
        if(hp == 2){
          hp -= 1;
          groundhogX = 320;
          groundhogY = 80;
          image(groundhogIdle, 320, 80);
        }
        
        if(hp == 3){
          hp -= 1;
          groundhogX = 320;
          groundhogY = 80;
          image(groundhogIdle, 320, 80);
        }
      }
      
      image(soldier, soldierX - 80, soldierY);
      soldierX += soldierSpeed;
      soldierX %= 640+80;
      
      //life
      if(hp == 1){
        image(life, 10, 10);
      }
      
      if(hp == 2){
        image(life, 10, 10);
        image(life, 80, 10);
      }
      
      if(hp == 3){
        image(life, 10, 10);
        image(life, 80, 10);
        image(life, 150, 10);
      }
      
      //cabbage
        image(cabbage, cabbageX, cabbageY);
            
      if(cabbageX == groundhogX && cabbageY == groundhogY){
        cabbageX = -80;
        cabbageY = -80;
        hp += 1;
      }
      
      //groundhog
      switch(showPhoto){
        case upPhoto:
        image(groundhogIdle, groundhogX, groundhogY);
        break;
        
        case downPhoto:
        image(groundhogDown, groundhogX, groundhogY);
        break;
        
        case leftPhoto:
        image(groundhogLeft, groundhogX, groundhogY);
        break;
        
        case rightPhoto:
        image(groundhogRight, groundhogX, groundhogY);
        break;
      }
            
      break;
                  
     // Game Lose
    case GAME_OVER:
    image(gameover, 0, 0);
    if(mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM){        
        image(restartHovered, 248, 360);
        if(mousePressed){
          gameState = GAME_RUN;
          hp = 2;
          image(groundhogIdle, groundhogX, groundhogY);
          cabbageX = floor(random(7))*80;
          cabbageY = y + floor(random(4))*80;
          soldierY = y + floor(random(4))*80;
          
        }
      }else{
        image(restartNormal, 248, 360);
      }
        break;
      }
}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      
      case DOWN:
      groundhogY += 80;
      if(groundhogY > 400) groundhogY = 400;
      break;
      
      case LEFT:
      groundhogX -= 80;
      if(groundhogX < 0) groundhogX = 0;
      break;
      
      case RIGHT:
      groundhogX += 80;
      if(groundhogX > 560) groundhogX = 560;
      break;
      
    }
  }
  
}

void keyReleased(){
  
}
