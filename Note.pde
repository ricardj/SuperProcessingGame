class Note
{
    //Notes start at the bottom of the screen and go to the center. They stay there.
   public color noteColor = color(55);
   public PVector position = new PVector(width/2, height);
   public float radius = 20;
   public final PVector finalPosition = new PVector(width/2, height/2);
   public final float minimumActivationDistance = 5f;
   public boolean isFinalPosition = false;
   public final float lerpIntensity = 0.1;
   public int identifier;

   
   public Note(int identifier, color noteColor) 
   {
     this.identifier = identifier;
     this.noteColor = noteColor;
   }
   
   public void render(){
     noStroke();
     fill(noteColor);
     circle(position.x, position.y, radius * 2);
     position.x = lerp(position.x, finalPosition.x, lerpIntensity);
     position.y = lerp(position.y, finalPosition.y, lerpIntensity);
     
     isFinalPosition = PVector.dist(position, finalPosition) < minimumActivationDistance ? true : false;
   }
  
}
