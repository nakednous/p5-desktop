class CustomTreemap
{
  private MapModel model;
  private MapLayout algorithm;
  private Rect bounds;
  
  public CustomTreemap(MapModel model, double x, double y, double w, double h) {
    this.model = model; 
    this.algorithm = new PivotBySplitSize();
    updateLayout(x, y, w, h);
  }

  public void setLayout(MapLayout algorithm) {
    this.algorithm = algorithm;
  }
  
  public void updateLayout() {
    algorithm.layout(model, bounds);
  }
  
  public void updateLayout(double x, double y, double w, double h) {
    bounds = new Rect(x, y, w, h);
    updateLayout();
  }
  
  public void draw() {
    Mappable[] items = model.getItems();
    int len = min(items.length, MAX_WORDS_COUNT);
    for (int i = 0; i < len; i++) {
      items[i].draw();
    }
  }
}

