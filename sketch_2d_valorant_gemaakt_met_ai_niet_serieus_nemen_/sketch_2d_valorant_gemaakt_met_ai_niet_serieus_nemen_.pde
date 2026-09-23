// ============================================
//  2D VALORANT-ACHTIGE GAME
//  WASD = bewegen | Muis = richten | LMB = schieten
//  R = herladen | F = flash | Spatie = sprint
// ============================================

Player player;
ArrayList<Enemy> enemies;
ArrayList<Bullet> bullets;
ArrayList<Wall> walls;
ArrayList<Particle> particles;

int score = 0;
int round = 1;
boolean gameOver = false;
boolean roundOver = false;
int roundTimer = 0;
PFont font;

void setup() {
  size(1200, 700);
  font = createFont("Arial", 16);
  textFont(font);
  
  resetGame();
}

void resetGame() {
  player = new Player(width/2, height - 80);
  enemies = new ArrayList<Enemy>();
  bullets = new ArrayList<Bullet>();
  walls = new ArrayList<Wall>();
  particles = new ArrayList<Particle>();
  
  // Muren (cover)
  walls.add(new Wall(200, 150, 180, 30));
  walls.add(new Wall(800, 150, 180, 30));
  walls.add(new Wall(500, 280, 200, 30));
  walls.add(new Wall(100, 400, 120, 30));
  walls.add(new Wall(980, 400, 120, 30));
  walls.add(new Wall(350, 500, 150, 30));
  walls.add(new Wall(700, 500, 150, 30));
  
  // Verticale muren
  walls.add(new Wall(400, 100, 30, 120));
  walls.add(new Wall(770, 100, 30, 120));
  walls.add(new Wall(580, 350, 30, 100));
  
  spawnEnemies();
  score = 0;
  round = 1;
  gameOver = false;
  roundOver = false;
}

void spawnEnemies() {
  enemies.clear();
  int count = 3 + round;          // meer vijanden per ronde
  for (int i = 0; i < count; i++) {
    float x = random(80, width - 80);
    float y = random(60, 250);
    enemies.add(new Enemy(x, y));
  }
}

void draw() {
  background(30, 35, 45);
  
  // Grid (Valorant-achtig gevoel)
  stroke(50, 55, 70);
  strokeWeight(1);
  for (int x = 0; x < width; x += 40) line(x, 0, x, height);
  for (int y = 0; y < height; y += 40) line(0, y, width, y);
  
  if (gameOver) {
    drawGameOver();
    return;
  }
  
  // Update & draw
  for (Wall w : walls) w.display();
  
  player.update();
  player.display();
  
  for (int i = enemies.size() - 1; i >= 0; i--) {
    Enemy e = enemies.get(i);
    e.update();
    e.display();
    if (e.health <= 0) {
      score += 100;
      createExplosion(e.x, e.y, color(255, 80, 80));
      enemies.remove(i);
    }
  }
  
  // Bullets
  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    b.display();
    
    // Muur hit
    boolean hitWall = false;
    for (Wall w : walls) {
      if (w.hits(b.x, b.y)) {
        hitWall = true;
        createSparks(b.x, b.y);
        break;
      }
    }
    if (hitWall || b.offscreen()) {
      bullets.remove(i);
      continue;
    }
    
    // Speler geraakt
    if (b.fromEnemy && dist(b.x, b.y, player.x, player.y) < 18) {
      player.takeDamage(b.damage);
      createSparks(b.x, b.y);
      bullets.remove(i);
      continue;
    }
    
    // Vijand geraakt
    if (!b.fromEnemy) {
      for (Enemy e : enemies) {
        if (dist(b.x, b.y, e.x, e.y) < 18) {
          e.takeDamage(b.damage);
          createSparks(b.x, b.y);
          bullets.remove(i);
          break;
        }
      }
    }
  }
  
  // Particles
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.display();
    if (p.life <= 0) particles.remove(i);
  }
  
  // Ronde check
  if (enemies.size() == 0 && !roundOver) {
    roundOver = true;
    roundTimer = 120; // 2 seconden
  }
  
  if (roundOver) {
    roundTimer--;
    fill(0, 180);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("RONDE " + round + " GEWONNEN!", width/2, height/2 - 20);
    textSize(18);
    text("Volgende ronde over " + (roundTimer/60 + 1) + "...", width/2, height/2 + 20);
    
    if (roundTimer <= 0) {
      round++;
      spawnEnemies();
      player.health = player.maxHealth;
      player.ammo = player.maxAmmo;
      roundOver = false;
    }
  }
  
  drawHUD();
  
  if (player.health <= 0) {
    gameOver = true;
  }
}

