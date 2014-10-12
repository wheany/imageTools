
void filter() {
  switch(filter) {
  case 1: // Vertical Blinds
    timg = get();
    int tw = 0;
    int ti=0;
    for (int i = 0; i < w/2; i = i+size) {
      image(timg.get(i, 0, size, h), 2*i, 0);
      ti = i; // pulls i out of the loop
    }
    tw = 2 * ti + size; // calculates width of pixels written
    if ( tw > w ) { // if written past picture witdth, then
      ti = ti - (tw - w); // subtract overage from last segment
    }
    ti += size; // increment segment
    for (int i = 0; i < w/2; i = i+size) {
      image(timg.get(ti+i, 0, size, h), 2*i+size, 0);
    }
    break;
  case 2: // Horizontal Blinds
    timg = get();
    int th = 0;
    int tj=0;
    for (int j = 0; j < h/2; j = j+size) {
      image(timg.get(0, j, w, size), 0, 2*j);
      tj = j; // pulls j out of the loop
    }
    th = 2 * tj + size; // calculates width of pixels written
    if ( th > h ) { // if written past picture witdth, then
      tj = tj - (th - h); // subtract overage from last segment
    }
    tj += size; // increment segment
    for (int j = 0; j < h/2; j = j+size) {
      image(timg.get(0, tj+j, w, size), 0, 2*j+size);
    }
    break;
  case 3: // Quilted
    for (int j = 0; j<h; j=j+size) {
      for (int i = 0; i<w;i++) {
        if (((i / size) % 2 ) == ((j / size) % 2 )) {
          stroke(get(i, j));
          line(i, j, i, j+size-1);
        }
      }
    }
    for (int i = 0; i<w; i=i+size) {
      for (int j = 0; j<h;j++) {
        if (((i / size) % 2 ) != ((j / size) % 2 )) {
          stroke(get(i, j));
          line(i, j, i+size-1, j);
        }
      }
    }
    break;
  case 4: // Pointillism (Uniform)
    noStroke();
    timg = get();
    background(0);
    int psize = size / 3;
    psize = max(psize, 3);
    int tsize = int(sqrt(3)*psize/2);
    for (int j = 0; (j * tsize) < h; j++) { 
      for (int i = 0; i < w; i = i + psize) {
        if ( (j % 2) == 1 && i == 0) {
          i += (psize/2);
        }
        int pj = j * tsize;
        color pix = timg.get(i, pj);
        fill(pix);
        ellipse(i, pj, psize, psize);
      }
    }
    break;
  case 5: // Pointillism (Random)
    timg = get();
    noStroke();
    psize = size / 3;
    psize = max(psize, 3);
    for (int i = 0; i < 10000; i++) {
      int x = int(random(w));
      int y = int(random(h));
      color pix = timg.get(x, y);
      fill(pix, 128);
      ellipse(x, y, psize, psize);
    }
    break;
  }
}
