public class EndScene
{
  
 public EndScene()
 {
   
 }
 public float animationFrequency = 0.008;
 public float animationAmplitude = 10;
 public void render()
 {
    background(color(87, 24, 69));
    textFont(TITLE_FONT);
    rectMode(CENTER); 
    textSize(59);
    textAlign(CENTER);
    fill(255);
    text("Score",width/2, height/2 - 80);
    //We also render the punctuation
    
    textAlign(CENTER);
    fill(255);

    textSize(100 + sin(millis() * animationFrequency) * animationAmplitude);
    if(previousScene == Scene.SequenceScene){
      text(str(int(sequenceManager.score)),width/2, height/2 + 40);
    }else{
      text(str(int(gameManager.score)),width/2, height/2 + 40);
    }
 }
  public void inputKeyDetected()
  {
     currentScene = Scene.StartScene; 
  }
  
}
