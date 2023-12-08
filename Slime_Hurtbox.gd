extends Area2D

const whiten_duration = 0.15
@export var white_on_hit : ShaderMaterial

signal slime_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_area_entered(area):
	if area.name == "Slime_Hurtbox":
		return

	if area.name == "Spear":

		white_on_hit.set_shader_parameter("whiten", true)
		await get_tree().create_timer(whiten_duration).timeout
		white_on_hit.set_shader_parameter("whiten", false)

		#queue_free()
	pass # Replace with function body.
