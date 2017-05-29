class WordItem extends SimpleMapItem {
  String word;
  int source;
  int count;
  int maxCount;

  float textPadding = 8;

  float wide;
  float high;

  color c, d;
  float hue;

  PFont f;

  float xp, yp, wp, hp, countp, maxCountp;
  float x0, y0, w0, h0, count0, maxCount0;

  WordItem next;

  WordItem(String word, int c, int s) {
    this.word = word;
    this.count = c;
    this.source = s;
    this.next = null;
  }

  void updateColors(int count) {
    if (source == NYT_SOURCE) {
      hue = map((float)size, 0, (float)maxCount, 180, 240);
    }
    else if (source == KWD_SOURCE) {
      hue = map((float)size, 0, (float)maxCount, 300, 360);
    }
    colorMode(HSB, 360, 100, 100);
    c = color(hue, 75, 75);
  }

  void draw() {

    float x1, y1, w1, h1;
    float count1, maxCount1;   
    int fontSize;

    x0 = x;
    y0 = y;
    w0 = w;
    h0 = h;
    count0 = count;
    maxCount0 = maxCount;

    fontSize = (int) map(countp, 2, maxCountp, 0, fonts.length - 1);


    if (mouseInside()) {
      d = color(255);
      rolloverItem = this;
      f = createFont("SansSerif.bold", fontSize + 8);
      textFont(f);
    }
    else {
      d = c;
      textFont(fonts[fontSize]);
    }

    if (next != null) {
      // Interpolando posicion del item entre el mapa actual
      // y el siguiente. Para ello utilizamos la variable
      // global animFactor que va entre 0 y 1.
      
      x1 = next.x;
      y1 = next.y;
      w1 = next.w;
      h1 = next.h;
      count1 = next.count;
      maxCount1 = next.maxCount;

      if (space) {
        if (a < 0) {
          xp = x1 + (x0 - x1) * animFactor;
          yp = y1 + (y0 - y1) * animFactor;
          //countp = countp;
          //maxCountp = maxCountp;
          countp = count0 + (count1 - count0) * (animFactor);
          maxCountp = maxCount0 + (maxCount1 - maxCount0) * (animFactor);
        }
        else {
          xp = x0 + (x1 - x0) * animFactor;
          yp = y0 + (y1 - y0) * animFactor;
          countp = count0 + (count1 - count0) * (animFactor);
          maxCountp = maxCount0 + (maxCount1 - maxCount0) * (animFactor);
        }
      }
    } 
    else {
      xp = x0;
      yp = y0;
      wp = w0;
      hp = h0;
      countp = count0;
      maxCountp = maxCount0;
    }
    drawTitle(d);
  }


  void drawTitle(color d) {
    fill(d);    

    text(word, xp + textPadding, yp + high);
    wide = textWidth(word);
    high = textAscent() + textDescent();
  }


  boolean mouseInside() {
    return (mouseX > xp + textPadding && mouseX < (xp + textPadding + wide) && mouseY < yp + high && mouseY > yp);
  }

  void setMaxWords(int maxc) {
    this.maxCount = maxc;
  }

  void setColor(color cl) {
    this.d = cl;
  }

  void connectWidth(WordItem it) {
    this.next = it;
  }

  String getWord() {
    return this.word;
  }

  color getColor() {
    return this.c;
  }

  double getSize() {
    return this.size;
  }

  int getCount() {
    return this.count;
  }

  int getSource() {
    return this.source;
  }
}

