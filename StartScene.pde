class StartScene
{

 public float circleRadius;
 public float verticalCircles = 9;
 public float horizontalCircles=15;
 public float animationFrequency = 0.01;
 public float animationAmplitude = 10;
 public boolean pressStartVisible  = false;
 public float animationTimer = 0;
 public float animationPeriod = 0.5;
 public float prev = 0;
 
 public StartScene()
 {
   circleRadius = width/10;
 }
 
 
 void render()
 {
   background(color(87, 24, 69));
   noStroke();
   fill(color(144, 12, 62)); 
   for(int i = 0; i < horizontalCircles; i++)
   {
      for(int j = 0; j < verticalCircles; j++){
         
         float animatedRadius = circleRadius + sin(millis() *  animationFrequency + (i+1)*j*PI/15) * animationAmplitude;
         circle(circleRadius * i,circleRadius*j,animatedRadius);
      }
   }
   
   //Title of the ghame
   textSize(100);
    textAlign(CENTER);
    fill(255);
    textFont(TITLE_FONT);
    text("Eye Toy Dance Game",width/2, height/2);
    
    animationTimer += (millis() - prev)/1000;
    if(animationTimer > animationPeriod)
    {
      animationTimer = 0;
      pressStartVisible = !pressStartVisible;
    }
    prev = millis();
    
    
    if(pressStartVisible)
    {
      //Title of the ghame
      textSize(20);
      textAlign(CENTER);
      fill(255);
      textFont(TITLE_FONT);
      text("Press space",width/2, height/2 + 50);
    }
    
 }
 
 public void inputKeyDetected()
 {
     //Change from scene
     gameManager.startGame();
     currentScene = Scene.GameScene;
 }
  
}
