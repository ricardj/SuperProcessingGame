public class SequenceManager implements EyeToyListener
{
  public PVector[][] startPositions;
  
  //The game manager every certain time spawns a button.
  //The button goes to a press area. If the button is pressed when it is in the area, then it adds puntuaction 
  public float spawningPeriod = 6f;
  public float decreasingThreshold = 0.2;
  public float minimumThreshold = 1f;
  public float spawningTimer = 0;
  float lastTime;
  public color[] gameColors;
  ArrayList<Note> spawnedNotes;
  Note currentNote;
  
  
  //Punctuation stuff
  public float score;
  public float scoreColor = color(255); //white;
  public float scoreSize = 60;
  
  public int lives = 3;
  
  //Render sequence
    public float spaceInterval = 50;

  
  //Some sounds
  
  
  
  public SequenceManager()
  {
    lastTime = millis();
    spawnedNotes = new ArrayList<Note>();
    color(120, 10, 10);
    gameColors = new color[TOTAL_BUTTONS];
    gameColors[0] = color(0, 0, 255);
    gameColors[1] = color(234, 225, 0);//orange
    gameColors[2] = color(0, 255, 0); //yellow green
    gameColors[3] = color(255, 0, 0);
    
    score = 0;
    
    startPositions = new PVector[3][4];
    
    //Creating start position possibilities
    for(int i = 0; i < 3; i++)
    {
      for(int j = 3; j >= 0; j--){
        switch(i){
          //First position
          case 0:
            startPositions[0][j] = new PVector(0 + (j * spaceInterval),height/2);
          break;
          case 1:
            startPositions[1][j] = new PVector(width - ((2-j) * spaceInterval),height/2);
          break;
          case 2:
            startPositions[2][j] = new PVector(width/2 + ((j - 1) * spaceInterval),height/2);
          break;
        }
      }
    }
    
    /*startPositions[0] = new PVector(0,height/2);
    startPositions[1] = new PVector(width, height/2);
    startPositions[2] = new PVector(width/2, height);*/
  }
  
  public void eyeToyPressed(int identifier){
    
    if(currentScene == Scene.SequenceScene){
    
      //We get the identifier
      if(spawnedNotes.size() != 0){
        if(identifier == spawnedNotes.get(0).identifier)
        {
          if(spawnedNotes.get(0).isFinalPosition)
          {
            score += 10;
            destroyNote();
          }
        }
      }
    }
        //We check that is the current button in safe zone
        //if it is, we add punctuation and destroy button
  }
  
  public void render()
  {
    float delta = millis() - lastTime;
    lastTime = millis();
    spawningTimer += delta/1000;
    if(spawningTimer > spawningPeriod)
    {
       if(spawnedNotes.size() != 0){
         lives--;
         println("lives " + lives);
         int currentSize = spawnedNotes.size();
         for(int i = 0; i < currentSize; i++){
           if (score > 0) score -= 10;
           destroyNote();
         }
       }
       spawningTimer = 0;
       spawningPeriod -= spawningPeriod > minimumThreshold ? decreasingThreshold : 0;
       int randomPosition = int(random(0,3));
       spawnNote(0, randomPosition);
       spawnNote(1, randomPosition);
       spawnNote(2, randomPosition);
    }
    
    for(int i = 0; i < spawnedNotes.size(); i++)
    {
      spawnedNotes.get(i).render();
    }
    
    //We also render the punctuation
    textSize(scoreSize);
    textAlign(CENTER);
    fill(255);
    textFont(TITLE_FONT);
    text(str(int(score)),width/2, 40);
    
    //And the lives
    String livesText = "";
    for (int i = 0; i < lives; i++)
    {
      livesText += "I";
    }
    text(livesText,width/2, 80);
    
  }
  
  
  public void spawnNote(int index, int anotherRandomNumber)
  {
    //Create and add the spawn note to the list
    if(lives==0) 
    {
      currentScene = Scene.EndScene;
      previousScene = Scene.SequenceScene;
    }
    int randomNumber = int(random(0,TOTAL_BUTTONS));
    currentNote = new Note(randomNumber, gameColors[randomNumber], new PVector(startPositions[anotherRandomNumber][index].x, height/2));
    currentNote.position.set(startPositions[anotherRandomNumber][index]);
    spawnedNotes.add(currentNote);
  }
  
  public void destroyNote()
  {
    currentNote = null;
    if(spawnedNotes.size() > 0)
    {
      spawnedNotes.remove(0);
    }
  }
  
  public void startGame()
  {
    destroyNote();
     lives = 3;
     score = 0;
     spawningPeriod = 6;
     spawningTimer = 0;
    
  }
  
}

/*
//Some colors
  rectCol[1] = color(255); //white
  rectCol[2] = color(46, 11, 11); //brown
  rectCol[3] = color(120, 10, 10); // dark red
  rectCol[4] = color(255, 0, 0); //red
  rectCol[5] = color(250, 71, 74); // light red
  rectCol[6] = color(245, 59, 255); //pinkish
  rectCol[7] = color(232, 0, 245); // pink
  rectCol[8] = color(129, 3, 137); //purple
  rectCol[9] = color(55, 55, 250); //light blue
  rectCol[10] = color(0, 0, 255); //blue
  rectCol[11] = color(0, 0, 150); //dark blue
  rectCol[12] = color(95, 247, 101); //light green
  rectCol[13] = color(0, 247, 10); //lime green
  rectCol[14] = color(0, 103, 4); //dark green
  rectCol[15] = color(58, 103, 0); //yellow green
  rectCol[16] = color(255, 255, 0); //yellow
  rectCol[17] = color(255, 100, 0); //orange
  rectCol[18] = color(155); // gray
  rectCol[19] = color(55); //grayer/*


*/