void drawHUD() {
  // Health bar
  fill(40);
  rect(20, height - 50, 220, 28, 6);
  fill(player.health > 40 ? color(80, 220, 120) : color(220, 80, 80));
  float hw = map(player.health, 0, player.maxHealth, 0, 216);
  rect(22, height - 48, hw, 24, 4);
  
  fill(255);
  textAlign(LEFT);
  textSize(14);
  text("HP  " + int(player.health), 30, height - 30);
  
  // Ammo
  text("AMMO  " + player.ammo + " / " + player.maxAmmo, 260, height - 30);
  
  // Ability
  fill(player.flashReady ? color(100, 200, 255) : color(80));
  rect(420, height - 50, 90, 28, 6);
  fill(255);
  text("FLASH [F]", 430, height - 30);
  
  // Score + Round
  textAlign(RIGHT);
  text("SCORE  " + score, width - 30, height - 30);
  text("RONDE  " + round, width - 30, height - 50);
  
  // Crosshair
  stroke(255, 200);
  strokeWeight(2);
  noFill();
  line(mouseX - 12, mouseY, mouseX - 4, mouseY);
  line(mouseX + 4, mouseY, mouseX + 12, mouseY);
  line(mouseX, mouseY - 12, mouseX, mouseY - 4);
  line(mouseX, mouseY + 4, mouseX, mouseY + 12);
  noStroke();
}

void drawGameOver() {
  fill(0, 180);
  rect(0, 0, width, height);
  fill(255);
  textAlign(CENTER);
  textSize(48);
  text("ELIMINATED", width/2, height/2 - 40);
  textSize(22);
  text("Score: " + score + "   |   Rondes: " + (round - 1), width/2, height/2 + 10);
  textSize(16);
  text("Druk op R om opnieuw te beginnen", width/2, height/2 + 50);
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    if (gameOver) resetGame();
    else player.reload();
  }
  if (key == 'f' || key == 'F') player.useFlash();
  if (key == ' ') player.sprinting = true;
  
  player.setKey(key, true);
}

void keyReleased() {
  if (key == ' ') player.sprinting = false;
  player.setKey(key, false);
}

void mousePressed() {
  if (!gameOver && !roundOver && mouseButton == LEFT) {
    player.shoot();
  }
}

// ====================== CLASSES ======================

class Player {
  float x, y;
  float speed = 3.2;
  float angle;
  float health = 100;
  float maxHealth = 100;
  int ammo = 12;
  int maxAmmo = 12;
  int reloadTimer = 0;
  boolean reloading = false;
  boolean sprinting = false;
  boolean flashReady = true;
  int flashCooldown = 0;
  
  boolean up, down, left, right;
  
  Player(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void setKey(char k, boolean pressed) {
    if (k == 'w' || k == 'W') up = pressed;
    if (k == 's' || k == 'S') down = pressed;
    if (k == 'a' || k == 'A') left = pressed;
    if (k == 'd' || k == 'D') right = pressed;
  }
  
  void update() {
    angle = atan2(mouseY - y, mouseX - x);
    
    float sp = sprinting ? speed * 1.45 : speed;
    float dx = 0, dy = 0;
    if (up) dy -= sp;
    if (down) dy += sp;
    if (left) dx -= sp;
    if (right) dx += sp;
    
    // Normaliseren
    if (dx != 0 && dy != 0) {
      dx *= 0.707;
      dy *= 0.707;
    }
    
    float newX = x + dx;
    float newY = y + dy;
    
    // Collision met muren
    if (!collides(newX, y)) x = newX;
    if (!collides(x, newY)) y = newY;
    
    x = constrain(x, 20, width - 20);
    y = constrain(y, 20, height - 20);
    
    if (reloading) {
      reloadTimer--;
      if (reloadTimer <= 0) {
        ammo = maxAmmo;
        reloading = false;
      }
    }
    
    if (flashCooldown > 0) {
      flashCooldown--;
      if (flashCooldown <= 0) flashReady = true;
    }
  }
  
  boolean collides(float px, float py) {
    for (Wall w : walls) {
      if (px > w.x && px < w.x + w.w && py > w.y && py < w.y + w.h) return true;
    }
    return false;
  }
  
  void shoot() {
    if (reloading || ammo <= 0) return;
    ammo--;
    float bx = x + cos(angle) * 25;
    float by = y + sin(angle) * 25;
    bullets.add(new Bullet(bx, by, angle, false, 25));
    
    // Recoil effect
    createSparks(bx, by);
  }
  
  void reload() {
    if (!reloading && ammo < maxAmmo) {
      reloading = true;
      reloadTimer = 90; // 1.5 sec
    }
  }
  
  void useFlash() {
    if (!flashReady) return;
    flashReady = false;
    flashCooldown = 300; // 5 sec
    
    // Flash effect op vijanden in de buurt
    for (Enemy e : enemies) {
      if (dist(x, y, e.x, e.y) < 280) {
        e.flashed = 90; // 1.5 sec blinded
      }
    }
    
    // Visueel flash
    for (int i = 0; i < 30; i++) {
      particles.add(new Particle(x, y, color(255, 255, 200), 4));
    }
  }
  
  void takeDamage(float dmg) {
    health -= dmg;
    createSparks(x, y);
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    
    // Lichaam
    fill(80, 160, 255);
    stroke(40);
    strokeWeight(2);
    ellipse(0, 0, 32, 32);
    
    // Wapen
    fill(60);
    rect(10, -4, 28, 8, 2);
    
    popMatrix();
    
    // Reload indicator
    if (reloading) {
      noFill();
      stroke(255, 200);
      strokeWeight(3);
      arc(x, y, 45, 45, 0, map(reloadTimer, 90, 0, 0, TWO_PI));
    }
  }
}

class Enemy {
  float x, y;
  float speed = 1.4;
  float health = 80;
  float maxHealth = 80;
  float angle;
  int shootCooldown = 0;
  int flashed = 0;
  
