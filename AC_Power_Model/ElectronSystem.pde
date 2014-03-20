class ElectronSystem {
  ArrayList<Electron> particles;
  PVector origin;

  ElectronSystem() {
    particles = new ArrayList<Electron>();
  }

  void addParticle(float _t, float _r, PVector _c, float _xs, int phase) {
    particles.add(new Electron(_t, _r, _c, _xs, phase));
  }

  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Electron p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }
}

