
class Ball {
  PVector position;
  PVector velocity;

  color colour;
  float radius, m;
  float topSpeed;
  PVector minSpeed;
  int ballNumber;
  boolean ballInHole;
  Ball(float x, float y, float r, int n) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);


    ballNumber = n;
    topSpeed = 5;
    minSpeed = new PVector(0.5, 0.5);
    radius = r;
    m = radius*.1;
    colour= ballColour();

    ballInHole=false;
  }

  void cueBallHit() {


    velocity.add((mouseX-position.x)/10, (mouseY-position.y)/10);
    println((mouseX-position.x)/10);
    println((mouseY-position.y)/10);

  }

  
  void updatePosition() {
    if (ballInHole==true){
      if (ballNumber==16){
        position.x = 600;
        position.y = 225;
        velocity.x = 0;
        velocity.y = 0;
        ballInHole=false;
      }
      else{
        
        
      position.x=random(10000,1000000);
      position.y=random(10000,1000000);
      }
    }



    velocity.x = velocity.x *0.97;
    velocity.y = velocity.y *0.97;
    if (abs(velocity.x) < 0.2) {
      velocity.x = 0;
    }
    if ((abs(velocity.y)<0.2)) {

      velocity.y = 0;
    }

    position.add(velocity);
  }
  color ballColour() {
    if (ballNumber==1||ballNumber==9) {//yellow
      return color(240, 230, 140);
    } else if (ballNumber==2||ballNumber==10) {//blue
      return color(0, 0, 205);
    } else if (ballNumber==3||ballNumber==11) {//red
      return color(255, 0, 0);
    } else if (ballNumber==4||ballNumber==12) {//purple
      return color(128, 0, 128);
    } else if (ballNumber==5||ballNumber==13) {//orange
      return color(255, 140, 0);
    } else if (ballNumber==6||ballNumber==14) {//green
      return color(0, 255, 0);
    } else if (ballNumber==7||ballNumber==15) {//darkred
      return color(139, 160, 160);
    } else if (ballNumber==8) {//black
      return color(0);
    } else {//white
      return color(255);
    }
  }

  void display() {
    if (ballInHole==false){
      fill(colour);
      ellipse(position.x, position.y, radius*2, radius*2);
      fill(255);
      ellipse(position.x, position.y, radius, radius);
      fill(0);
      textSize(10);
      textAlign(CENTER);


      if (ballNumber!=16) {
        text(ballNumber, position.x, position.y+3);
      }
    }
  }
  boolean hasCollided(Ball anotherBall)
  {
    if (dist(position.x, position.y, anotherBall.position.x, anotherBall.position.y) <= radius*2)
    {
      return true;
    }
    return false;
  }
  void checkBoundaryCollision() {
    if (ballInHole==false){

    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
    }
  }
  }



  void ballCollision(Ball anotherBall)
  {
    // Calculate bounce angle of the two balls.
    float collisionAngle = atan2(anotherBall.position.y-position.y, anotherBall.position.x-position.x);
    float collisionX = cos(collisionAngle);
    float collisionY = sin(collisionAngle);
    float collisionXTangent = cos(collisionAngle+HALF_PI);
    float collisionYTangent = sin(collisionAngle+HALF_PI);
    float collisionPx = position.x + radius*collisionX;
    float collisionPy = position.y + radius*collisionY;

    float v1 = sqrt(velocity.x*velocity.x + velocity.y*velocity.y);
    float v2 = sqrt(anotherBall.velocity.x*anotherBall.velocity.x+anotherBall.velocity.y*anotherBall.velocity.y);

    float d1 = atan2(velocity.y, velocity.x);
    float d2 = atan2(anotherBall.velocity.y, anotherBall.velocity.x);

    float v1x = v1*cos(d1-collisionAngle);
    float v1y = v1*sin(d1-collisionAngle);

    float v2x = v2*cos(d2-collisionAngle);
    float v2y = v2*sin(d2-collisionAngle);

    velocity.x = collisionX*v2x + collisionXTangent*v1y;
    velocity.y = collisionY*v2x + collisionYTangent*v1y;

    position.x = collisionPx - radius*collisionX;
    position.y = collisionPy - radius*collisionY;

    anotherBall.velocity.x = collisionX*v1x + collisionXTangent*v2y;
    anotherBall.velocity.y = collisionY*v1x + collisionYTangent*v2y;

    anotherBall.position.x = collisionPx + anotherBall.radius*collisionX;
    anotherBall.position.y = collisionPy + anotherBall.radius*collisionY;
  }
}