  Enemy(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void update() {
    if (flashed > 0) {
      flashed--;
      return; // kan niet bewegen of schieten
    }
    
    // Beweeg richting speler (met een beetje AI)
    float dx = player.x - x;
    float dy = player.y - y;
    float dist = sqrt(dx*dx + dy*dy);
    
    if (dist > 180) {
      // Dichterbij komen
      x += (dx / dist) * speed;
      y += (dy / dist) * speed;
    } else if (dist < 120) {
      // Wegdraaien
      x -= (dx / dist) * speed * 0.7;
      y -= (dy / dist) * speed * 0.7;
    }
    
    // Simpele muur-ontwijking
    for (Wall w : walls) {
      if (x > w.x - 10 && x < w.x + w.w + 10 && y > w.y - 10 && y < w.y + w.h + 10) {
        if (x < w.x) x -= 2;
        else if (x > w.x + w.w) x += 2;
        if (y < w.y) y -= 2;
        else if (y > w.y + w.h) y += 2;
      }
    }
    
    angle = atan2(player.y - y, player.x - x);
    
    // Schieten
    shootCooldown--;
    if (shootCooldown <= 0 && dist < 450 && dist > 80) {
      // Alleen schieten als er geen muur tussen zit (simpele check)
      boolean clear = true;
      float steps = dist / 10;
      for (int i = 1; i < steps; i++) {
        float px = x + cos(angle) * i * 10;
        float py = y + sin(angle) * i * 10;
        for (Wall w : walls) {
          if (w.hits(px, py)) {
            clear = false;
            break;
          }
        }
        if (!clear) break;
      }
      
      if (clear) {
        bullets.add(new Bullet(x + cos(angle)*20, y + sin(angle)*20, angle, true, 18));
        shootCooldown = int(random(40, 80));
      }
    }
  }
  
  void takeDamage(float dmg) {
    health -= dmg;
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    
    fill(flashed > 0 ? color(255, 255, 100) : color(220, 70, 70));
    stroke(40);
    strokeWeight(2);
    ellipse(0, 0, 30, 30);
    
    // Wapen
    fill(50);
    rect(8, -3, 22, 6, 2);
    
    popMatrix();
    
    // Health bar
    if (health < maxHealth) {
      fill(40);
      rect(x - 18, y - 28, 36, 6);
      fill(220, 60, 60);
      rect(x - 18, y - 28, map(health, 0, maxHealth, 0, 36), 6);
    }
  }
}

class Bullet {
  float x, y;
  float vx, vy;
  boolean fromEnemy;
  float damage;
  float speed = 14;
  
  Bullet(float x, float y, float angle, boolean fromEnemy, float damage) {
    this.x = x;
    this.y = y;
    this.fromEnemy = fromEnemy;
    this.damage = damage;
    vx = cos(angle) * speed;
    vy = sin(angle) * speed;
  }
  
  void update() {
    x += vx;
    y += vy;
  }
  
  void display() {
    fill(fromEnemy ? color(255, 100, 100) : color(255, 230, 100));
    noStroke();
    ellipse(x, y, 7, 7);
  }
  
  boolean offscreen() {
    return x < -20 || x > width + 20 || y < -20 || y > height + 20;
  }
}

class Wall {
  float x, y, w, h;
  
  Wall(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display() {
    fill(70, 75, 90);
    stroke(40);
    strokeWeight(2);
    rect(x, y, w, h, 4);
    
    // Highlight
    fill(90, 95, 110);
    noStroke();
    rect(x + 3, y + 3, w - 6, 6, 2);
  }
  
  boolean hits(float px, float py) {
    return px > x && px < x + w && py > y && py < y + h;
  }
}

class Particle {
  float x, y;
  float vx, vy;
  color c;
  float life;
  float size;
  
  Particle(float x, float y, color c, float size) {
    this.x = x;
    this.y = y;
    this.c = c;
    this.size = size;
    life = 30;
    vx = random(-3, 3);
    vy = random(-3, 3);
  }
  
  void update() {
    x += vx;
    y += vy;
    life--;
    size *= 0.95;
  }
  
  void display() {
    fill(c, map(life, 0, 30, 0, 255));
    noStroke();
    ellipse(x, y, size, size);
  }
}

void createSparks(float x, float y) {
  for (int i = 0; i < 6; i++) {
    particles.add(new Particle(x, y, color(255, 200, 50), 3));
  }
}

void createExplosion(float x, float y, color c) {
  for (int i = 0; i < 18; i++) {
    particles.add(new Particle(x, y, c, 5));
  }
}
