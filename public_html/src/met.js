/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function Met(map, x, y) {
	var tile_map = map; //Remove from the object later

	var character = new Character(map, 100, 64, x, y, getMetSpritesAsset());
	var sprite = character.sprite;
	var animation = character.animation;
	
	var anim_left_default = animation.left_anim.slice(1,2);
	var anim_right_default = animation.right_anim.slice(1,2);

	var anim_left = animation.left_bounce_anim.slice(0,3);
	var anim_right = animation.right_bounce_anim.slice(0,3);
	

	var getSprite = function() {
		return sprite;
	}
	
	var removeShoot = function() {
		shoot_counter--;
	};

	var getShootStartX = function() {
		return sprite.x + (is_to_right? sprite.width*0.25: -sprite.width*0.75);
	};

	var getShootStartY = function() {
		return sprite.y-(sprite.height*0.65)-(is_jumping?sprite.height*0.3:0);
	};

	var left_right = 0;
	var autoPilot = function() {
		left_right += character.isToRight()? 1 : -1;
		if (left_right >= 50) {
			character.leftKeyEvent();			
		} else if (left_right <= 0) {
			character.rightKeyEvent();			
		} else {
			if (character.isToRight()) {
				character.rightKeyEvent();			
			} else {
				character.leftKeyEvent();			
			}
		}
	}

	var setSprite = function() {
		/* means the is on the ground and stopped, set default frames */
		if (character.isWalking()) {
			if (character.isToRight()) {
				sprite.setImage(anim_right.next());
				anim_left.next();
			} else {
				anim_right.next();
				sprite.setImage(anim_left.next());
			}
		} else {
			if (character.isToRight()) {
				sprite.setImage(anim_right_default.next());
				anim_left_default.next();
			} else {
				anim_right_default.next();
				sprite.setImage(anim_left_default.next());
			}
		}
	}

	var update = function () {
		autoPilot();
		setSprite();
		character.update();
	}

	/* Public functions */
	this.getShootStartX = getShootStartX;
	this.getShootStartY = getShootStartY;
	this.removeShoot = removeShoot;

	this.draw = character.draw;
	this.update = update;
	this.getSprite = getSprite;
}
