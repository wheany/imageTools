// SlitScan
// by MCG
// Processing 2.1.2

// Takes a folder of sequential images (such as those from a
// video file) and preforms a slitscan transformation on them.
// Running this program a second time will reconvolve the images.
// Images must be in the "data" directory to load correctly

int frames = 720; // Number of files in data folder
String filename = "frame_"; // Name of the files (minus number)
String type = ".jpg"; // File type
PImage[] img = new PImage[frames];
int count = 1;
int w, h;

void setup() {
  img[0] = loadImage(filename + "001" + type);
  w = img[0].width;
  h = img[0].height;
  size(w, frames);
}

void draw() {
  for (int y = 0; y < frames; y++) {
    img[y] = loadImage(filename + nf(y+1, 3) + type);
  }
  while (count < h+1) {
    for (int y=0; y<frames; y++) {
      image(img[y].get(0, count-1, w, 1), 0, y);
    }
    save("output/frame_" + nf(count, 3) + ".png");
    count++;
  }
  exit();
}
