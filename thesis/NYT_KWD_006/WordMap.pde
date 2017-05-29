class WordMap extends SimpleMapModel { 

  int maxWordsPerItem;
  float per;

  WordMap(String [] lines, int source, float p, int maxw) {

    float l = min(lines.length * p, maxw);
    items = new WordItem[(int)l];

    maxWordsPerItem = 0;
    for (int i = 0; i < (int)l; i++) {      
      String[] values = split(lines[i], '\t');
      int wc = Integer.valueOf(values[1]);
      WordItem item = new WordItem(values[0], wc, source);
      item.setSize(wc);
      items[i] = item;
      maxWordsPerItem = max(maxWordsPerItem, wc);
    }
    updateMaxWordsPerItem(maxWordsPerItem);
  }


  void updateColors() {
    WordItem it;
    for (int i = 0; i < items.length; i++) {
      it = (WordItem) items[i];
      it.updateColors(getItemCount());
    }
  }

  void updateMaxWordsPerItem(int maxw) {
    WordItem it;
    for (int i = 0; i < items.length; i++) {
      it = (WordItem) items[i];
      it.setMaxWords(maxw);
    }
  }

  int getItemCount() {
    return items.length;
  }

  WordItem findItem(String word) {
    WordItem it;
    for (int i = 0; i < items.length; i++) {
      it = (WordItem) items[i];
      if (it.getWord().equals(word)) {
        return it;
      }
    }
    return null;
  }

  void findWord(String word) {
    WordItem it;
    for (int i = 0; i < items.length; i++) {
      it = (WordItem) items[i];
      if (it.getWord().equals(word)) {
        color newColor = color(255);
        it.drawTitle(newColor);
        break;
      }
    }
  }  

  void connectWith(WordMap wm) {
    WordItem it0, it1;
    for (int i = 0; i < items.length; i++) {
      it0 = (WordItem) items[i]; 
      it1 = wm.findItem(it0.getWord());      
      it0.connectWidth(it1);
      //println("Connecting " + it0 + " width " + it1);
    }
  }
}

