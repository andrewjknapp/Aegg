extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimatedSprite2D/AnimationTree

var JUMP_HEIGHT : float = 100
var JUMP_TIME_TO_PEAK : float = 0.4
var JUMP_TIME_TO_DESCENT : float = 0.3

@onready var jump_velocity : float = ((2.0 * JUMP_HEIGHT) / JUMP_TIME_TO_PEAK) * -1
@onready var jump_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_PEAK * JUMP_TIME_TO_PEAK)) * -1
@onready var fall_gravity : float = ((-2.0 * JUMP_HEIGHT) / (JUMP_TIME_TO_DESCENT * JUMP_TIME_TO_DESCENT)) * -1

const SPEED = 300.0
const RUN_MODIFIER = 1.8
const JUMP_VELOCITY = -500.0
var lastVelocity: Vector2

var isMovingLeft = false
var isFacingLeft = false

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0 else fall_gravity

func jump():
	return jump_velocity

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	update_animation_parameters()

		
func _physics_process(delta):
	velocity.y += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	var characterSpeed = SPEED if !Input.is_action_pressed("run") else SPEED * RUN_MODIFIER
	if direction:
		velocity.x = direction * characterSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, characterSpeed)

	move_and_slide()



func update_animation_parameters():
	animation_tree["parameters/conditions/is_attacking_light"] = false
	animation_tree["parameters/conditions/is_jumping"] = false
	animation_tree["parameters/conditions/is_idling"] = false
	animation_tree["parameters/conditions/is_walking"] = false
	animation_tree["parameters/conditions/is_running"] = false
	
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/is_idling"] = true

	elif is_on_floor() && velocity.x != 0:
		animation_tree["parameters/conditions/is_idling"] = false
		
		animation_tree["parameters/conditions/is_running"] = Input.is_action_pressed("run")
		animation_tree["parameters/conditions/is_walking"] = !Input.is_action_pressed("run")
		
	if Input.is_action_just_pressed("attack_light"):
		animation_tree["parameters/conditions/is_attacking_light"] = true
		
	if !is_on_floor():
		animation_tree["parameters/conditions/is_jumping"] = true
		
	
		
	if is_on_floor():
		if velocity.x != 0:
			isMovingLeft = velocity.x < 0
		if !Input.is_action_pressed("strafe"):
				
			# Handle flipping sprite based on direction
			if isMovingLeft && !isFacingLeft:
				scale.x = -1
				isFacingLeft = true
			elif !isMovingLeft && isFacingLeft:
				scale.x = -1
				isFacingLeft = false
		
		
		


			

		
		





