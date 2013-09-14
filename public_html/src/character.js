/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function Character(tile_map, life, size, x, y, image) {
	var max_life = life;

	var sprite = new jaws.Sprite({x: x, y: y, scale: 1, anchor: "center_bottom"});
	var animation = new AnimationManager(size, image);

	var vx = 0;
	var vy = 0;
	var can_jump = true;
	var can_shoot = true;
	var is_jumping = false;
	var is_sliding = false;
	var is_walking = false;
	var is_shooting = false;
	var shoot_counter = 0;
	var shoot_recovery = 0;
	var slide_recovery = 0;
	
	var is_to_right = true;

	sprite.setImage( animation.right_anim.slice(0,1).next() );

	var leftKeyEvent = function() {
		is_to_right = false;
		if (!is_sliding) {
			if (can_jump) {
				vx = -4;
				setWalking();
			} else {
				vx = -2;
			}
		}
	};

	var rightKeyEvent = function() {
		is_to_right = true;
		if (!is_sliding) {
			if (can_jump) {
				vx = 4;
				setWalking();
			} else {
				vx = 2;
			}
		}
	};

	var jumpEvent = function() {
		if (can_jump) {
			setJumping();
			vy = -20;
		}
	};

	var slideEvent = function() {
		if (can_jump && !is_sliding) {
			setSliding();
		}
	};

	var shootEvent = function() {
		if (can_shoot && !is_sliding) {
			is_shooting = true;
			can_shoot = false;
			shoot_recovery = 5;
			shoot_counter++;

			return true;			
		}
		return false;
	};

	var getLife = function() {
		return life;
	}

	var addLife = function(amount) {
		life = Math.max(Math.min(life + amount, max_life), 0);
		return life;
	};

	var removeLife = function(amount) {
		return addLife(-amount);
	};

	var isAlive = function() {
		return life > 0;
	}

	var setWalking = function() {
		is_walking = true;
		is_jumping = is_sliding = false;
	};
	
	var setJumping = function() {
		is_jumping = true;
		is_walking = is_sliding = false;
		can_jump = false;
	};
	
	var setSliding = function() {
		slide_recovery = 30;
		is_sliding = true;
		is_walking = is_jumping = false;
	};

	var isWalking = function() {
		return is_walking;
	};

	var isJumping = function() {
		return is_jumping;
	};

	var isSliding = function() {
		return is_sliding;
	};

	var isToRight = function() {
		return is_to_right;
	};

	var update = function() {
		/* TODO - dynamic gravity */
		vy += 1;

		is_walking = false;

		slide_recovery = Math.max(0, slide_recovery-1);
		if (slide_recovery === 0) {
			is_sliding = false;
		}
		vx = is_sliding? (is_to_right? 5 : -5) : vx;

		shoot_recovery = Math.max(0, shoot_recovery-1);
		if (shoot_recovery === 0 && shoot_counter < 3) {
			can_shoot = true;
			is_shooting = false;
		}

		if (vy !== 0) {
			setJumping();
		}

		sprite.x += vx;
		if(tile_map.atRect(sprite.rect()).length > 0) {
			sprite.x -= vx;
		}
		vx = 0;
		
		sprite.y += vy;
		var block = tile_map.atRect(sprite.rect())[0];
		if (block) {
			// Heading downwards
			if(vy > 0) {
				can_jump = true;
				is_jumping = false;
				sprite.y = block.rect().y - 1;
			}
			// Heading upwards (jumping)
			else if(vy < 0) {
				sprite.y = block.rect().bottom + sprite.height;
			}
			vy = 0;
		}
	};

	var draw = function() {
		sprite.draw();
	}

	/* Public members */
	this.sprite = sprite;
	this.draw = draw;
	this.animation = animation;

	this.addLife = addLife;
	this.removeLife = removeLife;
	this.isAlive = isAlive;
	this.update = update;

	this.isWalking = isWalking;
	this.isJumping = isJumping;
	this.isSliding = isSliding;
	this.isToRight = isToRight;

	this.leftKeyEvent = leftKeyEvent;
	this.rightKeyEvent = rightKeyEvent;
	this.jumpEvent = jumpEvent;
	this.slideEvent = slideEvent;
	this.shootEvent = shootEvent;
}

