float pos = 9;
float speed = 0;
float gravity = -9.81;

float minBounceSpeed = 0.1;
float airFriction = 0.999;
float bounceFriction = 0.9;

// info: lower framerates requrie higher minBounceSpeed:
// 60+ fps: 0.1
// 30 fps: 0.2
// 15 fps: 0.3
float frameRate = 60;
float frameTime = 1 / frameRate;

float radius = 50;
int strokeWeight = 3;
int background = 200;

float clamp(float min, float v, float max) {
  return max(min, min(v, max));
}

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
    // apply gravity once in opposite direction
    // -> only bounces when the ball is more than 1 frame in the air
    // -> prevents infinite oscilation
    speed += -gravity * frameTime * bounceFriction;

    // flip speed and apply friction
    speed = -(speed * bounceFriction);

    // change color of the ball
    if(abs(speed) > minBounceSpeed) {
      fill(random(255), random(255), random(255));
    }
  }
  else {  // apply gravity
    speed += gravity * frameTime;
    speed *= airFriction;
  }
  
  // clear screen and draw ball
  background(background);
  float mappedPos = map(pos, 10, 0, radius + strokeWeight, height - radius - strokeWeight);
  circle(width/2, mappedPos, radius*2);
}
