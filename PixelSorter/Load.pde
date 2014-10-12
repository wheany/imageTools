void load(int s, char m) {
  for (int i = 0; i < pixels.length; i++) {
    switch(m) {
    case 'r': // r
      channel[s][i] = img.pixels[i] >> 16 & 0xFF;
      settings[s] = "Red"; 
      break;
    case 'g': // g
      channel[s][i] = img.pixels[i] >> 8 & 0xFF;
      settings[s] = "Green";
      break;
    case 'b': // b
      channel[s][i] = img.pixels[i] & 0xFF;
      settings[s] = "Blue";
      break;
    case 'H': // H
      channel[s][i] = int(hue(img.pixels[i]));
      settings[s] = "Hue";
      break;
    case 'S': // S
      channel[s][i] = int(saturation(img.pixels[i]));
      settings[s] = "Sat";
      break;
    case 'B': // B
      channel[s][i] = int(brightness(img.pixels[i]));
      settings[s] = "Bright";
      break;
    }
  }
}
