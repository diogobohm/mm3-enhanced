function AnimationManager(size, image) {
	/* Default parameters */
	var frame_duration = 200;

	this.left_anim = new jaws.Animation({sprite_sheet: image, frame_size: [size, size], frame_duration: frame_duration});
	this.left_bounce_anim = new jaws.Animation({bounce: true, sprite_sheet: image, frame_size: [size, size], frame_duration: frame_duration});
	this.right_anim = new jaws.Animation({offset: size, sprite_sheet: image, frame_size: [size, size], frame_duration: frame_duration});
	this.right_bounce_anim = new jaws.Animation({offset: size, bounce: true, sprite_sheet: image, frame_size: [size, size], frame_duration: frame_duration});
}
