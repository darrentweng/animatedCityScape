float time; //used as a counter

//defining the cloud and sky properties
int maxClouds = 100;
int [] cloudX = {}; 
int [] cloudY = {};
int [] cloudW = {};
int [] cloudH = {};
color sunColor;
int sunX = 100, sunY = 100;
//defining the brick & building properties
int [] brickCD = {}; //color differences array
color brickC;
int [] buildingX = {0};
int buildingY = 200;
int [] buildingW = {0};
int [] buildingH = {};
boolean light = true;
Vehicle[] vehicles = new Vehicle[6]; //list of vehicles
PImage helpButton;
boolean showHelp;

void setup() { 
  size(1000, 800);

  //Instantiation of 4 cars and two planes
  vehicles[0] = new Car(100, 700, 15, 0, 10, 2 ); //Car(int startX, int startY, float velX, float velY, float wt, float dur )
  vehicles[1] = new Car(200, 750, 8, 0, 5, 1 );
  vehicles[2] = new Car(900, 650, 5, 0, 10, 2 );
  vehicles[3] = new Car(500, 600, 3, 0, 5, 1 );

  vehicles[4] = new Plane(95, 150, 4, 0, 1, 25); //Plane(int startX, int startY, float velX, int velY, float acc, float ms)
  vehicles[5] = new Plane(95, 200, 8, 0, 1, 20);

  sunColor = color(255, 200, 0);
  helpButton = loadImage("help.png");
  //randomizing properties of the clouds
  for (int c=0; c<maxClouds; c+=1) { 
    cloudX = append(cloudX, int(random(0, 1000)));
    cloudY = append(cloudY, int(random(150, 200)));
    cloudW = append(cloudW, int(random(100, 300)));
    cloudH = append(cloudH, int(random(50, 125)));
  }
  //randomizing properties of the building
  for (int c=1; c<=100; c++) {
    buildingX = append(buildingX, buildingX[c-1]+buildingW[c-1]*20);
    buildingW = append(buildingW, int(random(3, 8)));
    buildingH = append(buildingH, int(random(10, 40)));
  }
  for (int c=0; c<2000; c+=1) {
    brickCD = append(brickCD, int(random(0, 30)));
  }
}

void draw() {
  background(#B5CCDB); //sky color

  for (int c = 1; c<1000/60; c++) {
    drawBuilding(buildingX[c], buildingY, buildingW[c]*20, buildingH[c]*10);
  }
  drawSky(25, sunColor, 10);

  //drawing the road
  fill(100);
  rect(0, height-buildingY, width, buildingY);
  fill(200, 200, 20);
  for (int i =0; i<10; i++) {
    rectMode(CENTER);
    rect(i*100+50, height-(buildingY/2), 60, 20);
  }

  //making the vehicles move
  for (int i = 0; i< vehicles.length; i++) {
    vehicles[i].display();
    vehicles[i].display();
    vehicles[i].move();
    vehicles[i].bounce();
    vehicles[i].brake();
  }
}

void drawSky(int n, color c, int speed) {
  for (int i=1; i<=n; i++ ) {

    noStroke();
    fill(255, 255, 255, 150);
    ellipse(cloudX[i], cloudY[i], cloudW[i], cloudH[i]);
    if (cloudX[i] < (width+cloudW[i]/2)) {
      cloudX[i]+=1+(speed/5);
    } else if (cloudX[i] >= (width+cloudW[i]/2)) {
      cloudX[i]=0;
    }
  }
  fill(c);
  for (int s = 1; s<20; s+=1) {
    noStroke();
    fill(c, 5);
    ellipse(sunX, sunY, 100*s/5, 100*s/5); //creates a light effect
  }

  fill(c);
  ellipse(sunX, sunY, 100, 100); //sun drawing

  image(helpButton, 930, 70, 50, 50); //help button
  if (showHelp) {
    textSize(32);
    fill(0);
    text("- Left click on a vehicle to accelerate.\n- Right click on a vehicle to brake and turn around." + 
    "\n- Click on the Sun to toggle the building lights.\n- Click on the Help Button again to hide this message." + 
    "\n                            Sketch made by Darren Weng", 10, 30);
  }
}

void drawBuilding(int x, int y, int w, int h) {
  rectMode(CORNER);
  fill(150);
  pushMatrix();
  translate(0, height);
  scale(1, -1); //changes the coordinate system
  for (int n = 0; n<w/20; n++) { //this makes the rows
    for (int i = 0; i<h/10; i++) { //this makes the columns
      brickC = color(160-int(brickCD[(n*10+i)]*2), int(brickCD[(n*10+i)]), int(brickCD[(n*10+i)]));
      fill(brickC);
      stroke(200); //paste
      strokeWeight(1);
      rect(n*20+x, i*10+y, 20, 10);
    }
  }
  fill(0, 0, 0, 0);
  stroke(0);
  strokeWeight(3);
  rect(x, y, w, h);
  fill(0);
  for (int n = 1; n<=(int((w/20)/3)+1); n++) {
    for (int i = 1; i<=(int((h/10)/3)+1); i++) {
      int nhw = (int((w/20)/3)+1); //number of windows horizontally
      int nvw = (int((h/10)/3)+1); //number of windows vetcially

      if (light == true) {
        fill(255, 255, 50);
      }
      if (light == false) {
        fill(#E8F0F5);
      }
      strokeWeight(1);
      rectMode(CENTER);
      rect(x+(n*(w/(nhw+1))), (y+(i*(h/(nvw+1)))), 15, 15); //making windows equally spaced apart
      rectMode(CORNER);
    }
  }
  popMatrix();
}

void mousePressed() {
  //println(mouseX + ", " + mouseY + ", " + dist(mouseX, mouseY, 930, 70)); 
  //check each vehicle
  for (int i = 0; i< vehicles.length; i++) {
    if (mouseButton == LEFT) {
      vehicles[i].handleLeftClick();
    } else {
      vehicles[i].handleRightClick();
    }
  }
  if (dist(mouseX, mouseY, 930, 70) <25) { //click on the help button
    showHelp = !showHelp;
  }
  if (dist(mouseX, mouseY, 100, 100) <50) { //click on the sun
    light = !light;
  }
}
