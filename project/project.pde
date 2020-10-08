import processing.sound.*;
SoundFile ballHit;
int holeSize = 25;
int turns;
ArrayList<Ball> balls;
Hole[] holes = {
  new Hole(5, 5, holeSize), 
  new Hole(450, 0, holeSize), 
  new Hole(895, 5, holeSize), 
  new Hole(5, 445, holeSize), 
  new Hole(450, 450, holeSize), 
  new Hole(895, 445, holeSize), 
};

void setup()
{
  frameRate(60);
  size(900, 450);
  ballHit = new SoundFile(this, "PoolSound.mp3");
  int ballSize = 15; 

  int col;
  int num;
  col = 30;
  num=0;
  int x;
  int y;
  x= 170;
  y= 150;



  balls = new ArrayList();

  for (int i  = 1; i<16; i++)
  {

    num=num+1;
    if (num<6) {
      balls.add(new Ball(x, y + 30*i, ballSize, i));//first 5
    } else if (num<10) {
      balls.add(new Ball(x+col, y + 30*(i-4.5), ballSize, i));
    } else if (num<13) {
      balls.add(new Ball(x+col*2, y + 30*(i-8), ballSize, i));
    } else if (num<15) {
      balls.add(new Ball(x+col*3, y + 30*(i-10.5), ballSize, i));
    } else {
      balls.add(new Ball(x+col*4, y + 30*(i-12), ballSize, i));
    }
  }
  balls.add(new Ball(600, 225, ballSize, 16));//cue ball
}





void mouseClicked() {

  if (balls.get(balls.size()-1).velocity.x==0) {
    ballHit.play();

    balls.get(balls.size()-1).cueBallHit();
    turns++;
  }
}
void drawPointer() {
  fill(55);
  stroke(255);
  strokeWeight(2);
  line(balls.get(balls.size()-1).position.x, balls.get(balls.size()-1).position.y, mouseX, mouseY);
  ;
}


boolean checkAllBallsGone() {
  boolean gameOver;
  gameOver=true;
  for (Ball b : balls) {
    if (b.ballNumber != 16) {
      if (b.position.x <900) {
        gameOver= false;
      }
    }
  }
  if (gameOver==true) {
    return true;
  } else {
    return false;
  }
}


void winCheck() {
  if (checkAllBallsGone()==true) {
    fill(0);
    textSize(30);
    text("YOU WIN   TURNS TAKEN: "+turns, width/2, height/2);
  }
}

boolean checkBallHoleCollision(Ball currentBall)
{
  for (Hole h : holes) {

    if (dist(currentBall.position.x, currentBall.position.y, h.position.x, h.position.y)<30)
    {
      return true;
    }
  }
  return false;
}



void draw()
{


  background(102, 51, 0);

  fill(0, 102, 0);
  rect(5, 5, 890, 440);
  drawPointer();

  for (Hole h : holes) {
    h.display();
  }
  for (Ball b : balls) {

    b.display();
  }
  for (int outerLooper=0; outerLooper<balls.size(); outerLooper++)
  {
    for (int innerLooper=0; innerLooper<balls.size(); innerLooper++)
    {
      if (outerLooper!=innerLooper) {
        if (balls.get(outerLooper).ballInHole==false||balls.get(innerLooper).ballInHole==false ) {
          if (balls.get(outerLooper).hasCollided(balls.get(innerLooper))==true)
          {


            balls.get(outerLooper).ballCollision(balls.get(innerLooper));
          }
        }
      }
    }
  }

  for (Ball b : balls) {
    b.updatePosition();
    b.checkBoundaryCollision();
    b.ballInHole=checkBallHoleCollision(b);
    
  }


  winCheck();
}


void keyPressed(){
  if (key=='w'){
    fill(0);
    textSize(60);
    text("YOU WIN   TURNS TAKEN: 29", width/2, height/2);
    noLoop();
  }
}


  
  
