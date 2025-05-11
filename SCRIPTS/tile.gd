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
		if (chance > (7.0 * 1.0/10.0)):
			type = "block"
			$AnimatedSprite2D.frame = 1;
		elif (chance > (6.0 * 1.0/10.0)):
			type = "spike";
			$StaticBody2D/hitbox.disabled = true;
			$AnimatedSprite2D.frame = 2;
		elif (chance > (4.0 * 1.0/10.0)):
			type = "semi";
			$StaticBody2D/hitbox.one_way_collision = true;
			$AnimatedSprite2D.frame = 3;
		elif (chance > (3.0 * 1.0/10.0)):
			type = "boost_r"
			$StaticBody2D/hitbox.disabled = true;
			$AnimatedSprite2D.frame = 4;
		elif (chance > (2.0 * 1.0/10.0)):
			type = "boost_u";
			$StaticBody2D/hitbox.disabled = true;
			$AnimatedSprite2D.frame = 5;
		elif (chance > (1.0 * 1.0/10.0)):
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
				pass;
			"spike":
				$AnimatedSprite2D.frame = 2;
				$StaticBody2D/hitbox.disabled = true;
				pass;
			"semi":
				$AnimatedSprite2D.frame = 3;
				$StaticBody2D/hitbox.one_way_collision = true;
				$StaticBody2D/hitbox.one_way_collision_margin = 5;
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
	pass;
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if type == "spike":
			print("you are dead");
			globals.deaths += 1;
			get_tree().change_scene_to_file("res://SCENES/game.tscn");
			
		if type == "boost_u":
			body.linear_velocity.y = -boost;
			
		if type == "boost_d":
			body.linear_velocity.y = boost;
			
		if type == "boost_r":
			body.linear_velocity.x = 1.5 * boost;
			
		if type == "boost_l":
			body.linear_velocity.x = -1.5 * boost;
	pass # Replace with function body.
