void filters() {
  switch(key)
  {
  case 'r':  // Row sorting
    int[] temp = new int[w];
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        int loc = i + j*w; 
        temp[i] = channel[select][loc];
      }
      temp = sort(temp);
      for (int i = 0; i < w; i++) {
        int loc = i + j*w; 
        channel[select][loc] = temp[i];
      }
    }
    settings[select] += " row";
    break;
  case 'R':  // Reverse Row sorting
    temp = new int[w];
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        int loc = i + j*w; 
        temp[i] = channel[select][loc];
      }
      temp = reverse(sort(temp));
      for (int i = 0; i < w; i++) {
        int loc = i + j*w; 
        channel[select][loc] = temp[i];
      }
    }
    settings[select] += " Row";
    break;
  case 'f':  // Full sorting
    int[] tempLong = new int[pixels.length];
    for (int i = 0; i < pixels.length; i++) {
      tempLong[i] = channel[select][i];
    }
    tempLong = sort(tempLong);
    for (int i = 0; i < pixels.length; i++) {
      channel[select][i] = tempLong[i];
    }
    settings[select] += " full";
    break;
  case 'F': // Reverse Full Sort
    tempLong = new int[pixels.length];
    for (int i = 0; i < pixels.length; i++) {
      tempLong[i] = channel[select][i];
    }
    tempLong = reverse(sort(tempLong));
    for (int i = 0; i < pixels.length; i++) {
      channel[select][i] = tempLong[i];
    }
    settings[select] += " Full";
    break;
  case 't': // Threshold
    colorMode(RGB);
    for (int i = 0; i < pixels.length; i++) {
      timg.pixels[i] =  color(channel[select][i], channel[select][i], channel[select][i]);
    }
    timg.filter(THRESHOLD);
    for (int i = 0; i < pixels.length; i++) {
      channel[select][i] = timg.pixels[i] & 0xFF;
    }
    settings[select] += " thold";
    break;
  case 'p': // Posterize
    colorMode(RGB);
    for (int i = 0; i < pixels.length; i++) {
      timg.pixels[i] =  color(channel[select][i], channel[select][i], channel[select][i]);
    }
    timg.filter(POSTERIZE, plvl);
    for (int i = 0; i < pixels.length; i++) {
      channel[select][i] = timg.pixels[i] & 0xFF;
    }
    settings[select] += " post";
    break;
  case 'b': // Blur
    colorMode(RGB);
    for (int i = 0; i < pixels.length; i++) {
      timg.pixels[i] =  color(channel[select][i], channel[select][i], channel[select][i]);
    }
    timg.filter(BLUR, blvl);
    for (int i = 0; i < pixels.length; i++) {
      channel[select][i] = timg.pixels[i] & 0xFF;
    }
    settings[select] += " blur";
    break;
  case 'n': // Negative
    colorMode(RGB);
    for (int i = 0; i < pixels.length; i++) {
      timg.pixels[i] =  color(channel[select][i], channel[select][i], channel[select][i]);
    }
    timg.filter(INVERT);
    for (int i = 0; i < pixels.length; i++) {
      channel[select][i] = timg.pixels[i] & 0xFF;
    }
    settings[select] += " neg";
    break;
  default:
    println("");
    print(int(key) + " undefined");
    break;
  }
}
