extends Node2D

var Cursor: AnimatedTexture = load("res://Assets/Cursor/CursorTexture.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var texture = Cursor.get_frame_texture(Cursor.current_frame)
	Input.set_custom_mouse_cursor(texture, 0, Vector2(texture.get_width(), texture.get_height()) / 2)
