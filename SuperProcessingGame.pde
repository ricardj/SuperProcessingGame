import processing.video.*;

Capture video;
EyeToyEngine eyeToyEngine;
EyeToyButton myEyeToyButton;


void setup() {
  size(640, 360);
  video = new Capture(this, 640, 360, 30);
  video.start();
  
  eyeToyEngine = new EyeToyEngine();
  myEyeToyButton = eyeToyEngine.createEyeToyButton();
  myEyeToyButton.addListener(new EyeToyListener(){
    public void eyeToyPressed()
    {
      println("Hello there. Han pulsado el botón.");
    }
  });
  myEyeToyButton.position.x = 30;
  
}

void captureEvent(Capture video) { 
  video.read();
  eyeToyEngine.update(video);
}

void draw() {
  background(0);
  image(video, 0 ,0 ,640,360);
  eyeToyEngine.render();
  
}
