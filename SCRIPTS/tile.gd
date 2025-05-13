extends Node2D

@export var type : String = "none";
var chance : float = 0.0;
var exists : float = 0.0;
var boost : int = 1000;

func _ready() -> void:
	if type == "none":
		exists = randf();
		if exists > 0.25:
			queue_free();
			pass;
		$AnimatedSprite2D.frame = 0;
		chance = randf();
		if (chance > (70.0 * 1.0/100.0)):
			type = "block"
			$Area2D.queue_free();
			$AnimatedSprite2D.frame = 1;
		elif (chance > (60.0 * 1.0/100.0)):
			type = "spike";
			$StaticBody2D/hitbox.disabled = true;
			$AnimatedSprite2D.frame = 2;
		elif (chance > (45.0 * 1.0/100.0)):
			type = "semi";
			$Area2D.queue_free();
			$StaticBody2D/hitbox.disabled = true;
			$StaticBody2D/semiHitbox.disabled = false;
			$AnimatedSprite2D.frame = 3;
		elif (chance > (20.1 * 1.0/100.0)):
			exists = randf();
			if exists > 0.1:
				queue_free();
				pass;
			type = "flip";
			$StaticBody2D/hitbox.disabled = true;
			$AnimatedSprite2D.frame = 8;	
		elif (chance > (15.0 * 1.0/100.0)):
			type = "boost_r"
			$StaticBody2D/hitbox.disabled = true;
			$AnimatedSprite2D.frame = 4;
		elif (chance > (10.0 * 1.0/100.0)):
			type = "boost_u";
			$StaticBody2D/hitbox.disabled = true;
			$AnimatedSprite2D.frame = 5;
		elif (chance > (5.0 * 1.0/100.0)):
			type = "boost_l"
			$StaticBody2D/hitbox.disabled = true;
			$AnimatedSprite2D.frame = 6;
		else:
			type = "boost_d"
			$StaticBody2D/hitbox.disabled = true;
			$AnimatedSprite2D.frame = 7;
	else:
		match type:
			"block":
				$AnimatedSprite2D.frame = 1;
				$Area2D.queue_free();
				pass;
			"spike":
				$AnimatedSprite2D.frame = 2;
				$StaticBody2D/hitbox.disabled = true;
				pass;
			"semi":
				$Area2D.queue_free();
				$AnimatedSprite2D.frame = 3;
				$StaticBody2D/hitbox.disabled = true;
				$StaticBody2D/semiHitbox.disabled = false;
				pass;
			"boost_r":
				$StaticBody2D/hitbox.disabled = true;
				$AnimatedSprite2D.frame = 4;
				pass;
			"boost_u":
				$StaticBody2D/hitbox.disabled = true;
				$AnimatedSprite2D.frame = 5;
				pass;
			"boost_l":
				$StaticBody2D/hitbox.disabled = true;
				$AnimatedSprite2D.frame = 6;
				pass;
			"boost_d":
				$StaticBody2D/hitbox.disabled = true;
				$AnimatedSprite2D.frame = 7;
				pass;
			"flip":
				$StaticBody2D/hitbox.disabled = true;
				$AnimatedSprite2D.frame = 8;
				pass;
	pass;
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if type == "spike":
			body.call_deferred("death");
			pass;
		
		if type == "flip":
			body.playerGravity *= -1;
			body.gravity_scale  *= -1;
			body.jumpHeight *= -1;
			body.wallJumpHeight *= -1;
			body.flipRays();
			
		if type == "boost_u":
			body.linear_velocity.y = -boost;
			
		if type == "boost_d":
			body.linear_velocity.y = boost;
			
		if type == "boost_r":
			body.linear_velocity.x = 1.5 * boost;
			
		if type == "boost_l":
			body.linear_velocity.x = -1.5 * boost;
	pass # Replace with function body.
