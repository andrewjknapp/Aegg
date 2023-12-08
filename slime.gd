extends CharacterBody2D

var SPEED = (randi() % 20) + 80
const JUMP_VELOCITY = -200.0

var size = (randi() % 4 + 1)

var health = 2 * size

var direction = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var screen_size

func _ready():
	SPEED /= size
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()
	$AnimatedSprite2D.animation = "walk"

	print($CollisionShape2D.scale)
	#$Anima$AnimatedSprite2D.scaletedSprite2D.transform["0"] = Vector2(2, -64)
	scale = Vector2(size, size)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if randi() % 50 == 0:
			velocity.y = JUMP_VELOCITY			
		
	velocity.x = SPEED * direction
	
	if position.x > (screen_size[0] - 100):
		direction = -1
		$AnimatedSprite2D.flip_h = false
	elif position.x < 100:
		direction = 1
		$AnimatedSprite2D.flip_h = true
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_slime_hurtbox_area_entered(area):

	if area.name == "Spear":
		recoil_on_hit()
		##queue_free()

func recoil_on_hit():
	if health == 0:
		queue_free()
	direction *= -1
	SPEED += 20
	health -= 1
	#SPEED = 0
	

