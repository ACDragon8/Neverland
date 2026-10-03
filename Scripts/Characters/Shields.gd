class_name Shields

extends Character

const MAX_JUMPS: int = 1
const MAX_ATTACK_TIMES:int = 1
const ATTACK_COOLDOWN: float = .3
const ATTACK_VELOCITY: Vector2 = Vector2(1000,200)

const SLASH = preload("res://Prefabs/slash.tscn")
const BLOCK = preload("res://Prefabs/block.tscn")

var jumps:int = 0
var is_blocking = false
var block_obj

var on_cooldown: bool = false

func _init(p):
	super(p)
	NAME = "Shields"
func handle_move(delta):
	super(delta)

func handle_jump(delta):
	super(delta)
	if player.is_on_floor():
		jumps = 0
	if Input.is_action_just_pressed("Jump") and not player.is_on_floor() and jumps < MAX_JUMPS:
		jump(delta)
		jumps += 1

func attack():
	if not on_cooldown and not is_blocking:
		#create slash object and add it to scene
		var slash = SLASH.instantiate()
		player.add_child(slash)
		#prevent attack spamming until cd is up
		on_cooldown = true
		#print("attack")
		#move player in direction of attack
		if not player.is_on_floor():
			var mouse_pos = player.get_global_mouse_position()
			var player_pos =  player.global_position
			if player.velocity.y > 0 :
				player.velocity.y = 0
			player.velocity += (mouse_pos - player_pos).normalized() * ATTACK_VELOCITY
		#wait to finish attack cooldown
		await player.get_tree().create_timer(ATTACK_COOLDOWN).timeout
		on_cooldown = false

func ability():
	if block_obj == null:
		block_obj = BLOCK.instantiate()
		player.add_child(block_obj)
		is_blocking = true
	else:
		block_obj.queue_free()
		is_blocking = false
	pass
	

func handle_ability(delta):
	if not is_blocking and Input.is_action_just_pressed("Ability"):
		ability()
	elif Input.is_action_just_released("Ability"):
		ability()


func on_hit(area):
	if not is_blocking:
		super(area)
