
function MM3() {
	var player;
	var lemons;
	var blocks;
	var viewport;
	var map_enemies;

	var tile_map;

	this.gravity = 1;
	this.collide = function(rect) {
		return tile_map.atRect(rect);
	}

	/* Called once when a game state is activated. Use it for one-time setup code. */
	this.setup = function() {
		var live_info = document.getElementById("live_info");

		blocks = new jaws.SpriteList();
		var world = new jaws.Rect(0,0,320*10,320*2);

		/* We create some 32x32 blocks and save them in array blocks */
		for(var y = 0; y < world.height; y += 32 ) {
			blocks.push( new Sprite({image: getBlockSpritesAsset(), x: 0, y: y}) );
			blocks.push( new Sprite({image: getBlockSpritesAsset(), x: world.width-32, y: y}) );
		}
		for(var x = 0; x < world.width; x += 32 ) {
			blocks.push( new Sprite({image: getBlockSpritesAsset(), x: x, y: world.height-32}) );
		}
		for(var x = 320; x < world.width; x += 32 ) {
			blocks.push( new Sprite({image: getBlockSpritesAsset(), x: x, y: world.height-64}) );
		}
		for(var i=0; i < 50; i++) {
			blocks.push( new Sprite({image: getBlockSpritesAsset(), x: parseInt(Math.random()*100)*32, y: world.height - parseInt(Math.random()*10)*32}) );
		}

		// A tile map, each cell is 32x32 pixels. There's 100 such cells across and 100 downwards.
		// Fit all items in array blocks into correct cells in the tilemap
		// Later on we can look them up really fast (see player.update)
		tile_map = new jaws.TileMap({size: [100,100], cell_size: [32,32]});
		tile_map.push(blocks);

		viewport = new jaws.Viewport({max_x: world.width, max_y: world.height});

		var object_sprites = new jaws.Animation({sprite_sheet: getObjectSpritesAsset(), frame_size: [32,32], frame_duration: 200});

		player = new Megaman(tile_map, 110, 0);
		map_enemies = new SpriteList();
		map_enemies.push(new Met(tile_map, 300, 0))

		lemons = new SpriteList();
		lemons.sprite = object_sprites.slice(0,1).next();
		lemons.addLemon = function () {
			var lemon = new Sprite({image: lemons.sprite, x: player.getShootStartX(), y: player.getShootStartY()});
			lemon.incX = player.isToRight()? 10 : -10;
			lemon.update = function() {
				lemon.x += lemon.incX;

				var block = tile_map.atRect(lemon.rect())[0];
				if (block ||  viewport.isOutside(lemon)) {
					player.removeShoot();
					lemons.remove(lemon);
				}
			};
			lemons.push(lemon);
		};

		jaws.preventDefaultKeys(["down", "a", "left", "right", "s"]);
	};

	/* update() will get called each game tick with your specified FPS. Put game logic here. */
	this.update = function() {
		player.maintenance();

		if (jaws.pressed("left"))  {
			player.leftKeyEvent();
		}
		if (jaws.pressed("right")) {
			player.rightKeyEvent();
		}
		if (jaws.pressed("s")) {
			if (jaws.pressed("down")) {
				player.slideEvent();
				} else {
					player.jumpEvent();

			}
		}
		if (jaws.pressed("a")) {
			if (player.shootEvent()) {
				lemons.addLemon();
			}
		}

		// some gravity
		player.applyGravity(1);

		// apply vx / vy (x velocity / y velocity), check for collision detection in the process.
		player.update();
		lemons.update();
		map_enemies.update();

		// Tries to center viewport around player.x / player.y.
		// It won't go outside of 0 or outside of our previously specified max_x, max_y values.
		viewport.centerAround(player.getSprite());

		live_info.innerHTML = jaws.game_loop.fps + " fps. Player: " + parseInt(player.getSprite().x) + "/" + parseInt(player.getSprite().y) + ". ";
		live_info.innerHTML += "Viewport: " + parseInt(viewport.x) + "/" + parseInt(viewport.y) + ".";

	};

	/* Directly after each update draw() will be called. Put all your on-screen operations here. */
	this.draw = function() {
		jaws.clear();

		// the viewport magic. wrap all draw()-calls inside viewport.apply and it will draw those relative to the viewport.
		viewport.apply( function() {
			blocks.draw();
			player.getSprite().draw();
			map_enemies.draw();
			lemons.draw();
		});
	};
};