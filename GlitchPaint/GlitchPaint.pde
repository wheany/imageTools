// GlitchPaint v141011
// By MCG
// Processing 2.1.2

PImage img;
PImage timg;
PImage clipboard;
String filename;
StringList styleName;
StringList filterName;
int w, h;
int x, y;
int mx, my;
int[] r, g, b;
int c1, c2, c = 1; // Cut and paste points
int pLevel = 4; // Posterization amount
int size = 50; // Object Sizes
int lsize = 7; // Line width
int str = 25; // Noise strength
char dir = 'u'; // Line directions select
char channel = 'r'; // Channel select
int step = 0;
int style = 1;
int filter = 2;

// ------------------------------------------------------------------------------ Setup
void setup() {
  while (step < 2) {
    if (step == 0)
    {
      selectInput("Select a file to process:", "fileSelected");
      step++;
    }
  }
  img = loadImage(filename);
  w = img.width;
  h = img.height;
  r = new int[h*w];
  g = new int[h*w];
  b = new int[h*w];
  size(w, h);
  loadNames();
  image(img, 0, 0);
  clipboard = get();
  loadPixels();
}

// ------------------------------------------------------------------------------ Pressed
void draw() {
  if (mousePressed && (mouseButton == LEFT)) {
    mx = constrain(mouseX, 0, w);
    my = constrain(mouseY, 0, h);
    switch(style) {
    case 1: // Box
      x = mx;
      y = my;
      for (int i=0; i<size; i++) {
        // x- y-
        stroke(get(max(0, x-size), y-i));
        line(x-i, y-i, x-size, y-i);
        stroke(get(x-i, max(0, y-size)));
        line(x-i, y-i, x-i, y-size);
        // x+ y+
        stroke(get(min(w-1, x+size), y+i));
        line(x+i, y+i, x+size, y+i);
        stroke(get(x+i, min(h-1, y+size)));
        line(x+i, y+i, x+i, y+size);
        // x+ y-
        stroke(get(min(w-1, x+size), y-i));
        line(x+i, y-i, x+size, y-i);
        stroke(get(x+i, max(0, y-size)));
        line(x+i, y-i, x+i, y-size);
        // x- y+
        stroke(get(max(0, x-size), y+i));
        line(x-i, y+i, x-size, y+i);
        stroke(get(x-i, min(h-1, y+size)));
        line(x-i, y+i, x-i, y+size);
      }
      break;
    case 2: // Line
      x = mx;
      y = my;
      switch(dir) {
      case 'u':
        for (int i=0-(lsize/2); i<(lsize/2)+1; i++) {
          stroke(get(x+i, y));
          line(x+i, y, x+i, y-size);
        }
        break;
      case 'd':
        for (int i=1-(lsize/2); i<(lsize/2)+1; i++) {
          stroke(get(x+i, y));
          line(x+i, y, x+i, y+size);
        }
        break;
      case 'l':
        for (int i=0-(lsize/2); i<(lsize/2)+1; i++) {
          stroke(get(x, y+i));
          line(x, y+i, x-size, y+i);
        }
        break;
      case 'r':
        for (int i=0-(lsize/2); i<(lsize/2)+1; i++) {
          stroke(get(x, y+i));
          line(x, y+i, x+size, y+i);
        }
        break;
      }
      break;
    case 3: // Line Long
      x = mx;
      y = my;
      switch(dir) {
      case 'u':
        for (int i=0-(lsize/2); i<(lsize/2)+1; i++) {
          stroke(get(x+i, y));
          line(x+i, y, x+i, 0);
        }
        break;
      case 'd':
        for (int i=1-(lsize/2); i<(lsize/2)+1; i++) {
          stroke(get(x+i, y));
          line(x+i, y, x+i, h);
        }
        break;
      case 'l':
        for (int i=0-(lsize/2); i<(lsize/2)+1; i++) {
          stroke(get(x, y+i));
          line(x, y+i, 0, y+i);
        }
        break;
      case 'r':
        for (int i=0-(lsize/2); i<(lsize/2)+1; i++) {
          stroke(get(x, y+i));
          line(x, y+i, w, y+i);
        }
        break;
      }
      break;
    case 4: // Pull pixels
      loadPixels();
      for (int i = 0; i < pixels.length; i++) {
        r[i] = pixels[i] >> 16 & 0xFF; 
        g[i] = pixels[i] >> 8 & 0xFF;
        b[i] = pixels[i] & 0xFF;
      }
      int loc = mx + my*width;
      switch(channel) {
      case 'r':
        r = append(concat(subset(r, 0, loc-1), subset(r, loc, r.length-loc)), 0);
        break;
      case 'g':
        g = append(concat(subset(g, 0, loc-1), subset(g, loc, g.length-loc)), 0);
        break;
      case 'b':
        b = append(concat(subset(b, 0, loc-1), subset(b, loc, b.length-loc)), 0);
        break;
      case 'a':
        r = append(concat(subset(r, 0, loc-1), subset(r, loc, r.length-loc)), 0);
        g = append(concat(subset(g, 0, loc-1), subset(g, loc, g.length-loc)), 0);
        b = append(concat(subset(b, 0, loc-1), subset(b, loc, b.length-loc)), 0);
        break;
      }
      for (int i = 0; i < pixels.length; i++) { 
        pixels[i] =  color(r[i], g[i], b[i]); // Channels can be swapped here
      }
      updatePixels();
      break;
    case 5: // Push pixels
      loadPixels();
      for (int i = 0; i < pixels.length; i++) {
        r[i] = pixels[i] >> 16 & 0xFF; 
        g[i] = pixels[i] >> 8 & 0xFF;
        b[i] = pixels[i] & 0xFF;
      }
      loc = mx + my*width;
      switch(channel) {
      case 'r':
        r = splice(r, pixels[loc] >> 16 & 0xFF, loc);
        break;
      case 'g':
        g = splice(g, pixels[loc] >> 8 & 0xFF, loc);
        break;
      case 'b':
        b = splice(b, pixels[loc] >> 0xFF, loc);
        break;
      case 'a':
        r = splice(r, pixels[loc] >> 16 & 0xFF, loc);
        g = splice(g, pixels[loc] >> 8 & 0xFF, loc);
        b = splice(b, pixels[loc] >> 0xFF, loc);
        break;
      }
      for (int i = 0; i < pixels.length; i++) { 
        pixels[i] =  color(r[i], g[i], b[i]); // Channels can be swapped here
      }
      updatePixels();
      break;
    case 10: // Circle
      x = mx;
      y = my;      
      noStroke();
      fill(img.get(x, y));
      ellipse(x, y, size, size);
      break;
    }
  }
  if (mousePressed && (mouseButton == RIGHT)) {
    mx = mouseX;
    my = mouseY;
    timg = img.get(mx - (size/2), my - (size/2), size, size);
    image(timg, mx - (size/2), my - (size/2));
  }
}

