class_name Character

const SPEED:int  = 2000
const JUMP_HEIGHT:int = 500
const GRAVITY:int = 1000
const MAX_VELOCITY: Vector2 = Vector2(500,500)
const SLIDE:float = 5 # higher = less slide

var player:CharacterBody2D
var movement:int = 0 


func _init(p):
	player = p
	player.set_up_direction(Vector2.UP) 

func handle_move(delta):
	player.velocity.y += GRAVITY * delta
	movement = 0
	if Input.is_action_pressed("Right"):
		movement += 1
	if Input.is_action_pressed("Left"):
		movement -= 1
	if movement != 0:
		move(delta)
	else:
		player.velocity.x -= player.velocity.x * SLIDE * delta
	player.velocity.x = min(abs(player.velocity.x),MAX_VELOCITY.x) * sign(player.velocity.x)

func handle_jump(delta):
	if Input.is_action_pressed("Jump") and player.is_on_floor():
		jump(delta)

func move(delta):
	player.velocity.x += movement * SPEED * delta

func jump(delta):
	player.velocity.y = -JUMP_HEIGHT
