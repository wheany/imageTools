// TimeScaler v141014
// by MCG
// Processing 2.1.2

// Required User Inputs:
int frames = 98; // Number of frames
int digits = 3; // Digits in file name sequence
int start = 0; // First number in sequence
String filename = "Seq_"; // File name
String filetype = ".png"; // File type
String outputFolder = "Output2"; // Output folder name

// User Options:
float fade = 1; // Retard on effect
int smooth2D = 2; // 2D smoothing
int smooth3D = 1; // Time smoothing

// Non-user variables
PImage[] img = new PImage[frames];
PImage[] fimg = new PImage[frames];
PImage timg;
float[][][] frameData;
float[][][] frameDataT;
int[][] adj;
int w, h;
int min, sec;

void setup() {
  img[0] = loadImage(filename + nf(start, digits) + filetype);
  h = img[0].height;
  w = img[0].width;
  size(w, h);
  frameData = new float[frames][w][h];
  frameDataT = new float[frames][w][h];
  min = minute();
  sec = second(); 
  loadAdj();
}

void draw() {
  // Load images into img array
  println("Loading Images...");
  for (int i = 0; i < frames; i++) {
    img[i] = loadImage(filename + nf(i+start, digits) + filetype);
    fimg[i] = img[i].get();
  }
  loadPixels();

  // Load brightness into array
  // Calculate absolute changes
  println("Constructing Arrays...");
  for (int k = 0; k < frames; k++) {
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        int loc = i + j*w;
        frameData[k][i][j] = brightness(img[k].pixels[loc]);
        frameData[k][i][j] -= brightness(img[max(0, k-1)].pixels[loc]);
        frameData[k][i][j] = abs(frameData[k][i][j]) + fade;
        // I think if you subtract 255 from inside the abs
        // it will compress fast objects instead of slow ones.
      }
    }
  }

  // Smoothing in 3-dimensions by
  // adding surrounding points
  println("Smoothing Points...");
  for (int k = 0; k < frames; k++) {
    for (int j = 0; j < h; j++) { 
      for (int i = 0; i < w; i++) {
        for (int a = 0; a < adj.length; a++) { 
          int loc = i + j*w;
          int it = constrain(i + adj[a][0], 0, w-1);
          int jt = constrain(j + adj[a][1], 0, h-1);
          frameDataT[k][i][j] += frameData[k][it][jt];
        }
      }
    }
  }
  // Reload
  println("Repacking Adjustments...");
  frameData = frameDataT;

  // Divide by the sum, multiply by frames
  // This normilizeses the data
  println("Normilizing Data...");
  for (int j = 0; j < h; j++) { 
    for (int i = 0; i < w; i++) {
      float sum = 0;
      for (int k = 0; k < frames; k++) {
        sum += frameData[k][i][j];
      }  
      for (int k = 0; k < frames; k++) {
        if (sum != 0) {
          frameData[k][i][j] = (frameData[k][i][j] / sum) * float(frames);
        }
      }
    }
  }

  // Reload
  println("Rearranging Pixels...");
  for (int j = 0; j < h; j++) {
    for (int i = 0; i < w; i++) {
      int loc = i + j*w;
      float frameTick = 0;
      float frameShift = 0;
      int f = 0;
      for (int k = 0; k < frames; k++) {
        frameTick = frameShift + frameData[k][i][j]; // Calculates frame persistance
        frameShift = (frameTick % 1); // Keeps track of partial frames
        frameTick = floor(frameTick); // Needs to be an whole number
        for (int l = 0; l < frameTick; l++) { // Add frames only ticked
          fimg[f].pixels[loc] = img[k].pixels[loc];
          f++; // this is what frame it's on
        }
        // This method goes by nearest neighbor and should
        // be updated to make use of dropped frames using
        // alpha channels reduce aliasing
      }
    }
  }

  // Home stretch
  updatePixels();
  println("Saving Frames...");
  for (int k = 0; k < frames; k++) {
    image(fimg[k], 0, 0);
    save(outputFolder + "/frame_"+nf(k, digits)+".png");
  }
  println("");
  println("Complete!");
  time();
  println(nf(min, 2) + ":" + nf(sec,2));
  exit();
}