// ------------------------------------------------------------------------------ Clicked
void mouseClicked() {
  if (mouseButton == LEFT) {
    switch(style) {
    case 6: // Remove Color Channel
      switch(c) {
      case 1:
        c++;
        c1 = mx;
        c2 = my;
        println("-Click again");
        break;
      case 2:
        loadPixels();
        for (int i = 0; i < pixels.length; i++) {
          r[i] = pixels[i] >> 16 & 0xFF;
          g[i] = pixels[i] >> 8 & 0xFF;
          b[i] = pixels[i] & 0xFF;
        }
        int min = min(c1+c2*w, mx+my*w);
        int max = max(c1+c2*w, mx+my*w);
        switch(channel) {
        case 'r':
          for (int i = min; i < max; i++) {
            pixels[i] =  color(0, g[i], b[i]);
          }
          break;
        case 'g':
          for (int i = min; i < max; i++) {
            pixels[i] =  color(r[i], 0, b[i]);
          }     
          break;   
        case 'b':
          for (int i = min; i < max; i++) {
            pixels[i] =  color(r[i], g[i], 0);
          }
          break;
        default:
          break;
        }
        println("-Color Stripped");
        updatePixels();
        c=1;
        break;
      }
      break;
    case 7:  // Noise
      switch(c) {
      case 1:
        c++;
        c1 = mx;
        c2 = my;
        println("-Click again");
        break;
      case 2:
        int cx = mx;
        int cy = my;
        int tw = abs(c1 - cx);
        int th = abs(c2 - cy);
        int ts = tw * th;
        timg = get();
        for (int j = 0; j < h; j++) {
          for (int i = 0; i < w; i++) {
            int ri = int(i + random(-4, 5));
            int rj = int(j + random(-3, 4));
            timg.pixels[i + j*w] =  timg.pixels[constrain(ri + rj*w, 0, timg.pixels.length-1)];
          }
        }
        timg = timg.get(min(c1, cx), min(c2, cy), abs(c1 - cx), abs(c2 - cy));
        image(timg, min(c1, cx), min(c2, cy));
        println("-Noise added");
        c=1;
        break;
      }
      break;
    case 8: // Invert
      switch(c) {
      case 1:
        c++;
        c1 = mx;
        c2 = my;
        println("-Click again");
        break;
      case 2:
        int cx = mx;
        int cy = my;
        timg = get(min(c1, cx), min(c2, cy), abs(c1 - cx), abs(c2 - cy));
        timg.filter(INVERT);   
        image(timg, min(c1, cx), min(c2, cy));
        println("-Inverted");
        c=1;
        break;
      }
      break;
    case 9: // Posterize
      switch(c) {
      case 1:
        c++;
        c1 = mx;
        c2 = my;
        println("-Click again");
        break;
      case 2:
        int cx = mx;
        int cy = my;
        timg = get(min(c1, cx), min(c2, cy), abs(c1 - cx), abs(c2 - cy));
        timg.filter(POSTERIZE, pLevel); 
        image(timg, min(c1, cx), min(c2, cy));
        println("-Posterized");
        c=1;
        break;
      }
      break;
    case -1: // Cut
      switch(c) {
      case 1:
        c++;
        c1 = mx;
        c2 = my;
        println("-Click again");
        break;
      case 2:
        c=1;
        int cx = mx;
        int cy = my;
        timg = get(min(c1, cx), min(c2, cy), abs(c1 - cx), abs(c2 - cy));
        println("-Cut");
        break;
      }
      break;
    case -2: // Paste
      image(timg, mx, my);
      println("-Pasted");
      c=1;
      break;
    }
  }
}

void mouseWheel(MouseEvent event) {
  int e = event.getCount();
  if (e != 0) {
    int ps = style;
    style = constrain(style + e, 1, 10);
    if (style != ps) {
      println("[T" + style + "] " + styleName.get(style));
    }
    c = 1;
  }
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
