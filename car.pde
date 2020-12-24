import processing.sound.*;
class Car extends Vehicle {
  SoundFile carbrake;
  SoundFile caracc;

  Car(int startX, int startY, float velX, float velY, float wt, float dur ) { //wt is the amount of time (in seconds) between each brake. dur is the duration of each brake.


    this.veh1 = loadImage("car1.png");
    this.veh2 = loadImage("car2.png");
    this.x =startX;
    this.y =startY;
    this.vx = velX;
    this.vy = velY;
    this.move = true;
    this.wait = wt;
    this.duration = dur;
    carbrake = new SoundFile(animatedCityScape.this, "carbrake.mp3");
    caracc = new SoundFile(animatedCityScape.this, "caracc.mp3");
  }
  void brake() {
    if (millis() >= (time+(wait+duration)*1000)) {
      move = true;
      time = millis();
    }
    if (move == true) {
      if (millis() > (time+wait*1000) && millis() < (time +(wait+duration)*1000)) {
        move = false;
      }
    }
  }
  void playAccSound() {
    caracc.play();
  }
  void playBrakeSound() {
    carbrake.play();
  }
}
