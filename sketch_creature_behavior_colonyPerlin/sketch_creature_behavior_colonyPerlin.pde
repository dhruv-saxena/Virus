import teilchen.Physics;
import teilchen.util.CollisionManager;
import teilchen.behavior.Arrival;
import processing.serial.*;


final int CANVAS_WIDTH = 1200;
final int CANVAS_HEIGHT = 800;

Serial myPort; 

boolean passwords = false;
boolean pics = false;
boolean apps = false;
boolean destroy = false;

int perlinX1;
int perlinY1;

int perlinX2;
int perlinY2;

int serialVal;

PVector location = new PVector(CANVAS_WIDTH/2, CANVAS_WIDTH/2);;
PVector velocity = new PVector(); 
PVector acceleration = new PVector();;
PVector noff = new PVector(random(1000), random(1000));

Physics physics;

CollisionManager collision;

Colony colony1,colony2;

ArrayList<Creature> creatures = new ArrayList<Creature>();

void setup() {  
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
  background(23, 68, 250);
  frameRate(30);
  
  String portName = Serial.list()[2];
  println(portName);
  myPort = new Serial(this, portName, 9600);
  
  physics = new Physics();
  
  collision = new CollisionManager();
  collision.minimumDistance(25);
  
  colony1 = new Colony(physics, collision); 
  colony2 = new Colony(physics, collision);  
  loadImages();
  
}

void draw() {
  
  serialEvent();
  perlin();
  colony1.migrate_to(perlinX1, perlinY1);
  colony2.migrate_to(perlinX2,perlinY2);
  
  if(passwords){
  colony1.migrate_to(220, 390);
  colony2.migrate_to(300,530);
  }
  
  collision.createCollisionResolvers();
  collision.loop(1.0 / frameRate);

  physics.step(1.0 / frameRate);
 
  background(0);
  stroke(255);
  noFill();
  
  for(int i = 0; i < creatures.size(); i++) {
    Creature c = creatures.get(i);
    c.display();
  }
  
  collision.removeCollisionResolver();
  
  renderImages();
  drawEllipses();

}

void mousePressed() {
  
  Creature c = new CircleCreature(mouseX, mouseY, 10);
  
  creatures.add(c);
  
  colony1.add(c);
  println(mouseX,mouseY);
}

void keyPressed(){
    Creature c = new CircleCreature(mouseX+100, mouseY-100, 10);
  
  creatures.add(c);
  
  colony2.add(c);
}

void perlin(){

  
    acceleration.x = map(noise(noff.x), 0, 1, -1, 1);
    acceleration.y = map(noise(noff.y), 0, 1, -1, 1);
    acceleration.mult(1.0);
    
    noff.add(0.01, 0.01, 0);
    
    velocity.add(acceleration);
    velocity.limit(10);
    location.add(velocity);

  
    perlinX1 = (int)(constrain(location.x, 200, 400));
    perlinY1 = (int)(constrain(location.y, 200, 600));
    
    perlinX2 = (int)(constrain(location.x+100, 200, 400));
    perlinY2 = (int)(constrain(location.y-200, 200, 600));
    
    
}

void serialEvent(){
  
  if ( myPort.available() > 0) {  // If data is available,
    serialVal = myPort.read();         // read it and store it in val
  }
  if (serialVal == 0){               
    passwords = true;
    pics = false; 
    apps = false;
    destroy = false;
}

  if (serialVal == 1){               
    passwords = false;
    pics = true; 
    apps = false;
    destroy = false;
}    

  if (serialVal == 2){               
    passwords = false;
    pics = false; 
    apps = true;
    destroy = false;
}

  if (serialVal == 3){               
    passwords = false;
    pics = false; 
    apps = false;
    destroy = true;
}

}
