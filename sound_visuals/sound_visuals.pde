import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import peasy.*;
import controlP5.*;

/******create instances of the neccessary classes******/
Minim        NewMinim;
AudioInput   NewInput;
FFT          NewFFT;
PeasyCam     NewPeasy;

/******define some global variables******/
float        LineColor    = 0.89;
float        SphereColor  = 0.55;
float        BGColor      = 1;
float        WaveColor    = 0.87;
float        PosY1        = 50;
float        PosY2        = 50;
float        SphereRadius = 400;
float        LineHeight   = 6;
float        LineWeight   = 1;

/******ControlP5******/
ControlP5 NewControl;
boolean ShowGUI = false;
Slider[] Sliders;
Button[] Buttons;

void setup()
{
  //size(displayWidth, displayHeight, P3D);
  size(1280, 1024, P3D);
 
  setupGUI();
  
  //initalize the peasycam to walk around the animation
  NewPeasy  = new PeasyCam(this, width/2, height/2, 0, 1000);
 
  //make a new instance from the Minim object, get input from linein, create new FFT
  NewMinim  = new Minim(this);
  NewInput  = NewMinim.getLineIn(NewMinim.STEREO, 256);
  NewFFT    = new FFT(NewInput.bufferSize(), NewInput.sampleRate());
}

void draw()
{
  //put the background color in the draw loop to delete the black spheres and to make the illusion that the
  //sphere is growing and shrinking
  background(linearColor(BGColor));
  
  //call this methode before anything else, because the gui is influenced by the P3D
  //if you call the drawGUI() at the end of the draw()-funtion, the gui is without any function
  drawGUI();
  
  strokeWeight(LineWeight);
  
  //use the FFT and the AudioPlayer to create the sphere
  NewFFT.forward(NewInput.mix);
  translate(width/2, height/2, -50);
  noFill();
  stroke(linearColor(SphereColor));
  sphere(NewInput.mix.get(1) * SphereRadius); 

  //generate the waves using the amplitudes of the left and right side in the stereo signal
  stroke(linearColor(WaveColor));
  for (int Counter = 0; Counter < NewInput.left.size() - 1; Counter++)
  {
    float PosX1 = map( Counter, 0, NewInput.bufferSize(), 0, width );
    float PosX2 = map( Counter + 1, 0, NewInput.bufferSize(), 0, width );
    
    line(PosX1, 0 + NewInput.left.get(Counter) * PosY1, PosX2, 0 + NewInput.left.get(Counter + 1) * PosY2); //PosY1
    line(-PosX1, 0 + NewInput.right.get(Counter) * PosY1, -PosX2, 0 + NewInput.right.get(Counter + 1) * PosY2); //PosY1
  }
  
  //generate the frequency spectrum using fft
  for(int Counter = 0; Counter < 0 + NewFFT.specSize() * 2; Counter++)
  {
    stroke(linearColor(LineColor));
    line(Counter, 0 , Counter, 0 - NewFFT.getBand(Counter) * LineHeight);
    line(Counter, 0 , Counter, 0 + NewFFT.getBand(Counter) * LineHeight);
    line(-Counter, 0, -Counter, 0 + NewFFT.getBand(Counter) * LineHeight);
    line(-Counter, 0, -Counter, 0 - NewFFT.getBand(Counter) * LineHeight);
  } 
}

//call some methods with the keys
void keyReleased()
{
  if(key == 'm' || key == 'M')
  {
    ShowGUI = NewControl.group("menu").isOpen();
    ShowGUI = !ShowGUI;
  }
  
  if(ShowGUI) NewControl.group("menu").open();
  else NewControl.group("menu").close();
  
}


color linearColor(float _Value)
{
  pushStyle();
  colorMode(HSB, 360, 100, 100, 100);
  
  float H        = (_Value) * 360;
  float S        = abs(sin((1 - _Value) * PI * 9)) * 60 + (1 - _Value) * 40;
  float B        = abs(cos((1 - _Value) * PI * 4.5)) * 60 + (_Value) * 40;
  color NewColor = color(H, S, B);
  
  popStyle();
  
  return NewColor;
}

void Reset()
{
  LineColor    = 0.89;
  SphereColor  = 0.55;
  BGColor      = 1;
  WaveColor    = 0.87;
  PosY1        = 50;
  PosY2        = 50;
  SphereRadius = 400;
  LineHeight   = 6;
  LineWeight   = 1;  
}

void stop()
{
  NewMinim.stop();
  super.stop();
}

