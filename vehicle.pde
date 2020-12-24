class Vehicle {
  int time;
  float x, y, vx, vy;
  PImage veh1; 
  PImage veh2;
  boolean move;
  float wait = 4, duration = 1;

  Vehicle() {
    time = millis();

    veh1 = loadImage("car1.png");
    veh2 = loadImage("car2.png");
    x =55;
    y =700;
    vx = 5;
    vy = 0;
    move = true;
  }
  void display() {
    imageMode(CENTER);
    if (vx >0) image(veh1, x, y, 106, 72);
    if (vx <0) image(veh2, x, y, 106, 72);
  }
  void bounce() {
    if (x >=(width-75)) vx = -vx;
    if (x <=75) vx = -vx;
    
  }
  void move() {
    if (move == true) x+=vx;
  }
  void brake(){ //overwrites brake function from vehicle so that it does nothing
    
  }
  void playAccSound(){
    
  }
  void playBrakeSound(){
    
  }
  void handleRightClick() {
    if (mouseX > x-53 && mouseX <x+53 && mouseY > y-36 && mouseY < y+36){
      vx = -0.5*vx;
      playBrakeSound();
    }
  }
  void handleLeftClick() {

    if (mouseX > x-53 && mouseX <x+53 && mouseY > y-36 && mouseY < y+36){
      vx = vx*2;
      playAccSound();
    }
  } 
}
