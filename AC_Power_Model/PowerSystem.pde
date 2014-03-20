class PowerSystem {
  ArrayList<Power> particles;
  PVector origin;

  PowerSystem() {
    particles = new ArrayList<Power>();
  }

  void addParticle(float _t, float _t2, float _v, float _i, PVector _c, float _xs, int phase) {
    particles.add(new Power(_t, _t2,  _v, _i,  _c, _xs, phase));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Power p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}
