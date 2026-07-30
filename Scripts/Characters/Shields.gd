class_name Shields

extends Character

const MAX_JUMPS:int = 1

const SLASH = preload("res://Prefabs/slash.tscn")

var jumps:int = 0

func _init(p):
	super(p)
	
func handle_move(delta):
	super(delta)

func handle_jump(delta):
	super(delta)
	if jumps != 0 and player.is_on_floor():
		jumps = 0
	if Input.is_action_just_pressed("Jump") and not player.is_on_floor() and jumps < MAX_JUMPS:
		jump(delta)
		jumps += 1

func attack():
	var slash = SLASH.instantiate()
	player.add_child(slash)
	print("attack")
