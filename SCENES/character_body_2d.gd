extends CharacterBody2D

func _init() -> void:
	return
	
func _physics_process(delta: float) -> void:	
	if !is_on_floor():
		velocity += get_gravity();
	move_and_slide()
	print("test")
	return
	
