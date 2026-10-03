extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#remain for a bit
func originate(origin:CharacterBody2D) -> void:
	var SPREAD = origin.char.BULLET_SPREAD
	var LIFETIME = origin.char.BULLET_LIFETIME
	var SPEED = origin.char.BULLET_SPEED
	position = origin.global_position
	var target = get_global_mouse_position()
	look_at(target)
	rotation += randf_range(-SPREAD,SPREAD)
	velocity = Vector2.RIGHT.rotated(rotation).normalized() * SPEED
	#if (velocity + origin.velocity).length() > velocity.length():
		#velocity += origin.velocity
	await get_tree().create_timer(LIFETIME).timeout
	#disappear
	queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_and_slide()

func on_hurt(area):
	if area.tag != "player":
		print("deleted")
		queue_free()
