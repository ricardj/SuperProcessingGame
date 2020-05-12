
public static int globalIdentifier = 0;
class EyeToyButton
{
  public ArrayList<EyeToyListener> eyeToyListeners;
 
  public PVector position;
  float radius = 20;
  float halfRadius;
  public color buttonColor = color(0,255,0);
  public color strokeColor;
  public float thresholdDetection = 10;
  public float activationThreshold;
  float pixelArea;
  
  
  
  public int identifier;
  
  public EyeToyButton()
  {
    identifier = globalIdentifier;
    globalIdentifier++;
     position = new PVector(width/2, height/2);
     eyeToyListeners = new ArrayList<EyeToyListener>();
     buttonColor = color(0,255,0);
  }
  
  public void setRadius(float radius)
  {
    this.radius = radius;
    pixelArea = PI * radius *radius;
    thresholdDetection = pixelArea /2;
  }
  
  boolean pressing = false;
  public void render()
  {
    noStroke();
    fill(buttonColor);
    circle(position.x, position.y, radius * 2);
    
    //TODO: With the render we asume also update?
    if(activationThreshold >= thresholdDetection && !pressing){
       for(EyeToyListener e: eyeToyListeners)
       {
          e.eyeToyPressed(identifier); 
       }
       pressing = true;
    }else
    {
      if( activationThreshold < thresholdDetection) pressing = false;
    }
    
  }
  public void addListener(EyeToyListener eyeToyListener)
  {
    eyeToyListeners.add(eyeToyListener);
  }
  
  public void addActivationThreshold(int x, int y)
  {
    
     activationThreshold += ((x - position.x)*(x - position.x) + (y - position.y) *  (y - position.y)) < radius*radius ? 1/pixelArea : 0;  
  }
  
}