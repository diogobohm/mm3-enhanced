/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

function Hitbox(sprite, offsetX, offsetY, width, height) {
	var rect = function() {
		return new jaws.Rect(sprite.x+offsetX, sprite.y+offsetY, width, height);
	};

	this.rect = rect;
}


