extends CharacterBody2D

@export var scene:Node2D

var char: Character 
var character_list = []
var char_index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.make_current()
	char = Shields.new(self)
	character_list.append(char)
	character_list.append(Dragon.new(self))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _physics_process(delta:float) -> void:
	handle_switch(delta)
	char.handle_move(delta)
	char.handle_jump(delta)
	char.handle_inputs(delta)
	move_and_slide()
	
func on_hit(hit_area):
	if hit_area.tag != "player":
		char.on_hit(hit_area)
		

func set_character(name):
	$Label.text = name
	
func handle_switch(delta):
	if Input.is_action_just_pressed("Switch"):
		char_index = (char_index + 1) % character_list.size()
		char = character_list[char_index]
		set_character(char.NAME)
