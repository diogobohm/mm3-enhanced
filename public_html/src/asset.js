/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function getAssets() {
	return [
		getMMSpritesAsset(),
		getMMFlippedSpritesAsset(),
		getObjectSpritesAsset(),
		getBlockSpritesAsset(),
	];
}

function getImageDir() {
	return "img";
}

function getMMSpritesAsset() {
	return getImageDir()+"/mm_64.png";
}

function getMMFlippedSpritesAsset() {
	return getImageDir()+"/mm_64_flipped.png";
}

function getObjectSpritesAsset() {
	return getImageDir()+"/objects_32.png";
}

function getBlockSpritesAsset() {
	return getImageDir()+"/block.png";
}

