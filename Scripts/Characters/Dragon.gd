class_name Dragon

extends Character

const MAX_JUMPS: int = 0
const MAX_ATTACK_TIMES:int = 1
const ATTACK_COOLDOWN: float = .5
const ATTACK_VELOCITY: Vector2 = Vector2(1000,200)

const BULLET_LIFETIME = .5
const BULLET_SPEED = 1000
const BULLET_SPREAD = .05
const BULLET_COUNT = 8

const ABILITY_COOLDOWN: float = 2


const BULLET = preload("res://Prefabs/Bullet/bullet.tscn")

var jumps:int = 0
var is_blocking = false
var block_obj

var on_cooldown: bool = false
var ability_on_cooldown:bool = false

func _init(p):
	super(p)
	NAME = "Dragon"
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
		#prevent attack spamming until cd is up
		on_cooldown = true
		
		#attack
		super()
		for i in range(BULLET_COUNT):
			print("bang")
			var bullet = BULLET.instantiate()
			player.scene.add_child(bullet)
			bullet.originate(player)
		#wait to finish attack cooldown
		await player.get_tree().create_timer(ATTACK_COOLDOWN).timeout
		on_cooldown = false

func ability():
	if not ability_on_cooldown:
		ability_on_cooldown = true
		super()
		#raycast to mouse pointer
		var raycast = RayCast2D.new()
		
		raycast.target_position = player.get_global_mouse_position()
		raycast.enabled = true
		player.add_child(raycast)
		var result = raycast.get_collision_point()
		#teleport to raycast hit
		if result:
			print("a")
			player.global_position = result
		else:
			print("b")
			player.global_position = player.get_global_mouse_position()
		await player.get_tree().create_timer(ABILITY_COOLDOWN).timeout
		ability_on_cooldown = false
		
	

func handle_ability(delta):
	super(delta)


func on_hit(area):
	super(area)
