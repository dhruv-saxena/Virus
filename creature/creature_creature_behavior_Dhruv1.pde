import teilchen.Physics;
import teilchen.util.CollisionManager;

final int CANVAS_WIDTH = 1200;
final int CANVAS_HEIGHT = 800;


Physics physics;

CollisionManager collision;

CreatureBehavior colony;

ArrayList<Creature> creatures = new ArrayList<Creature>();

void setup() {  
  size(CANVAS_WIDTH, CANVAS_HEIGHT);
  background(0);
  frameRate(30);
  loadImages();
  
  
  physics = new Physics();
  
  collision = new CollisionManager();
  collision.minimumDistance(25);
  
  colony = new ColonyBehavior(physics, collision); 

  
}

void draw() {
  background(0,0,255);
  
  collision.createCollisionResolvers();
  collision.loop(1.0 / frameRate);

  physics.step(1.0 / frameRate);
 
  
  stroke(255);
  noFill();
  
  for(int i = 0; i < creatures.size(); i++) {
    Creature c = creatures.get(i);
    c.display();
  }
  
  collision.removeCollisionResolver();
  colony.update(1);

renderImages();
drawEllipses();
}

void mousePressed() {
  /*
  for(int i =0; i<20; i++){
  
  Creature c = new TriangleCreature(mouseX+i*10, mouseY+i*10, 10);
  
  creatures.add(c);
  
  colony.add(c);
  }
  */
  println(mouseX,mouseY);
  
}

void keyPressed() {
  
  // Inform the colony of the KEY pressed
  colony.event(key);

  
}

void drawEllipses(){
fill(255,0,0);
ellipse(203,402,20,20);
ellipse(295,550,20,20);
ellipse(542,149,20,20);
ellipse(790,529,20,20);
}

