PImage img;
PImage timg;
String filename;
String[] settings;
int w, h;
int[][] channel;
int select = 0;
int toggle = 0;
int step = 0;
int sort = 0;
int plvl = 5; // Posterization level
int blvl = 4; // Blur level

void setup() {
  while (step < 2) {
    if (step == 0)
    {
      selectInput("Select a file to process:", "fileSelected");
      step++;
    }
  }
  step = 0;
  img = loadImage(filename);
  timg = loadImage(filename);
  w = img.width;
  h = img.height;
  size(w, h);
  channel = new int[3][w*h];
  settings = new String[3];
  image(img, 0, 0);
  loadPixels();
  load(0, 'r');
  load(1, 'g');
  load(2, 'b');
}

void keyReleased() {
  switch(key) {
    // --------------------- Channels
  case 49: // 1
    select = 0;
    break;
  case 50: // 2
    select = 1;
    break;
  case 51: // 3
    select = 2;
    break;
    // --------------------- Inputs
  case 'y':
    load(select, 'r');
    break;
  case 'u':
    load(select, 'g');
    break;
  case 'i':
    load(select, 'b');
    break;
  case 'h':
    load(select, 'H');
    break;
  case 'j':
    load(select, 'S');
    break;
  case 'k':
    load(select, 'B');
    break;
    // --------------------- Mode Toggle
  case '`': 
    step = 0;
    if (toggle == 0) {
      toggle = 1;
    }
    else {
      toggle = 0;
    }
    break;
    // --------------------- Save File
  case 's':
    save(month() + nf(day(), 2) + "/" + hour() + nf(minute(), 2) + nf(second(), 2) + ".png");
    println("Saved!");
    break;
    // --------------------- Filters
  default:
    filters();
    break;
  }
  if (toggle == 1) {
      colorMode(HSB);
    }
    else {
      colorMode(RGB);
    }
  // End switch, update console
  println("");
  switch(select) {
  case 0:
    print("[" + settings[0] + "] " + settings[1] + "  " + settings[2]);
    break;
  case 1:
    print(" " + settings[0] + " [" + settings[1] + "] " + settings[2]);
    break;
  case 2:
    print(" " + settings[0] + "  " + settings[1] + " [" + settings[2] + "]");
    break;
  }
  if (toggle == 1) {
    print(" [HSB]");
  };
}

void draw() {
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] =  color(channel[0][i], channel[1][i], channel[2][i]);
  }
  updatePixels();
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Selection canceled.");
  } 
  else {
    filename = selection.getAbsolutePath();
    step++;
  }
}

