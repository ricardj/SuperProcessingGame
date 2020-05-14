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
  public float buttonOffset = 95;
  public float buttonWidth = 421/2.3;
  public float buttonHeight= 86/2.3;
  
  //Click button detection
  public float y1;
  public float y2;
  public float xLvl1_min;
  public float xLvl1_max;
  public float xLvl2_min;
  public float xLvl2_max;
  public float xExit_min;
  public float xExit_max;


  public PImage level1;
  public PImage level2;
  public PImage exit;

  public StartScene()
  {
    circleRadius = width/10;
    level1 = loadImage("Level_1.png");
    level2 = loadImage("Level_2.png");
    exit = loadImage("Exit.png");
     y1 = height/2 + buttonOffset - buttonHeight/2;
     y2 = height/2 + buttonOffset + buttonHeight/2;
     xLvl1_min = width/3 - (width/3)/2 - buttonWidth/2;
     xLvl1_max  = width/3 - (width/3)/2 + buttonWidth/2;
     xLvl2_min = (width/3) * 2 - (width/3)/2 - buttonWidth/2;
     xLvl2_max = (width/3) * 2 - (width/3)/2 + buttonWidth/2;
     xExit_min = width - (width/3)/2 - buttonWidth/2;
     xExit_max = width - (width/3)/2 + buttonWidth/2;
    

  }


  void render()
  {
    background(color(87, 24, 69));
    noStroke();
    fill(color(144, 12, 62)); 
    for (int i = 0; i < horizontalCircles; i++)
    {
      for (int j = 0; j < verticalCircles; j++) {

        float animatedRadius = circleRadius + sin(millis() *  animationFrequency + (i+1)*j*PI/15) * animationAmplitude;
        circle(circleRadius * i, circleRadius*j, animatedRadius);
      }
    }

    //Title of the ghame
    textSize(100);
    textAlign(CENTER);
    fill(255);
    textFont(TITLE_FONT);
    text("Eye Toy Dance Game", width/2, height/2);

/*
    animationTimer += (millis() - prev)/1000;
    if (animationTimer > animationPeriod)
    {
      animationTimer = 0;
      pressStartVisible = !pressStartVisible;
    }
    prev = millis();


    if (pressStartVisible)
    {
      //Title of the ghame
      textSize(20);
      textAlign(CENTER);
      fill(255);
      textFont(TITLE_FONT);
      text("Press space", width/2, height/2 + 50);
    }
*/
    //We draw the buttons
    imageMode(CENTER);
    image(level1, width/3 - (width/3)/2, height/2 + buttonOffset, buttonWidth, buttonHeight);
    image(level2, (width/3) * 2 - (width/3)/2, height/2 + buttonOffset, buttonWidth, buttonHeight);
    image(exit, width - (width/3)/2, height/2 + buttonOffset, buttonWidth, buttonHeight);
     imageMode(CORNER);

    //We check pressint those buttons
    if (mousePressed == true) {
      //Level1
      if ( y1 < mouseY && mouseY < y2 && xLvl1_min < mouseX && mouseX < xLvl1_max) {
        currentScene = Scene.GameScene;
        gameManager.startGame();
      }

      //Level2
      if ( y1 < mouseY && mouseY < y2 && xLvl2_min < mouseX && mouseX < xLvl2_max) {
        currentScene = Scene.SequenceScene;
      }

      //Exit
      if ( y1 < mouseY && mouseY < y2 && xExit_min < mouseX && mouseX < xExit_max) {
        exit();
      }
    }
  }

  public void inputKeyDetected()
  {
    //Change from scene
    gameManager.startGame();
    currentScene = Scene.GameScene;
  }
}
