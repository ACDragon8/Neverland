extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(get_global_mouse_position())
	await get_tree().create_timer(.25).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
