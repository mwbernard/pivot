class Sprinkler {
  
  //position and radius
  float cx, cy, radius;
  //colors
  color plotColor;
  color secondaryColor;
  color[] colors = {color(166,145,80),color(177,157,94),color(186,168,111),color(194,178,128),color(202,188,145),color(211,199,162),color(219,209,180),color(219,202,105),color(189,208,156),color(71,75,22),color(58,75,22),color(75,78,25),color(62,78,25),color(133,141,17),color(102,141,60),color(44,56,16),color(154,164,20),color(64,79,36)};
  //pattern values
  int numRings;
  int numStripes;
  float angle;
  float pattern;
  float orientation;
  //noise variables
  float noiseMod = 1;
  int droughtLevel;
  int excessRain;
  
  //initializer 
  Sprinkler(float px, float py, float r, int dL, int eR) {
    //set pos and radius to given values
    cx = px;
    cy = py;
    radius = r;
    droughtLevel = dL;
    excessRain = eR;
    
    //set colors
    float colorIndex = map(noise(cx,cy) * noiseMod, 0.0, 1.0, excessRain, colors.length - droughtLevel);
    plotColor = colors[int(colorIndex)];
    if (colorIndex < colors.length-1) {
      secondaryColor = colors[int(colorIndex)+1];
    } else {
      secondaryColor = colors[int(colorIndex)-1]; 
    }
    
    //set random pattern values
    pattern = random(1);
    orientation = random(1);
    numStripes = int(random(2)) + 2;
    numRings = int(random(5)) + 9;
  }

  void waterPlants() {
    
    //pivot irrigation with a 85% chance
    if (pattern > .15) {
      noStroke();
      fill(plotColor); 
      ellipse(cx, cy, 2*radius, 2*radius);
    
      float ringSize = radius*2 / numRings;
      noFill();
      stroke(secondaryColor);
      for (int i = 0; i < numRings; i++) {
        ellipse(cx, cy, i*ringSize, i*ringSize);
      }  
      
    //two half pivots with a 10% chance  
    } else if (pattern > .05) {
      PVector tl = new PVector(cx - radius, cy - radius);
      float stripeWidth = radius*2 / numStripes;
      for (int i = 0; i < numStripes; i++) {
        if (i%2 == 0) {
          fill(plotColor);
        } else {
          fill(secondaryColor);
        }
        noStroke();
        if (orientation < .5) {
          rect(tl.x + i*stripeWidth, tl.y, stripeWidth, radius*2);
        } else {
          rect(tl.x, tl.y + i*stripeWidth, radius*2, stripeWidth);
        } 
      }
    
    //rectangular stripes with a 5% chance  
    } else {
      if (orientation < 0.5) {
        angle = HALF_PI;
      } else {
        angle = 0;
      }
      noStroke();
      fill(plotColor);
      arc(cx, cy, radius*2, radius*2, angle, angle+PI, PIE);
      fill(secondaryColor);
      arc(cx, cy, radius*2, radius*2, angle+PI, angle+TWO_PI, PIE);
    } 
  }
}
