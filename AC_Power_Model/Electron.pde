class Electron {
  float t, xs;
  PVector p, c;
  color f;
  int phase;

  Electron(float _t, float _r, PVector _c, float _xs, int _phase) {
    t = _t;
    xs = _xs;
    c = new PVector(_c.x, _c.y);
    p = new PVector(c.x, c.y + _r*sin(t));
    phase = _phase;
    switch(phase) {
    case 1:
      f = color(255, 0, 0);
      break;
    case 2:
      f = color(0, 255, 0);
      break;
    case 3:
      f = color(0, 0, 255);
      break;
    }
  } 

  void run() {
    update();
    display();
  }

  void update() {
    //t += ts;
    p.x += 1;
  }

  void display() {
    fill(f);
    int size;
    if (phase == 1) size = 4; else size = 5;
    ellipse(p.x, p.y, size, size);
  }

  boolean isDead() {
    if (c.x > width) {
      return true;
    } 
    else {
      return false;
    }
  }
}

