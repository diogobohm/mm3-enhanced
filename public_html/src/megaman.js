/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function Megaman(map, x, y) {
	var tile_map = map; //Remove from the object later

	var character = new Character(map, 100, 64, x, y, getMMSpritesAsset());
	var sprite = character.sprite;
	var animation = character.animation;
	
	var anim_left_default = animation.left_anim.slice(3,4);
	var anim_left_default_blink = animation.left_anim.slice(4,5);
	var anim_left_start_walk = animation.left_anim.slice(5,6);
	var anim_left = animation.left_bounce_anim.slice(6,9);
	var anim_left_up = animation.left_anim.slice(9,10);
	var anim_left_default_shoot = animation.left_anim.slice(10,11);
	var anim_left_shoot = animation.left_bounce_anim.slice(11,14);
	var anim_left_up_shoot = animation.left_anim.slice(14,15);
	var anim_left_slide = animation.left_anim.slice(17,18);
	
	var anim_right_default = animation.right_anim.slice(3,4);
	var anim_right_default_blink = animation.right_anim.slice(4,5);
	var anim_right_start_walk = animation.right_anim.slice(5,6);
	var anim_right = animation.right_bounce_anim.slice(6,9);
	var anim_right_up = animation.right_anim.slice(9,10);
	var anim_right_default_shoot = animation.right_anim.slice(10,11);
	var anim_right_shoot = animation.right_bounce_anim.slice(11,14);
	var anim_right_up_shoot = animation.right_anim.slice(14,15);
	var anim_right_slide = animation.right_anim.slice(17,18);
	
	var shoot_counter = 0;

	sprite.setImage(anim_right_default.next());
	
	var removeShoot = function() {
		shoot_counter--;
	};

	var shootEvent = function () {
		if (shoot_counter < 3 && character.shootEvent()) {
			shoot_counter++;
			return true;
		}
		return false;
	}

	var getShootStartX = function() {
		return sprite.x + (character.isToRight()? sprite.width*0.25: -sprite.width * 0.75);
	};

	var getShootStartY = function() {
		return sprite.y-(sprite.height*0.65)-(character.isJumping()? sprite.height * 0.3:0);
	};

	var setSprite = function() {
		/* means the is on the ground and stopped, set default frames */
		if (character.isWalking()) {
			if (character.isToRight()) {
				if (character.isShooting()) {
					// Keep walking frames in sync
					sprite.setImage(anim_right_shoot.next());
					anim_right.next();
				} else {
					// Keep walking frames in sync
					sprite.setImage(anim_right.next());
					anim_right_shoot.next();
				}
			} else {
				if (character.isShooting()) {
					// Keep walking frames in sync
					sprite.setImage(anim_left_shoot.next());
					anim_left.next();
				} else {
					// Keep walking frames in sync
					sprite.setImage(anim_left.next());
					anim_left_shoot.next();
				}
			}
		} else if (character.isJumping()) {
			if (character.isToRight()) {
				if (character.isShooting()) {
					sprite.setImage(anim_right_up_shoot.next());
				} else {
					sprite.setImage(anim_right_up.next());
				}
			} else {
				if (character.isShooting()) {
					sprite.setImage(anim_left_up_shoot.next());
				} else {
					sprite.setImage(anim_left_up.next());
				}
			}
		} else if (character.isSliding()) {
			if (character.isToRight()) {
				sprite.setImage(anim_right_slide.next());
			} else {
				sprite.setImage(anim_left_slide.next());
			}
		} else {
			if (character.isToRight()) {
				if (character.isShooting()) {
					sprite.setImage(anim_right_default_shoot.next());
				} else {
					sprite.setImage(anim_right_default.next());
				}
			} else {
				if (character.isShooting()) {
					sprite.setImage(anim_left_default_shoot.next());
				} else {
					sprite.setImage(anim_left_default.next());
				}
			}
		}
	}

	var update = function () {
		setSprite();
		character.update();
	}

	/* Public functions */
	this.getShootStartX = getShootStartX;
	this.getShootStartY = getShootStartY;
	this.removeShoot = removeShoot;

	this.update = update;
	this.draw = character.draw;
	this.sprite = character.sprite;

	this.isToRight = character.isToRight;

	this.shootEvent = shootEvent;
	this.leftKeyEvent = character.leftKeyEvent;
	this.rightKeyEvent = character.rightKeyEvent;
	this.jumpEvent = character.jumpEvent;
	this.slideEvent = character.slideEvent;

	this.removeLife = character.removeLife;
	this.addLife = character.addLife;
	this.getLife = character.getLife;
	this.isAlive = character.isAlive;
}

