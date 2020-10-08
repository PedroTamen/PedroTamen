class Hole{
  PVector position;
  float radius;
  
  
  Hole(float x, float y, float r){
    position = new PVector(x, y);
    radius = r;
    
  }
  
  void display() {
    noStroke();
    fill(0);
    ellipse(position.x, position.y, radius*2, radius*2);
  }
  
}
