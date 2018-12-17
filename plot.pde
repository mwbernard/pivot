class Plot {
  //position and size
  PVector topLeft;
  float sideLength;
  //sprinkler object
  Sprinkler sprinkler;
  //used to deactivate plots when some are expanded
  Boolean activated;
  //plot background colors
  color[] colors = {color(166,145,80), color(177,157,94), color(186,168,111), color(194,178,128), color(202,188,145), color(211,199,162), color(219,209,180)};
  color plotColor;
  int plotNumber;
  
  //initializer
  Plot(PVector tr, float sl, int pN, int droughtLevel, int excessRain) {
    //set pos and size according to given values
    sideLength = sl;
    topLeft = tr;
    //create sprinkler  
    sprinkler = new Sprinkler(tr.x + sl/2, tr.y + sl/2, sl/2, droughtLevel, excessRain);
    activated = true;
    //get background color values
    float colorIndex = map(noise(topLeft.x,topLeft.y), 0.0, 1.0, 0, colors.length);
    plotColor = colors[int(colorIndex)];
    plotNumber = pN;
  }
  //draws the plot, and the sprinkler on top of it
  void showPlot() {
    if (activated) {
      fill(plotColor);
      noStroke();
      rect(topLeft.x, topLeft.y, sideLength, sideLength);
      sprinkler.waterPlants();
    }
    
  }
  //setter for new plot sizes
  void setSideLength(float newsl) {
   
    sideLength = newsl;
    sprinkler = new Sprinkler(topLeft.x + sideLength/2, topLeft.y + sideLength/2, sideLength/2, droughtLevel, excessRain);
  }
}
