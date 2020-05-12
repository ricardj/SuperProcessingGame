
import processing.video.*;
import processing.sound.*;

final int TOTAL_BUTTONS = 4;
PFont TITLE_FONT;


//We setup the scenes of our game
public enum Scene {StartScene, GameScene, EndScene};
public Scene currentScene = Scene.GameScene;
public StartScene startScene;

//WE setup the engine of the game
Capture video;
EyeToyEngine eyeToyEngine;
GameManager gameManager;

//We load the main song of our game
SoundFile soundFile;

//The eye toy buttons of the game
ArrayList<EyeToyButton> eyeToyButtons;


void setup() {
  
  //We activate the webcam
  size(640, 360);
  
  //We load the soundfile
  soundFile = new SoundFile(this, "Alan Walker - Alone.mp3");
  soundFile.loop();
  
  //The main font
  TITLE_FONT = createFont("Gamegirl.ttf",32);
  
  //The video
  video = new Capture(this, 640, 360, 30);
  video.start();
  
  startScene = new StartScene();
  
  gameManager = new GameManager();
  
  //We create the four buttons
  eyeToyEngine = new EyeToyEngine();
  CreateEyeToyButtons();
}

void captureEvent(Capture video) {
  if(video != null)
  {
    video.read();

    eyeToyEngine.update(video);
  }
}


void draw() {
  switch(currentScene)
  {
     //StartScene, GameScene, EndScene
     case StartScene:
       startScene.render();
     break;
     
     case GameScene:
       //Playing song, button aparition and puntuation
       background(0);
       image(video, 0 ,0 ,640,360);
       eyeToyEngine.render();
       gameManager.render();
     break;
     
     case EndScene:
       //WE would render the puntuation of the player
       //Restart to the start screen
     break;
    
  }
}


public void CreateEyeToyButtons()
{

  
  eyeToyButtons = new ArrayList<EyeToyButton>();
  for(int i = 0; i < TOTAL_BUTTONS; i++)
  {
     EyeToyButton myEyeToyButton = eyeToyEngine.createEyeToyButton();
     myEyeToyButton.addListener(new EyeToyListener(){
        public void eyeToyPressed(int identifier)
        {
          println("Han pulsado el botón " +  str(identifier));
        }
     });
     myEyeToyButton.addListener(gameManager);
     myEyeToyButton.buttonColor = gameManager.gameColors[i];
     myEyeToyButton.setRadius(20);
     eyeToyButtons.add(myEyeToyButton);
  }
  
  
  float lateralPadding = 30;
  float verticalPadding = 30;
  float upButtonsSeparation = 100;
  
  eyeToyButtons.get(0).position = new PVector(lateralPadding, height/2);
  eyeToyButtons.get(1).position = new PVector(lateralPadding, verticalPadding);
  eyeToyButtons.get(2).position = new PVector(width - lateralPadding, verticalPadding);
  eyeToyButtons.get(3).position = new PVector(width - lateralPadding, height/2);

  
}
