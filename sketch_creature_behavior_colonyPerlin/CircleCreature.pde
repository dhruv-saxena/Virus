class CircleCreature extends Creature {
  
  public CircleCreature(int x, int y, int r) {
    super(x, y, r);
    ellipseMode(RADIUS);
  }  
  
  public void draw_shape(){
    ellipse(0, 0, radius(), radius());  
    line(0, 0, radius(), 0);
  }
  
  public boolean inside(int mx, int my) {    
    if(dist(mx, my, position().x, position().y) < radius()) return true;
    return false;
  }
  
};

PImage path;
PImage hotSpots;
PImage zoneMask;



void loadImages(){       
    path =     loadImage("trojan77_path.png");
    hotSpots = loadImage("trojan77_hotSpots.png");
    zoneMask = loadImage("trojan77_zoneMask.png");
}

void renderImages(){
  image(zoneMask,0,0);
  image(hotSpots,0,0);
  image(path,0,0);
}

void drawEllipses(){
fill(255,0,0);
ellipse(203,402,20,20);
ellipse(295,550,20,20);
ellipse(542,149,20,20);
ellipse(790,529,20,20);
}

