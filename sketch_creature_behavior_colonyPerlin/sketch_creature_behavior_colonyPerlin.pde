import teilchen.Physics;
import teilchen.util.CollisionManager;
import teilchen.behavior.Arrival;

final int CANVAS_WIDTH = 1200;
final int CANVAS_HEIGHT = 800;

int perlinX1;
int perlinY1;

int perlinX2;
int perlinY2;

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
  
  physics = new Physics();
  
  collision = new CollisionManager();
  collision.minimumDistance(25);
  
  colony1 = new Colony(physics, collision); 
  colony2 = new Colony(physics, collision);  
  loadImages();
  
}

void draw() {
  
  perlin();
  colony1.migrate_to(perlinX1, perlinY1);
  colony2.migrate_to(perlinX2,perlinY2);
  
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
  
}

void keyPressed(){
    Creature c = new TriangleCreature(mouseX, mouseY, 10);
  
  creatures.add(c);
  
  colony2.add(c);
}

void perlin(){

  
    acceleration.x = map(noise(noff.x), 0, 1, -1, 1);
    acceleration.y = map(noise(noff.y), 0, 1, -1, 1);
    acceleration.mult(1.0);
    
    noff.add(0.01, 0.01, 0);
    println(noff.x);
    
    velocity.add(acceleration);
    velocity.limit(10);
    location.add(velocity);
    location.x = constrain(location.x, 70, 420);//constrain colony between these values.
    location.y = constrain(location.y, 200, 400);
  
    perlinX1 = (int)(constrain(location.x, 70, 400));
    perlinY1 = (int)(constrain(location.y, 200, 400));
    
    perlinX2 = (int)(constrain(location.x+100, 70, 400));
    perlinY2 = (int)(constrain(location.y-200, 200, 400));
    
    
}
