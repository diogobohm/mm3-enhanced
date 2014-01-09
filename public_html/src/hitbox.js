/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function Hitbox(sprite, offsetX, offsetY, width, height) {
	var area = new jaws.Rect(sprite.x-(sprite.width/2)+offsetX, sprite.y-sprite.height+offsetX, width, height);
	
	var create = function() {
		return new jaws.Rect(sprite.x-(sprite.width/2)+offsetX, sprite.y-sprite.height+offsetX, width, height);
	}
	
	var rect = function() {
		return area;
	};
	
	var update = function() {
		//TODO: update correctly, no new instances.
		area = create();
	}
	
	var draw = function() {
		area.draw();
	}

	this.rect = rect;
	this.update = update;
	this.draw = draw;
}
