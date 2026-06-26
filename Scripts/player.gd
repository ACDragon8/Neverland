extends CharacterBody2D
var char: Character = Shields.new(self)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta:float) -> void:
	char.handle_move(delta)
	char.handle_jump(delta)
	move_and_slide()
