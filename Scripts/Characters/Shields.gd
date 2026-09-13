class_name Shields

extends Character

const MAX_JUMPS: int = 1
const MAX_ATTACK_TIMES:int = 1
const ATTACK_COOLDOWN: float = .5
const ATTACK_VELOCITY: Vector2 = Vector2(1000,200)

const SLASH = preload("res://Prefabs/slash.tscn")

var jumps:int = 0


var on_cooldown: bool = false

func _init(p):
	super(p)
	
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
	if not on_cooldown:
		#create slash object and add it to scene
		var slash = SLASH.instantiate()
		player.add_child(slash)
		#prevent attack spamming until cd is up
		on_cooldown = true
		#print("attack")
		#move player in direction of attack
		var mouse_pos = player.get_global_mouse_position()
		var player_pos =  player.global_position
		player.velocity.y = 0
		player.velocity += (mouse_pos - player_pos).normalized() * ATTACK_VELOCITY
		#wait to finish attack cooldown
		await player.get_tree().create_timer(ATTACK_COOLDOWN).timeout
		on_cooldown = false
		
