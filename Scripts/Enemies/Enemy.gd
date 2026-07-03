class_name Enemy

const SPEED:int  = 20
const GRAVITY:int = 1000
const MAX_VELOCITY: Vector2 = Vector2(500,500)
const SLIDE:float = 5 # higher = less slide

var controller: CharacterBody2D

func _init(c):
	controller = c
	#set_move(SPEED)

func handle_movement(delta):
	controller.velocity.y += GRAVITY * delta
	controller.velocity.x = SPEED
	controller.move_and_slide()

func set_move(num):
	controller.velocity.x = num
