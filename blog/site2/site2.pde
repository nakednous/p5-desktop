PFont font;
MyRect dandelion, util, fpstiming, proscene, bias;
MyRect hover = proscene;

void setup() {
  size(496,327);
  //String[] fontList = PFont.list();
  //printArray(fontList);
  
  font = loadFont("NotoSans-22.vlw");
  //font = loadFont("FreeSans-16.vlw");
  textFont(font);
  
  proscene = new MyRect(0,0,480,270,"ProScene3","http://otrolado.info/projects/proscene");
  dandelion = new MyRect(20,40,430,210,"Dandelion","http://otrolado.info/projects/dandelion");
  fpstiming = new MyRect(240,80,180,150,"FPSTiming","http://otrolado.info/projects/fpstiming");
  bias = new MyRect(40,80,180,150,"BIAS","http://otrolado.info/projects/bias");
  util = new MyRect(60,120,100,80,"Util","https://github.com/remixlab/util_tree");
}

color colour(MyRect r) {
  if(hover == r)
    return color(0,0,255,255);
  else
    return color(255,255,255,125);
}

void draw() {
  background(255);
  
  updateHover();
  
  pushStyle();
  fill(colour(proscene));
  proscene.draw();
  popStyle();
  
  pushStyle();
  fill(colour(dandelion));
  dandelion.draw();
  popStyle();
  
  pushStyle();
  fill(colour(fpstiming));
  fpstiming.draw();
  popStyle();
  
  pushStyle();
  fill(colour(bias));
  bias.draw();
  popStyle();
  
  pushStyle();
  fill(colour(util));
  util.draw();
  popStyle();
}

void updateHover() {
  hover = null;
  if( util.hover() )
    hover = util;
  else if( bias.hover() )
    hover = bias;
  else if( fpstiming.hover() )
    hover = fpstiming;
  else if ( dandelion.hover() )
    hover = dandelion;
  else if ( proscene.hover() )
    hover = proscene;
}

void mouseClicked() {
  if( hover != null )
    if( hover != bias )
      link(hover.url);
}

public class MyRect {
  float a,b,w,h;
  String name;
  String url;
  
  MyRect(float _a, float _b, float _w, float _h, String _n, String _u) {
    a = _a;
    b = _b;
    w = _w;
    h = _h;
    name = _n;
    url = _u;
  }
  
  boolean hover() {
    return (mouseX > a  && mouseX < a+w) && (mouseY > b  && mouseY < b+h);
  }
  
  void draw() {
    pushStyle();
    stroke(0);
    strokeWeight(4);
    rect(a,b,w,h);
    fill(0);
    text(name, a+20, b+30);
    popStyle();
  }
} 