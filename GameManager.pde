public class GameManager implements EyeToyListener
{
  //The game manager every certain time spawns a button.
  //The button goes to a press area. If the button is pressed when it is in the area, then it adds puntuaction
  
  public float spawningPeriod = 6f;
  public float spawningTimer = 0;
  float lastTime;
  public color[] gameColors;
  ArrayList<Note> spawnedNotes;
  Note currentNote;
  
  
  //Punctuation stuff
  public float score;
  public float scoreColor = color(255); //white;
  public float scoreSize = 32;
  
  
  
  public GameManager()
  {
    lastTime = millis();
    spawnedNotes = new ArrayList<Note>();
    color(120, 10, 10);
    gameColors = new color[TOTAL_BUTTONS];
    gameColors[0] = color(0, 0, 150);
    gameColors[1] = color(255, 100, 0); //orange
    gameColors[2] = color(58, 103, 0); //yellow green
    gameColors[3] = color(120, 10, 10);
    
    score = 0;
  }
  
  public void eyeToyPressed(int identifier){
      //We get the identifier
      if(currentNote != null)
      {
        if(identifier == currentNote.identifier)
        {
          if(currentNote.isFinalPosition)
          {
            score += 10;
            currentNote = null;
            spawnedNotes.remove(0);
          }
        }
        //We check that is the current button in safe zone
        //if it is, we add punctuation and destroy button
     }
  }
  
  public void render()
  {
    float delta = millis() - lastTime;
    lastTime = millis();
    spawningTimer += delta/1000;
    if(spawningTimer > spawningPeriod)
    {
       spawningTimer = 0;
       spawnNote();
    }
    
    for(int i = 0; i < spawnedNotes.size(); i++)
    {
      spawnedNotes.get(i).render();
    }
    
    //We also render the punctuation
    textSize(scoreSize);
    textAlign(CENTER);
    fill(255);
    text(str(int(score)),width/2, height/2);
    
  }
  
  
  public void spawnNote()
  {
    //Create and add the spawn note to the list
    int randomNumber = int(random(0,TOTAL_BUTTONS));
    currentNote = new Note(randomNumber, gameColors[randomNumber]);
    spawnedNotes.add(currentNote);
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