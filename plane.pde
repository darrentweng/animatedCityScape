import processing.sound.*;
class Plane extends Vehicle{

  float acc;
  float maxSpeed;
  SoundFile planebrake;
  SoundFile planeacc;
  
  
  Plane(int startX, int startY, float velX, int velY, float acc, float ms) {
    

    this.veh1 = loadImage("plane1.png");
    this.veh2 = loadImage("plane2.png");
    this.x =startX;
    this.y =startY;
    this.vx = velX;
    this.vy = velY;
    this.acc = acc;
    this.maxSpeed = ms;
    this.move = true;
    planebrake = new SoundFile(animatedCityScape.this, "planebrake.mp3");
    planeacc = new SoundFile(animatedCityScape.this, "planeacc.mp3");
  }
  

  
  void accelerate(){
    //work on this later to smooth out.
  }

  void playAccSound(){
    planeacc.play();
  }
  void playBrakeSound(){
    planebrake.play();
  }
}
