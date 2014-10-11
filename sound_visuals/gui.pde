void setupGUI()
{
  color ActiveColor = color(0, 130, 164);
  NewControl        = new ControlP5(this);
  NewControl.setAutoDraw(false);
  NewControl.setColorActive(ActiveColor);
  NewControl.setColorBackground(color(170));
  NewControl.setColorForeground(color(50));
  NewControl.setColorLabel(color(50));
  NewControl.setColorValue(color(255));
  
  ControlGroup Group = NewControl.addGroup("menu", 15, 25, 35);//-740, -580
  Group.setColorLabel(color(255));
  Group.close();
 
  Sliders = new Slider[10];
  Buttons = new Button[2];

  int Left          = 0;
  int Top           = 5;
  int Length        = 300;

  int SliderCounter = 0;
  int ButtonCounter = 0;
  int PosY          = 0; 
 
  Sliders[SliderCounter++] = NewControl.addSlider("LineColor", 0, 1, Left, Top + PosY, Length, 15);
  Sliders[SliderCounter++] = NewControl.addSlider("SphereColor", 0, 1, Left, Top + PosY + 20, Length, 15);
  Sliders[SliderCounter++] = NewControl.addSlider("BGColor", 0, 1, Left, Top + PosY + 40, Length, 15);
  Sliders[SliderCounter++] = NewControl.addSlider("WaveColor", 0, 1, Left, Top + PosY + 60, Length, 15);
  Sliders[SliderCounter++] = NewControl.addSlider("PosY1", 0, 500, Left, Top + PosY + 80, Length, 15);
  Sliders[SliderCounter++] = NewControl.addSlider("PosY2", 0, 500, Left, Top + PosY + 100, Length, 15);
  Sliders[SliderCounter++] = NewControl.addSlider("SphereRadius", 0, 1000, Left, Top + PosY + 120, Length, 15);
  Sliders[SliderCounter++] = NewControl.addSlider("LineHeight", 0, 20, Left, Top + PosY + 140, Length, 15);
  Sliders[SliderCounter++] = NewControl.addSlider("LineWeight", 1, 10, Left, Top + PosY + 160, Length, 15);
  
  Buttons[ButtonCounter++]     = NewControl.addButton("Reset", 0, Left, Top + PosY + 180, 30, 15);
  
  for(int Counter = 0; Counter < SliderCounter; Counter++)
  {
    Sliders[Counter].setGroup(Group);
    Sliders[Counter].captionLabel().toUpperCase(true);
    Sliders[Counter].captionLabel().style().padding(4, 3, 3, 3);
    Sliders[Counter].captionLabel().style().marginTop   = -4;
    Sliders[Counter].captionLabel().style().marginLeft  = 0;
    Sliders[Counter].captionLabel().style().marginRight = -14;
    Sliders[Counter].captionLabel().setColorBackground(0x99ffffff);
  } 
  
  for(int Counter = 0; Counter < ButtonCounter; Counter++)
  {
    Buttons[Counter].setGroup(Group); 
  }
}

void drawGUI()
{
  hint(DISABLE_DEPTH_TEST);
  NewPeasy.beginHUD();
  NewControl.show();
  NewControl.draw();
  NewPeasy.endHUD();
  hint(ENABLE_DEPTH_TEST);
}


