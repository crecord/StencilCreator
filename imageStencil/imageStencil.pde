

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

void setup() {
  // loads image as gray scale
  img = loadImage("premasticated.png"); 
  opencv = new OpenCV(this, img);
  size(opencv.width + ctrlW, opencv.height, P2D);
  grayImage = opencv.getSnapshot();
  cp5 = new ControlP5(this);
  // eventually have a drag and drop file system
  text("loadImage", ctrlB, 20);
  // toggle to invert the image colors
  cp5.addToggle("invert")
    .setPosition(ctrlB, 40)
      .setSize(50, 20)
        .setValue(true)
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
  cp5.addSlider("thesholdValue", 0, 255, 80, ctrlB, 165, 50, 15);
  // button to save as a pdf
    cp5.addButton("savePDF")
     .setValue(0)
     .setPosition(ctrlB, 190)
     .setSize(80,19)
     ;
}

void draw() {
  image(grayImage, ctrlW, 0);
}

public void pixelBorder(int theValue) {
  println("### got an event from numberboxC : "+theValue);
}

void radioButton(int a) {
  println("a radio Button event: "+a);
}


