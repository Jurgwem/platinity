extends RigidBody2D

@onready var is_on_ground: RayCast2D = $raycasts/isOnGround
@onready var is_right: RayCast2D = $raycasts/isRight
@onready var is_left: RayCast2D = $raycasts/isLeft
@onready var is_down_right: RayCast2D = $raycasts/isDownRight
@onready var is_down_left: RayCast2D = $raycasts/isDownLeft

@onready var camera: Camera2D = $"../camera"

var playerGravity : float = 12;
var jumpHeight : float = 666;
var wallJumpHeight : float = 400;
var speed : float = 150;
var friction : float = 0.5;
var airResistance : float = 0.92;
var maxSpeed : int = 300;

var lastWallJump : String = "none";
var storedJump : bool = false;

func _init() -> void:
	return
	
func _physics_process(_delta: float) -> void:	
	#Reset raycasts rotation to remain facing the right directions
	$raycasts.global_rotation = 0;
	
	#Update camera position
	camera.global_position = global_position;
	
	#Reset wall jump direction
	if is_on_ground.is_colliding():
		lastWallJump = "none";
	
	#Gravity
	if linear_velocity.x != 0:
		if is_on_ground.is_colliding():
			linear_velocity.x *= friction;
		else:
			linear_velocity.x *= airResistance;
	
	#Jumping
	if (Input.is_action_just_pressed("Jump") or storedJump) and is_on_ground.is_colliding():
		linear_velocity.y = -jumpHeight;
		angular_velocity = ((randf() - 0.5) * 32);
		storedJump = false;
	elif !is_on_ground.is_colliding():
		linear_velocity.y += playerGravity;
		
	#LCJs and RCJs (omg LBP reference :O)
	if (Input.is_action_just_pressed("Jump") or storedJump) and !is_on_ground.is_colliding() and (is_down_left.is_colliding() or is_down_right.is_colliding()):
		linear_velocity.y = -jumpHeight * 1.33;
		angular_velocity = ((randf() - 0.5) * 32);
		storedJump = false;
	
	#Store Jump if airborne
	if Input.is_action_just_pressed("Jump") and !is_on_ground.is_colliding() and linear_velocity.y > 200 and false:
		storedJump = true;
		
	#Wall Jumps
	if Input.is_action_just_pressed("Jump") and !is_on_ground.is_colliding() and (is_left.is_colliding() or is_right.is_colliding()):
		if lastWallJump == "left" and is_left.is_colliding():
			return;
		elif lastWallJump == "right" and is_right.is_colliding():
			return;
		
		linear_velocity.y = -wallJumpHeight;
		if is_left.is_colliding():
			lastWallJump = "left";
			linear_velocity.x = wallJumpHeight * 1.75;
			angular_velocity = 16;
		else:
			lastWallJump = "right";
			linear_velocity.x = -wallJumpHeight * 1.75;
			angular_velocity = -16;
		
	
	#Left / Right
	if linear_velocity.x >= -maxSpeed and Input.is_action_pressed("Left") and !is_left.is_colliding():
			linear_velocity.x -= speed;	
			rotate(-0.05)
		
	if linear_velocity.x <= maxSpeed and Input.is_action_pressed("Right") and !is_right.is_colliding():
			linear_velocity.x += speed;
			rotate(0.05)
	
	print("storedJump: ", storedJump);
	print("lastWallJump: ", lastWallJump);
	print("vVel.: ", linear_velocity.y);
	print("xVel.: ", linear_velocity.x);
	return
	
