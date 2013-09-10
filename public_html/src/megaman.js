/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function Player(map) {
	var tile_map = map; //Remove from the object later

	var sprite = new jaws.Sprite({x:110, y:320, scale: 1, anchor: "center_bottom"});
	
	var right_anim = new jaws.Animation({sprite_sheet: getMMSpritesAsset(), frame_size: [64,64], frame_duration: 200});
	var right_walk_anim = new jaws.Animation({bounce: true, sprite_sheet: getMMSpritesAsset(), frame_size: [64,64], frame_duration: 200});
	var left_anim = new jaws.Animation({sprite_sheet: getMMFlippedSpritesAsset(), frame_size: [64,64], frame_duration: 200});
	var left_walk_anim = new jaws.Animation({bounce: true, sprite_sheet: getMMFlippedSpritesAsset(), frame_size: [64,64], frame_duration: 200});
	
	var anim_left_default = left_anim.slice(3,4);
	var anim_left_default_blink = left_anim.slice(4,5);
	var anim_left_start_walk = left_anim.slice(5,6);
	var anim_left = left_walk_anim.slice(6,9);
	var anim_left_up = left_anim.slice(9,10);
	var anim_left_default_shoot = left_anim.slice(10,11);
	var anim_left_shoot = left_walk_anim.slice(11,14);
	var anim_left_up_shoot = left_anim.slice(14,15);
	var anim_left_slide = left_anim.slice(17,18);
	
	var anim_right_default = right_anim.slice(3,4);
	var anim_right_default_blink = right_anim.slice(4,5);
	var anim_right_start_walk = right_anim.slice(5,6);
	var anim_right = right_walk_anim.slice(6,9);
	var anim_right_up = right_anim.slice(9,10);
	var anim_right_default_shoot = right_anim.slice(10,11);
	var anim_right_shoot = right_walk_anim.slice(11,14);
	var anim_right_up_shoot = right_anim.slice(14,15);
	var anim_right_slide = right_anim.slice(17,18);
	
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

	sprite.setImage( anim_right_default.next() );
	
	this.update = function() {
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
		
		/* means the is on the ground and stopped, set default frames */
		if (is_walking) {
			if (is_to_right) {
				if (is_shooting) {
					// Keep walking frames in sync
					sprite.setImage(anim_right_shoot.next());
					anim_right.next();
				} else {
					// Keep walking frames in sync
					sprite.setImage(anim_right.next());
					anim_right_shoot.next();
				}
			} else {
				if (is_shooting) {
					// Keep walking frames in sync
					sprite.setImage(anim_left_shoot.next());
					anim_left.next();
				} else {
					// Keep walking frames in sync
					sprite.setImage(anim_left.next());
					anim_left_shoot.next();
				}
			}
		} else if (is_jumping) {
			if (is_to_right) {
				if (is_shooting) {
					sprite.setImage(anim_right_up_shoot.next());
				} else {
					sprite.setImage(anim_right_up.next());
				}
			} else {
				if (is_shooting) {
					sprite.setImage(anim_left_up_shoot.next());
				} else {
					sprite.setImage(anim_left_up.next());
				}
			}
		} else if (is_sliding) {
			if (is_to_right) {
				sprite.setImage(anim_right_slide.next());
			} else {
				sprite.setImage(anim_left_slide.next());
			}
		} else {
			if (is_to_right) {
				if (is_shooting) {
					sprite.setImage(anim_right_default_shoot.next());
				} else {
					sprite.setImage(anim_right_default.next());
				}
			} else {
				if (is_shooting) {
					sprite.setImage(anim_left_default_shoot.next());
				} else {
					sprite.setImage(anim_left_default.next());
				}
			}
		}
	};

	this.getSprite = function() {
		return sprite;
	}
	
	this.setWalking = function() {
		is_walking = true;
		is_jumping = is_sliding = false;
	};
	
	this.setJumping = function() {
		is_jumping = true;
		is_walking = is_sliding = false;
		can_jump = false;
	};
	
	this.setSliding = function() {
		slide_recovery = 30;
		is_sliding = true;
		is_walking = is_jumping = false;
	};

	this.isToRight = function() {
		return is_to_right;
	};

	this.applyGravity = function(acceleration) {
		vy += acceleration;
	};

	this.maintenance = function() {
		is_walking = false;

		slide_recovery = Math.max(0, slide_recovery-1);
		if (slide_recovery === 0) {
			is_sliding = false;
		}
		vx = is_sliding? (is_to_right? 5 : -5) : 0;

		shoot_recovery = Math.max(0, shoot_recovery-1);
		if (shoot_recovery === 0 && shoot_counter < 3) {
			can_shoot = true;
			is_shooting = false;
		}

		if (vy !== 0) {
			this.setJumping();
		}
	};

	this.leftKeyEvent = function() {
		is_to_right = false;
		if (!is_sliding) {
			if (can_jump) {
				vx = -4;
				this.setWalking();
			} else {
				vx = -2;
			}
		}
	};

	this.rightKeyEvent = function() {
		is_to_right = true;
		if (!is_sliding) {
			if (can_jump) {
				vx = 4;
				this.setWalking();
			} else {
				vx = 2;
			}
		}
	};

	this.jumpEvent = function() {
		if (can_jump) {
			this.setJumping();
			vy = -20;
		}
	};

	this.slideEvent = function() {
		if (can_jump && !is_sliding) {
			this.setSliding();
		}
	};

	this.shootEvent = function() {
		if (can_shoot && !is_sliding) {
			is_shooting = true;
			can_shoot = false;
			shoot_recovery = 5;
			shoot_counter++;

			return true;			
		}
		return false;
	};

	this.removeShoot = function() {
		shoot_counter--;
	};

	this.getShootStartX = function() {
		return sprite.x + (is_to_right? sprite.width*0.25: -sprite.width*0.75);
	};

	this.getShootStartY = function() {
		return sprite.y-(sprite.height*0.65)-(is_jumping?sprite.height*0.3:0);
	};
}

