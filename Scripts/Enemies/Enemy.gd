class_name Enemy

const SPEED:float  = 200
const GRAVITY:float = 1000
const MAX_VELOCITY: Vector2 = Vector2(500,500)
const SLIDE:float = 5 # higher = less slide
const MAX_HP = 10
const KB_FACTOR = 750
const TURN_WAIT = .1
const STUN_TIME = .25

enum State {IDLE, HITSTUN, PATROL}

var controller: CharacterBody2D
var hp
var hitstun = false
var state:State
var direction = 1
var turn_lock = false

func _init(c):
	controller = c
	hp = MAX_HP
	hitstun = false
	#set_move(SPEED)
	state = State.PATROL

func handle_movement(delta):
	#gravity
	controller.velocity.y += GRAVITY * delta
	#horizontal movement
	if state == State.PATROL:
		if controller.is_on_floor():
			controller.velocity.x = SPEED * direction
		if controller.is_on_wall() or (not controller.raycast.is_colliding() and controller.is_on_floor()):
			turn()
	elif state == State.HITSTUN:
		controller.velocity.x = lerp(controller.velocity.x,SPEED* direction, 1- exp(-.25 * delta))
		controller.velocity.x -= controller.velocity.x * SLIDE * delta
	controller.move_and_slide()
	

func display_hp():
	controller.set_label("%s / %s" % [hp, MAX_HP])

func set_move(num):
	controller.velocity.x = num
	
func on_hit(hit_area):
	print("hit")
	hp -= hit_area.damage
	if hp <= 0:
		controller.die()
	else:
		display_hp()
		var knockback = hit_area.global_position.direction_to(controller.global_position)
		take_knockback(knockback,1)
		#face damage source
		direction = -signf(knockback.x)

func take_knockback(direction, factor = 1):
		print("kb")
		var knockback = direction * KB_FACTOR * factor
		state = State.HITSTUN
		controller.velocity = knockback
		await controller.get_tree().create_timer(STUN_TIME).timeout
		state=State.PATROL

func turn():
	if not turn_lock:
		print("turn")
		turn_lock = true
		direction *= -1
		await controller.get_tree().create_timer(TURN_WAIT).timeout
		turn_lock = false
	
