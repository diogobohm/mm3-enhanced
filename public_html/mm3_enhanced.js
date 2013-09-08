
function MM3() {
	var player;
	var lemons;
	var blocks;
	var viewport;
	var tile_map;

	/* Called once when a game state is activated. Use it for one-time setup code. */
	this.setup = function() {
		live_info = document.getElementById("live_info");

		blocks = new jaws.SpriteList();
		var world = new jaws.Rect(0,0,320*10,320*2);

		/* We create some 32x32 blocks and save them in array blocks */
		for(var y = 0; y < world.height; y += 32 ) {
			blocks.push( new Sprite({image: "block.png", x: 0, y: y}) );
			blocks.push( new Sprite({image: "block.png", x: world.width-32, y: y}) );
		}
		for(var x = 0; x < world.width; x += 32 ) {
			blocks.push( new Sprite({image: "block.png", x: x, y: world.height-32}) );
		}
		for(var x = 320; x < world.width; x += 32 ) {
			blocks.push( new Sprite({image: "block.png", x: x, y: world.height-64}) );
		}
		for(var i=0; i < 50; i++) {
			blocks.push( new Sprite({image: "block.png", x: parseInt(Math.random()*100)*32, y: world.height - parseInt(Math.random()*10)*32}) );
		}

		// A tile map, each cell is 32x32 pixels. There's 100 such cells across and 100 downwards.
		// Fit all items in array blocks into correct cells in the tilemap
		// Later on we can look them up really fast (see player.update)
		tile_map = new jaws.TileMap({size: [100,100], cell_size: [32,32]});
		tile_map.push(blocks);

		viewport = new jaws.Viewport({max_x: world.width, max_y: world.height});

		player = new jaws.Sprite({x:110, y:320, scale: 1, anchor: "center_bottom"});

		var right_anim = new jaws.Animation({sprite_sheet: "mm_64.png", frame_size: [64,64], frame_duration: 200});
		var right_walk_anim = new jaws.Animation({bounce: true, sprite_sheet: "mm_64.png", frame_size: [64,64], frame_duration: 200});
		var left_anim = new jaws.Animation({sprite_sheet: "mm_64_flipped.png", frame_size: [64,64], frame_duration: 200});
		var left_walk_anim = new jaws.Animation({bounce: true, sprite_sheet: "mm_64_flipped.png", frame_size: [64,64], frame_duration: 200});

		player.anim_left_default = left_anim.slice(3,4);
		player.anim_left_default_blink = left_anim.slice(4,5);
		player.anim_left_start_walk = left_anim.slice(5,6);
		player.anim_left = left_walk_anim.slice(6,9);
		player.anim_left_up = left_anim.slice(9,10);
		player.anim_left_default_shoot = left_anim.slice(10,11);
		player.anim_left_shoot = left_walk_anim.slice(11,14);
		player.anim_left_up_shoot = left_anim.slice(14,15);
		player.anim_left_slide = left_anim.slice(17,18);

		player.anim_right_default = right_anim.slice(3,4);
		player.anim_right_default_blink = right_anim.slice(4,5);
		player.anim_right_start_walk = right_anim.slice(5,6);
		player.anim_right = right_walk_anim.slice(6,9);
		player.anim_right_up = right_anim.slice(9,10);
		player.anim_right_default_shoot = right_anim.slice(10,11);
		player.anim_right_shoot = right_walk_anim.slice(11,14);
		player.anim_right_up_shoot = right_anim.slice(14,15);
		player.anim_right_slide = right_anim.slice(17,18);

		player.vx = player.vy = 0;
		player.can_jump = true;
		player.can_shoot = true;
		player.is_jumping = false;
		player.is_sliding = false;
		player.is_walking = false;
		player.is_shooting = false;
		player.shoot_counter = 0;
		player.shoot_recovery = 0;
		player.slide_recovery = 0;

		player.is_to_right = true;
		player.setImage( player.anim_right_default.next() );

		player.update = function() {
			player.x += player.vx;
			if(tile_map.atRect(player.rect()).length > 0) {
				player.x -= player.vx;
			}
			player.vx = 0;

			player.y += player.vy;
			var block = tile_map.atRect(player.rect())[0];
			if (block) {
				// Heading downwards
				if(player.vy > 0) {
					player.can_jump = true;
					player.is_jumping = false;
					player.y = block.rect().y - 1;
				}
				// Heading upwards (jumping)
				else if(player.vy < 0) {
					player.y = block.rect().bottom + player.height;
				}
				player.vy = 0;
			}

			/* player means the is on the ground and stopped, set default frames */
			if (player.is_walking) {
				if (player.is_to_right) {
					if (player.is_shooting) {
						// Keep walking frames in sync
						player.setImage(player.anim_right_shoot.next());
						player.anim_right.next();
					} else {
						// Keep walking frames in sync
						player.setImage(player.anim_right.next());
						player.anim_right_shoot.next();
					}
				} else {
					if (player.is_shooting) {
						// Keep walking frames in sync
						player.setImage(player.anim_left_shoot.next());
						player.anim_left.next();
					} else {
						// Keep walking frames in sync
						player.setImage(player.anim_left.next());
						player.anim_left_shoot.next();
					}
				}
			} else if (player.is_jumping) {
				if (player.is_to_right) {
					if (player.is_shooting) {
						player.setImage(player.anim_right_up_shoot.next());
					} else {
						player.setImage(player.anim_right_up.next());
					}
				} else {
					if (player.is_shooting) {
						player.setImage(player.anim_left_up_shoot.next());
					} else {
						player.setImage(player.anim_left_up.next());
					}
				}
			} else if (player.is_sliding) {
				if (player.is_to_right) {
					player.setImage(player.anim_right_slide.next());
				} else {
					player.setImage(player.anim_left_slide.next());
				}
			} else {
				if (player.is_to_right) {
					if (player.is_shooting) {
						player.setImage(player.anim_right_default_shoot.next());
					} else {
						player.setImage(player.anim_right_default.next());
					}
				} else {
					if (player.is_shooting) {
						player.setImage(player.anim_left_default_shoot.next());
					} else {
						player.setImage(player.anim_left_default.next());
					}
				}
			}
		};

		player.setWalking = function() {
			player.is_walking = true;
			player.is_jumping = player.is_sliding = false;
		};

		player.setJumping = function() {
			player.is_jumping = true;
			player.is_walking = player.is_sliding = false;
			player.can_jump = false;
		};

		player.setSliding = function() {
			player.slide_recovery = 30;
			player.is_sliding = true;
			player.is_walking = player.is_jumping = false;
		};

		var object_sprites = new jaws.Animation({sprite_sheet: "objects_32.png", frame_size: [32,32], frame_duration: 200});
		lemons = new SpriteList();
		lemons.sprite = object_sprites.slice(0,1).next();
		lemons.addLemon = function () {
			var lemon = new Sprite({image: lemons.sprite, x: player.x, y: player.y-(player.height*0.65)});
			lemon.x += player.is_to_right? player.width*0.25: -player.width*0.75;
			if (player.is_jumping) {
				lemon.y -= player.height*0.3;
			}
			lemon.incX = player.is_to_right? 10 : -10;
			lemon.update = function() {
				lemon.x += lemon.incX;

				var block = tile_map.atRect(lemon.rect())[0];
				if (block ||  viewport.isOutside(lemon)) {
					player.shoot_counter--;
					lemons.remove(lemon);
				}
			};
			lemons.push(lemon);
		};


		jaws.preventDefaultKeys(["down", "a", "left", "right", "s"]);
	};

	/* update() will get called each game tick with your specified FPS. Put game logic here. */
	this.update = function() {
		player.is_walking = false;

		player.slide_recovery = Math.max(0, player.slide_recovery-1);
		if (player.slide_recovery === 0) {
			player.is_sliding = false;
		}
		player.vx = player.is_sliding? (player.is_to_right? 5 : -5) : 0;

		player.shoot_recovery = Math.max(0, player.shoot_recovery-1);
		if (player.shoot_recovery === 0 && player.shoot_counter < 3) {
			player.can_shoot = true;
			player.is_shooting = false;
		}

		if (player.vy !== 0) {
			player.setJumping();
		}

		if (jaws.pressed("left"))  {
			player.is_to_right = false;
			if (!player.is_sliding) {
				if (player.can_jump) {
					player.vx = -4;
					player.setWalking();
				} else {
					player.vx = -2;
				}
			}
		}
		if (jaws.pressed("right")) {
			player.is_to_right = true;
			if (!player.is_sliding) {
				if (player.can_jump) {
					player.vx = 4;
					player.setWalking();
				} else {
					player.vx = 2;
				}
			}
		}
		if (jaws.pressed("s")) {
			if (player.can_jump) {
				if (jaws.pressed("down")) {
					if (!player.is_sliding) {
						player.setSliding();
					}
				} else {
					player.setJumping();
					player.vy = -20;
				}
			}
		}
		if (jaws.pressed("a")) {
			if (player.can_shoot && !player.is_sliding) {
				player.is_shooting = true;
				player.can_shoot = false;
				player.shoot_recovery = 5;
				player.shoot_counter++;

				lemons.addLemon();
			}
		}

		// some gravity
		player.vy += 1;

		// apply vx / vy (x velocity / y velocity), check for collision detection in the process.
		player.update();
		lemons.update();

		// Tries to center viewport around player.x / player.y.
		// It won't go outside of 0 or outside of our previously specified max_x, max_y values.
		viewport.centerAround(player);

		live_info.innerHTML = jaws.game_loop.fps + " fps. Player: " + parseInt(player.x) + "/" + parseInt(player.y) + ". ";
		live_info.innerHTML += "Viewport: " + parseInt(viewport.x) + "/" + parseInt(viewport.y) + ".";

	};

	/* Directly after each update draw() will be called. Put all your on-screen operations here. */
	this.draw = function() {
		jaws.clear();

		// the viewport magic. wrap all draw()-calls inside viewport.apply and it will draw those relative to the viewport.
		viewport.apply( function() {
			blocks.draw();
			player.draw();
			lemons.draw();
		});
	};
}
