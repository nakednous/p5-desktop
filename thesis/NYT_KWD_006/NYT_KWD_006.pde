// NYT-KWD version 005
// Cambios:
// * cambio entre meses manual (botones RIGHT & LEFT)
// * control de la cantidad de palabras a dibujar (botones UP & DOWN)
// * pausar animación (barra espaciadora)
// * acelerar/ralentizar animación (botones '+' & '-')
// * resaltar palabra seleccionada para contrastarla en la otra fuente

import treemap.*;

int MAX_WORDS_COUNT = 100;
float WORDS_FRACTION = 1;
boolean space = true;


String[][] AVAILABLE_MONTHS = { {"2004", "1"}, {"2004", "2"}, {"2004", "3"}, {"2004", "4"}, {"2004", "5"}, {"2004", "6"}, {"2004", "7"}, {"2004", "8"}, {"2004", "9"}, {"2004", "10"}, {"2004", "11"}, {"2004", "12"},
                                {"2005", "1"}, {"2005", "2"}, {"2005", "3"}, {"2005", "4"}, {"2005", "5"}, {"2005", "6"}, {"2005", "7"}, {"2005", "8"}, {"2005", "9"}, {"2005", "10"}, {"2005", "11"}, {"2005", "12"},
                                {"2006", "1"}, {"2006", "2"}, {"2006", "3"}, {"2006", "4"}, {"2006", "5"}, {"2006", "6"}, {"2006", "7"}, {"2006", "8"}, {"2006", "9"}, {"2006", "10"}, {"2006", "11"}, {"2006", "12"},
                                {"2007", "1"}, {"2007", "2"}, {"2007", "3"}, {"2007", "4"}, {"2007", "5"}, {"2007", "6"}, {"2007", "7"}, {"2007", "8"}, {"2007", "9"}, {"2007", "10"}, {"2007", "11"}, {"2007", "12"},                                                            
                                {"2008", "1"}, {"2008", "2"}, {"2008", "3"}, {"2008", "4"}, {"2008", "5"}, {"2008", "6"}, {"2008", "7"}, {"2008", "8"}, {"2008", "9"}, {"2008", "10"}, {"2008", "11"}, {"2008", "12"},                              
                                {"2009", "1"}, {"2009", "2"}, {"2009", "3"}, {"2009", "4"}, {"2009", "5"}, {"2009", "6"}, {"2009", "7"}, {"2009", "8"}, {"2009", "9"}, {"2009", "10"}, {"2009", "11"}, {"2009", "12"}
                              };

float SECONDS_PER_MONTH = 10.0;

int NYT_SOURCE = 1;
int KWD_SOURCE = 2;

PFont fonts[];
PFont font;

WordMap[] wmNYT, wmKWD;
CustomTreemap[] mapNYT, mapKWD;
int mapIndex;
float animFactor;
int lastTime;
int t;
float speed = 1;
int a = 1;

WordItem rolloverItem;

void setup() {
  size(1024, 600);
  smooth();

  font = loadFont("AgencyFB-Reg-48.vlw");

  frameRate(30);
  colorMode(RGB, 255);
  stroke(255);
  strokeWeight(1);

  println("Please wait. Generating fonts...");
  fonts = new PFont[20];
  for (int i = 1; i <= 20; i++) {  
    fonts[i - 1] = createFont("SansSerif", 5 + i);
  }
  println("Done.");    

  println("Please wait. Loading data...");
  int n = AVAILABLE_MONTHS.length;
  wmNYT = new WordMap[n];
  wmKWD = new WordMap[n];
  mapNYT = new CustomTreemap[n];
  mapKWD = new CustomTreemap[n];  

  for (int i = 0; i < n; i++) {
    String fileNYT = "nyt-" + AVAILABLE_MONTHS[i][0] + "-" + AVAILABLE_MONTHS[i][1] + ".txt";
    String fileKWD = "kwd-" + AVAILABLE_MONTHS[i][0] + "-" + AVAILABLE_MONTHS[i][1] + ".txt";

    String[] linesNYT = loadStrings(fileNYT);
    wmNYT[i] = new WordMap(linesNYT, NYT_SOURCE, WORDS_FRACTION, MAX_WORDS_COUNT);
    wmNYT[i].updateColors();    
    mapNYT[i] = new CustomTreemap(wmNYT[i], 0, 0, width/2, height);


    String[] linesKWD = loadStrings(fileKWD); 
    wmKWD[i] = new WordMap(linesKWD, KWD_SOURCE, WORDS_FRACTION, MAX_WORDS_COUNT);
    wmKWD[i].updateColors();
    mapKWD[i] = new CustomTreemap(wmKWD[i], width/2, 0, (width/2)-1, height-1);
  }  
  println("Done.");  

  println("Please wait. Generating animation...");
  // Ahora, conectando items entre mapas consecutivos.
  for (int i = 0; i < n - 1; i++) {
    wmNYT[i].connectWith(wmNYT[i + 1]);
    wmKWD[i].connectWith(wmKWD[i + 1]);
  }
  println("Done."); 

  mapIndex = 0;
  lastTime = millis();
  animFactor = 0.1;
}

void draw() {
  background(0);
  rolloverItem = null;

  t = millis();
  animFactor = (t - lastTime)*speed / (SECONDS_PER_MONTH * 1000);

  if (1 <= animFactor) {
    lastTime = t;
    a = a*(-1);
  }

  mapNYT[mapIndex].draw();
  mapKWD[mapIndex].draw();

  if (rolloverItem != null) {
    contrastEqualWords();
  }

  fill(255);
  textFont(fonts[15]);
  text(AVAILABLE_MONTHS[mapIndex][0] + "." + AVAILABLE_MONTHS[mapIndex][1], 10, 30);
}

void contrastEqualWords() {
  if(rolloverItem.getSource() == 1) {
    wmKWD[mapIndex].findWord(rolloverItem.getWord());    
  }
  else {
    wmNYT[mapIndex].findWord(rolloverItem.getWord());
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (MAX_WORDS_COUNT < 100) {
        MAX_WORDS_COUNT +=1;
      }
    }
    else if (keyCode ==DOWN) {
      if (MAX_WORDS_COUNT > 1) {
        MAX_WORDS_COUNT -=1;
      }
    }
    if (keyCode == RIGHT) {
      if (mapIndex == AVAILABLE_MONTHS.length - 1) {
        mapIndex = 0;
      }
      else {
        mapIndex++;
      }
    }
    else if (keyCode == LEFT) {
      if (mapIndex == 0) {
        mapIndex = AVAILABLE_MONTHS.length - 1;
      }
      else {
        mapIndex--;
      }
    }
  }
  if (key == '+') {
    speed += 0.5;
  }
  else if (key == '-') {
    if (speed > 0.5) {
      speed -= 0.5;
    }
  }
  else if (key == ' ') {
    if (space == true) {
      space = false;
    }
    else {
      space = true;
    }
  }
}

