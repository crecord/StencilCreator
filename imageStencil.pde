

import controlP5.*;
import gab.opencv.*;
import processing.pdf.*;
OpenCV opencv;
PImage img, grayImage;

void setup(){
 
 img = loadImage("premasticated.png"); 
 opencv = new OpenCV(this, img);
 size(opencv.width, opencv.height, P2D);
 grayImage = opencv.getSnapshot(); 
}

void draw(){
  image(grayImage,0,0);
}
