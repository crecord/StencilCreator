

import controlP5.*;
import gab.opencv.*;
import processing.pdf.*;
OpenCV opencv;
PImage img, grayImage;
ControlP5 cp5;
int ctrlW = 200;
int ctrlB = 10;
boolean invert;
RadioButton r;
int threshValue;
boolean isThreshold;
ArrayList<Contour> contours;

void setup() {
  // loads image as gray scale
  img = loadImage("premasticated.png"); 
  opencv = new OpenCV(this, img);
  opencv.gray();
  size(opencv.width + ctrlW, opencv.height, P2D);
  grayImage = opencv.getSnapshot();
  // "img" will hold the orginal greyscale image so all changes can be made from it
  img = grayImage;
  cp5 = new ControlP5(this);
  // eventually have a drag and drop file system
  text("loadImage", ctrlB, 20);
  // toggle to invert the image colors
  cp5.addToggle("invert")
    .setPosition(ctrlB, 40)
      .setSize(50, 20)
        .setValue(false)
          .setMode(ControlP5.SWITCH)
            ;
  // slider to create border
  // name, minValue, maxValue, defaultValue, x, y, width, height
  cp5.addSlider("pixelBorder", 0, 20, 0, ctrlB, 85, 50, 15);
  // two radio buttons
  text("Set Thresholding", ctrlB, 115);
    r = cp5.addRadioButton("radioButton")
         .setPosition(ctrlB,120)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(1)
         .setSpacingColumn(50)
         .addItem("threshold",1)
         .addItem("adaptive threshold",2)
         ;
  // set threshold value 
  cp5.addSlider("thresholdValue", 0, 255, threshValue, ctrlB, 165, 50, 15);
  // button to save as a pdf
    cp5.addButton("savePDF")
     .setValue(1)
     .setPosition(ctrlB, 190)
     .setSize(80,19)
     ;
 isThreshold = false;
  
}

void draw() {
  image(grayImage, ctrlW, 0);
}

public void pixelBorder(int theValue) {
  println("### got an event from numberboxC : "+theValue);
}

void savePDF(int value){
  println("button" + value); 
  strokeWeight(1);
  contours = opencv.findContours();
  beginRecord(PDF, "test.pdf");
    for (Contour contour : contours) {
    contour.draw();
  }
  endRecord();
  open("test.pdf");
}

public void invert(int theValue) {
  println("toggle "+theValue);
  opencv.loadImage(img);
  opencv.invert();
  img = opencv.getSnapshot();
  grayImage = opencv.getSnapshot();
}


void thresholdValue(int value){
  println("the threshold value changed " + value); 
  if (isThreshold){
    opencv.loadImage(img);
    opencv.threshold(value); 
    grayImage = opencv.getOutput();
    threshValue = value;
    println("reThresholded");
  }
}

void radioButton(int a) {
  println("a radio Button event: "+a);
  opencv.loadImage(img);
  if(a == 1){
      opencv.threshold(threshValue); 
      grayImage = opencv.getOutput();
      isThreshold = true;
    // adptive threshold;
      println("trexh");
  }
  else if (a ==2){
      opencv.adaptiveThreshold(561, 1);
      grayImage = opencv.getSnapshot();
      isThreshold = false;
      println("adaptThresholded");
  }
}


