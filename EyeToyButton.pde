
public static int globalIdentifier = 0;
class EyeToyButton
{
  public ArrayList<EyeToyListener> eyeToyListeners;
 
  public PVector position;
  float radius = 20;
  float halfRadius;
  public color buttonColor = color(0,255,0);
  public color strokeColor;
  public float thresholdDetection;
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
     setRadius(20);
  }
  
  public void setRadius(float radius)
  {
    this.radius = radius;
    pixelArea = 1;//PI * radius *radius;
    thresholdDetection = PI * radius *radius /100;
  }
  
  boolean pressing = false;
  float animationFrequency = 0.003;
  float animationAmplitude = 3;
  public void render()
  {
    noStroke();
    fill(buttonColor);
    //We ami,ate the radius
    float animatedRadius = radius +  sin(millis() * animationFrequency + PI/4*identifier) * animationAmplitude;
    circle(position.x, position.y, animatedRadius * 2);
    
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
