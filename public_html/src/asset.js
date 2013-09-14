/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function getAssets() {
	return [
		getMMSpritesAsset(),
		getObjectSpritesAsset(),
		getBlockSpritesAsset(),
		getMetSpritesAsset(),
	];
}

function getImageDir() {
	return "img";
}

function getMMSpritesAsset() {
	return getImageDir()+"/mm_64.png";
}

function getObjectSpritesAsset() {
	return getImageDir()+"/objects_32.png";
}

function getBlockSpritesAsset() {
	return getImageDir()+"/block.png";
}

function getMetSpritesAsset() {
	return getImageDir()+"/met_64.png";
}

