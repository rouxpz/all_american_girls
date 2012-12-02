//Data Rep Final
//Roopa Vasudevan
//12/11/12

/* This sketch creates an initial image that fills up the text in Obama's
name and Romney's name based on the percentage of women in a selected state
that voted for each candidate.  The resulting image should be scaled up in
Illustrator to 720x576, and then run with the sketch "final_GRID".*/

PImage obama; //initial images of the text
PImage romney;

float percentRomney; //percentage of women who voted for each candidate
float percentObama;

float romneyPixels = 0; //total number of pixels per candidate
float obamaPixels = 0;

int rFill; //percentage applied to the number of pixels
int oFill;

color black = color(150); //threshold of color to count
int counter = 0; //counter for romney
int otherCounter = 0; //counter for obama

void setup() {
  size(125, 100);
  smooth();

  obama = loadImage("obamasmall.jpg");
  romney = loadImage("romneysmall.jpg");

  loadData();
  countPixels();
}


void draw() {
  write();  
}

//---------------------------------------------------//

//draw appropriate pixels -- called in draw
void write() {

  background(255);

  loadPixels();
  romney.loadPixels();
  obama.loadPixels();

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height/2; y++) {

      int loc = x+y*width;

      if (romney.pixels[loc] <= black) { //if pixels in romney are black
        counter++; //increase the romney pixel count

        if (counter <= rFill) { //if the counter is less than or equal to the percentage of pixels to be filled
          stroke(255, 0, 0); //make the pixel red
        } 
        else {
          stroke(150); //make the pixel gray
        }
        point(x, y); //draw a point over the pixel
      }

      if (obama.pixels[loc] < black) { //if the pixels in obama are black
        otherCounter++; //increase the obama pixel count
        if (otherCounter <= oFill) { //if counter is less than percentage to be filled
          stroke(0, 0, 255); //color the pixel blue
        } 
        else {
          stroke(150); //color the pixel gray
        }

        point(x, y+height/2); //draw a point on the pixel
      }
    }
  }

  //update the pixels
  romney.updatePixels();
  obama.updatePixels();

  //reset the counter for every frame
  counter = 0; 
  otherCounter = 0;

}

//load the data
void loadData() {

  String [] rows = loadStrings("turnout.csv"); //load the csv
  //println(rows[36]);
  for (int i = 36; i < 37; i++) { //select the state manually
    String [] lines = split(rows[i], ','); //split at commas
    //println(lines[10]);
    
    //determine what percentage of women voted for each candidate
    percentRomney = float(lines[9]); 
    percentObama = float(lines[10]);
    //println(percentObama);
  }
}

//make an inital count of the pixels and determine the percentage to be filled -- called in setup
void countPixels() { 
  loadPixels();
  romney.loadPixels();
  obama.loadPixels();
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height/2; y++) {
      
      int loc = x+y*width;
      
      if (romney.pixels[loc] <= black) { //if the pixel is below the threshold
        romneyPixels++; //increase the pixel count
        
        rFill = int((percentRomney/100)*romneyPixels); //get the percentage of pixels to be filled
        
        //println(rFill);
      }
      
      if (obama.pixels[loc] <= black) { //if the pixel is below the threshold
        obamaPixels++; //increase the pixel count
        
        oFill = int((percentObama/100)*obamaPixels); //get the percentage of pixels to be filled
        
        //println(oFill);
      }
    }
  }
  
}

//save a png of the resulting image
void keyPressed() {
  saveFrame("ohio.png");
}

