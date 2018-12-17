
//changeable variables
float percentThatMerge = 0.5;
int droughtLevel =  0;
int excessRain = 3;


//Global Variables
int plotsLength = 25;
int plots = 625;
ArrayList<Plot> landPlots = new ArrayList<Plot>();
boolean saved = false;
int timesMerged = 0;


void setup() {
  size(1000,1000);
  
  //initialize all plots and merge them
  int counter = 0;
  for (int x = 0; x < width; x+=width/plotsLength) {
    for (int y = 0; y < height; y+=height/plotsLength) {
      if (counter < plots) {
        landPlots.add(new Plot(new PVector(x,y), height/plotsLength, counter, droughtLevel, excessRain));
      }
      counter++;
    }
  }
  mergePlots(landPlots);
  print(timesMerged);
  
  background(0);
}

void draw() {
  
  
  //just shows all the plots
  background(255);
  for (int j = landPlots.size()-1; j >= 0; j--) {
     landPlots.get(j).showPlot();
  }
  if (!saved) {
    save("/Users/mbernard/Art Center/Dev Projects/Drawing/Farmland 3/farmland3 - 48.jpg");
    saved = true;
  }
}

//chooses 10% of plots and enlarges them, then deactivates the old plots that they now cover up
void mergePlots(ArrayList<Plot> plots) {
  
  print("recursed\n");
  timesMerged++;
  if (plots.size() <= 1) {
   return; 
  }
  
  ArrayList<Plot> mergedPlots = new ArrayList<Plot>();
  
  for (int i = 0; i < plots.size() - plotsLength; i++) {
    
    if (random(1) < percentThatMerge) {
      
      if (landPlots.get(plots.get(i).plotNumber).activated && plots.get(i).plotNumber%plotsLength != plotsLength-timesMerged && plots.get(i).plotNumber < landPlots.size() - (timesMerged*plotsLength)) {
        
        landPlots.get(plots.get(i).plotNumber).setSideLength(width/plotsLength * timesMerged);
        //landPlots.get(plots.get(i).plotNumber).setSideLength(plots.get(i).sideLength*(timesMerged+1/timesMerged));
        plots.get(i).setSideLength(plots.get(i).sideLength*(timesMerged+1/timesMerged));
          
        //deactivates bottom row and right column of new plots
        for (int j = 0; j < timesMerged+1; j++) {
          landPlots.get((plots.get(i).plotNumber + j*plotsLength)+timesMerged).activated = false;
          //print(landPlots.get((plots.get(i).plotNumber + j*plotsLength)+timesMerged).plotNumber + " , ");
          landPlots.get((plots.get(i).plotNumber + timesMerged*plotsLength)+j).activated = false;
          //print(landPlots.get((plots.get(i).plotNumber + timesMerged*plotsLength)+j).plotNumber);
          //print("\n");
        }
        mergedPlots.add(plots.get(i));
      }
    }
  }
  print("size of mergedPlots =" + mergedPlots.size() + "\n");
  mergePlots(mergedPlots);
}
        
  
  
  
  
  
