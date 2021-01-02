float vheight = 3;
float pos = 0.9 * vheight;
float speed = 0;
float gravity = -9.81;

float frameRate = 60;
float frameTime = 1 / frameRate;

float airFriction = 0.999;
float bounceFriction = 0.9;
float minBounceSpeed = abs(frameTime * gravity * bounceFriction * 0.9);

float radius = 50;
int strokeWeight = 3;
int background = 200;

void setup() {
  size(1024, 1024);
  frameRate(frameRate);
  strokeWeight(strokeWeight);
  fill(random(255), random(255), random(255));
}

void draw() {
  // update position
  pos += speed * frameTime;
  
  if(pos <= 0) { // collision
    pos = 0;

    // flip speed and apply friction
    speed = -(speed * bounceFriction);

    // change color of the ball
    if(abs(speed) > minBounceSpeed) {
      fill(random(255), random(255), random(255));
    }
  }
  
  speed += gravity * frameTime;
  speed *= airFriction;
  
  // clear screen and draw ball
  background(background);
  float mappedPos = map(pos, vheight, 0, radius + strokeWeight, height - radius - strokeWeight);
  circle(width/2, mappedPos, radius*2);
}
