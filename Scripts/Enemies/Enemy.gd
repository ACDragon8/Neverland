class_name Enemy

const SPEED:float  = 0
const GRAVITY:float = 1000
const MAX_VELOCITY: Vector2 = Vector2(500,500)
const SLIDE:float = 5 # higher = less slide
const MAX_HP = 5
const KB_FACTOR = 500

enum State {IDLE, HITSTUN, PATROL}

var controller: CharacterBody2D
var hp
var hitstun

func _init(c):
	controller = c
	hp = MAX_HP
	hitstun = false
	#set_move(SPEED)

func handle_movement(delta):
	#gravity
	controller.velocity.y += GRAVITY * delta
	#horizontal movement
	controller.velocity.x = lerp(controller.velocity.x,SPEED, 1- exp(-.25 * delta))
	controller.move_and_slide()
	controller.velocity.x -= controller.velocity.x * SLIDE * delta

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

func take_knockback(direction, factor = 1):
		print("kb")
		var knockback = direction * KB_FACTOR * factor
		print(knockback)
		controller.velocity = knockback
	
