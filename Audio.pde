import processing.sound.*;

SinOsc sine;
boolean panningEnabled = false;
boolean play = true;

void setup() {  
  sine = new SinOsc(this);
  sine.play();
  
  size(700, 400);
}

void mouseClicked() {
  panningEnabled = !panningEnabled;
}

void keyPressed(){
  if(key == ' '){
    if (play) {
      sine.stop(); 
    }
    else {
      sine.play();
    }
    play = !play;
  }
}

void draw() {
  background(255);
  line(350,400,350,20);
  line(0,200,680,200);
  fill(0);
  triangle(350,0,340,20,360,20);
  triangle(700,200,680,190,680,210);
  
  float freq = map(mouseY, height, 0, 200, 1000);
  float normalizedMouseX = float(mouseX) / float(width);
  
  sine.freq(freq);
  text("freq", 300, 25);
  if(panningEnabled) {
    text("panning", 620, 150);
    triangle(0,200,20,190,20,210);
    sine.pan(normalizedMouseX * 2 - 1);
  }
  else {
    text("amplitude", 620, 150);
    sine.amp(normalizedMouseX);
  }
}
