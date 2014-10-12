void keyPressed() {
  switch(key) {
  case ']':
    size += 5;
    println("Brush:" + size);
    break;
  case '[': 
    size -= 5;
    size = max(size, 5);
    println("Brush:" + size);
    break;
  case '=':
    size += 1;
    size = max(size, 5);
    println("Brush:" + size);
    break;
  case '-':
    size -= 1;
    size = max(size, 5);
    println("Brush:" + size);
    break;
  case '+':
    size += 1;
    size = max(size, 5);
    println("Brush:" + size);
    break;
  }
}

void keyReleased() {
  c = 1;
  if (key == CODED) {
    switch(keyCode) {
    case UP:
      dir = 'u';
      println("-Up");
      break;
    case DOWN:
      dir = 'd';
      println("-Down");
      break;
    case LEFT:
      dir = 'l';
      println("-Left");
      break;
    case RIGHT:
      dir = 'r';
      println("-Right");
      break;
    }
  } 
  else {
    switch(key) {
    case 's':
      save(month() + nf(day(), 2) + "/" + hour()
        + nf(minute(), 2) + nf(second(), 2) + ".png");
      println("Saved!");
      break;
    case 'r': 
      channel = 'r';
      println("-Red (cyan)");
      break;
    case 'g': 
      channel = 'g';
      println("-Green (magenta)");
      break;
    case 'b': 
      channel = 'b';
      println("-Blue (yellow)");
      break;
    case 'a': 
      channel = 'a';
      println("-All channels");
      break;
    case 'f':
      filter();
      break;
    case 'Z':
      clipboard = get();
      println("Quick saved");
      break;
    case 'z':
      image(clipboard, 0, 0);
      println("Quick loaded");
      break;
    case 'c':
      style = -1;
      println("[c] Cut");
      break;
    case 'v':
      style = -2;
      println("[v] Paste");
      break;
    }
    if ( key > 48 && key < 58 ) {
      filter = int(key) - 48;
      println("[f] " + filterName.get(filter));
    }
  }
}  
