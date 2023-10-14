


var xDirection = keyboard_check(ord("D")) - keyboard_check(ord("A")); //Press D to go left, A to go right
var jump = keyboard_check_pressed(vk_space); //Spacebar jump
var dash = keyboard_check_pressed(vk_shift); // Shift to dash
var onTheGround = place_meeting(x, y + 1, oWall); //Checks if the player is touching the ground 1 pixel off the sprite

if (xDirection != 0) image_xscale = xDirection; //Changes direction of sprite of plauyer based on direction

if (!dashing) xSpeed = xDirection * spd; //Move at the set speed
ySpeed++; //Player being pulled down by gravity

if (onTheGround) { //Is the player on the ground?
	if (xDirection != 0 && dashing) {
		sprite_index = sPlayerDash; // If moving AND dashing, play the dash animation
	} 
	else if (xDirection != 0) {
		sprite_index = sPlayerRun_strip7; // If only moving, play the move animation
	}
	else { sprite_index = sPlayerIdle_strip4; } //Else idle animation

	if (jump) {
		ySpeed = -15; //If player jumps move up by 15 pixels
	}
	
} 
else if (dashing) {
	sprite_index = sPlayerDash;
}
else { //If not on ground do the jump animation
	sprite_index = sPlayerJump;
}

if (dash && xDirection != 0 && !dashing) {
	xSpeed = xDirection * 25;
	
	dashing = true;
}

if (dashing) {
	if (xSpeed > spd + 2) {
		xSpeed -= 1;
		ySpeed  = 0;
	}
	else if (xSpeed < spd - 2) {
		xSpeed += 1;
		ySpeed  = 0;
	}
	else {
		dashing = false;
	}
}

if (place_meeting(x + xSpeed, y, oWall)) { //Are they colliding with a wall or not?
	
	while (!place_meeting(x + sign(xSpeed), y, oWall)) {
		x += sign(xSpeed);
	}
	
	xSpeed = 0; 
}

x += xSpeed;


if (place_meeting(x, y + ySpeed, oWall)) { //Are they colliding with a wall or not?
	
	while (!place_meeting(x, y + sign(ySpeed), oWall)) {
		y += sign(ySpeed);
	}
	
	ySpeed = 0; 
}

y += ySpeed;