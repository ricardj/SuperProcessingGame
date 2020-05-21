public class MusicManager
{
  SoundFile soundFile;
  ArrayList<SoundFile> songs;
  boolean musicPlaying = false;
  public PApplet papplet;
  
  public MusicManager(PApplet papplet)
  {
    this.papplet = papplet;
    songs = new ArrayList<SoundFile>();
    songs.add(new SoundFile(papplet,"HighwayToHell.mp3"));
    //songs.add(new SoundFile(papplet,"Alan Walker - Alone.mp3"));
    //songs.add(new SoundFile(papplet,"AvengersTheme.mp3")); 
  }
  
  public void render()
  {
    switch(currentScene)
    {
       case SequenceScene:
       case GameScene:
          if(!musicPlaying)
          {
            soundFile = generateRandomSong();
            soundFile.loop();
            musicPlaying = true;
          }
       break;
       
       case EndScene:
         if(musicPlaying)
         {
            soundFile.stop();
            musicPlaying = false;
         }
       break;
    }
  }
  
  public SoundFile generateRandomSong()
  {
    int randomNumber = (int)random(0,songs.size() - 1);
    return songs.get(randomNumber);
  }
  
}
