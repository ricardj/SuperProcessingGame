public class EyeToyEngine
{
   PImage prev;
   PImage mask;
   int threshold =25;  //mask threshold
   private ArrayList<EyeToyButton> eyeToyButtons;

   public EyeToyEngine()
   {
       prev = createImage(width, height, RGB);
       mask = createImage(width, height, RGB);
       eyeToyButtons = new ArrayList<EyeToyButton>();
   }
   
   
   public void update(Capture video)
   {
       for(EyeToyButton e : eyeToyButtons)
       {
          e.activationThreshold =0; 
       }
       generateMask(video);
       prev.copy(video, 0, 0, video.width, video.height, 0, 0, prev.width, prev.height);
       prev.updatePixels();   
   }
   public void render()
   {
     //image(mask,0,0,width,height);
     for(EyeToyButton e : eyeToyButtons)
     {
       e.render();
     }
     
   }
   
   
   public EyeToyButton createEyeToyButton()
   {
     EyeToyButton newEyeToyButton = new EyeToyButton();
     eyeToyButtons.add(newEyeToyButton);
     return newEyeToyButton;
   }
  
  color whiteColor = color(255);
  color blackColor = color(0);
  void generateMask(Capture video)
  {
    video.loadPixels();
    mask.loadPixels();
    for (int x = 0; x < video.width; x++ ) {
      for (int y = 0; y < video.height; y++ ) {
        int loc = x + y * video.width;
        // What is current color
        color currentColor = video.pixels[loc];
        float r1 = red(currentColor);
        float g1 = green(currentColor);
        float b1 = blue(currentColor);
        color prevColor = prev.pixels[loc];
        float r2 = red(prevColor);
        float g2 = green(prevColor);
        float b2 = blue(prevColor);

        float d = distSq(r1, g1, b1, r2, g2, b2); 

        if (d > threshold*threshold) {
          mask.pixels[loc] = whiteColor;
          //TODO: once decided that the color is white, we will check which buttons are affected by that
          for(EyeToyButton e: eyeToyButtons)
          {
             e.addActivationThreshold(x,y); 
          }
        } else {
          mask.pixels[loc] = blackColor;
        }
      }
      
    }
    mask.updatePixels();
  
  }

  float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
    float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
    return d;
  }
}
