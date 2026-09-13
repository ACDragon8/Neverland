extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/Camera2D.limit_right = 1314


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
