void loadAdj() {
  int sxy = smooth2D*2 + 1;
  int st = smooth3D*2 + 1;
  adj = new int[sxy*sxy*st][3];
  int a = 0;
  for (int k = -smooth3D; k <= smooth3D; k++) {
    for (int j = -smooth2D; j <= smooth2D; j++) {
      for (int i = -smooth2D; i <= smooth2D; i++) {
        adj[a][0] = i;
        adj[a][1] = j;
        adj[a][2] = k;
        a++;
      }
    }
  }
  //println(adj.length);
}

void time() {
  sec = second() - sec;
  min = minute() - min;
  if (min < 0) {
    min += 60;
  }
  if (sec < 0) {
    sec += 60;
    min -= 1;
  }
}
