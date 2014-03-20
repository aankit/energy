class Power {
  float t, t2, xs;
  PVector p, c;
  color f;
  int phase;

  Power(float _t, float _t2, float _v, float _i, PVector _c, float _xs, int _phase) {
    t = _t;
    t2 = _t2;
    xs = _xs;
    c = new PVector(_c.x, _c.y);
    p = new PVector(c.x, c.y - (_v*_i*sin(t)*sin(t2))/100);
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
