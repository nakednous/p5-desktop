// global variables
// modes: 0 all figs; 1 ellipses; 2 rects; 3 tris; 4 array of ids
int mode;

ArrayList<Figure> figList;
HashMap<Integer, Polygon> polyDict;
// poly ids that will be drawn using the map
// add and remove ids as you wish, but bear in mind that
// since there are 40 Polygons ids should be between 0 and 39
int[] ids = {0, 10, 15, 20, 30, 39};

public void setup() {
  size(600, 600);
  figList = new ArrayList<Figure>();
  polyDict = new HashMap<Integer, Polygon>();
  for (int i = 1; i <= 20; i++)
    figList.add(new Ellipse());
  int id = 0;
  for (int i = 1; i <= 20; i++) {
    Rect r = new Rect();
    figList.add(r);
    polyDict.put(id++, r);
  }
  for (int i = 1; i <= 20; i++) {
    Triangle t = new Triangle();
    figList.add(t);
    polyDict.put(id++, t);
  }
}

public void draw() {
  background(0);
  switch (mode) {
  case 0:  
    for (Figure fig : figList)
      fig.display();
    break;
  case 1:  
    for (Figure fig : figList)
      if (fig instanceof Ellipse)
        fig.display();
    break;
  case 2:  
    for (Figure fig : figList)
      if (fig instanceof Rect)
        fig.display();
    break;
  case 3:  
    for (Figure fig : figList)
      if (fig instanceof Triangle)
        fig.display();
    break;
  case 4:
    for (int id : ids)
      polyDict.get(id).contour();
    break;
  }
}

public void keyPressed() {
  if (key == ' ')
    mode = mode < 4 ? mode+1 : 0;
}