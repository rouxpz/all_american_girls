//Data Rep Final
//Roopa Vasudevan
//12/11/12

/*This sketch creates an 8"x10" cross stitch pattern from the image
generated in "final_FINAL".*/

PImage pattern; //scaled up pattern from Illustrator

void setup() {
  size(720,576);
  
  pattern = loadImage("arizona.jpg");
}

void draw() {
  image(pattern, 0, 0);
  
  //draw grid so that each "pixel" is outlined
  for (float i = 0; i < width; i+=5.76) {
    line(i,0,i,height);
  }
  
  for (float i = 0; i < height; i+=5.76) {
    line(0,i,width,i);
  }
}

//save resulting image to a PNG
void keyPressed() {
  
  saveFrame("arizona_PATTERN.png");
}
