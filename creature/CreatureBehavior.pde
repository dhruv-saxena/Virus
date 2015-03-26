interface CreatureBehavior {
  
  public void event(int x, int y);
 
  public void event(int c);  
  
  public void update(float dt);
  
  public void add(Creature c);
  
}

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
