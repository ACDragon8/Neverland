class_name Character

extends Node2D

const SPEED:int  = 2000
const JUMP_HEIGHT:int = 500
const GRAVITY:int = 1000
const MAX_VELOCITY: Vector2 = Vector2(500,500)
const SLIDE:float = 5 # higher = less slide

enum PlayerStates {IDLE, ACTION, COOLDOWN }

var player:CharacterBody2D
var movement:int = 0 
var state: PlayerStates



func _init(p):
	player = p
	player.set_up_direction(Vector2.UP)
	state = PlayerStates.IDLE

func handle_move(delta):
	#gravity
	player.velocity.y += GRAVITY * delta
	#handle movement vector from inputs
	movement = 0
	if Input.is_action_pressed("Right"):
		movement += 1
	if Input.is_action_pressed("Left"):
		movement -= 1
	if movement != 0:
		move(delta)
	else:
		slide(delta)
	#Cap player velocity at a certain speed
	player.velocity.x = min(abs(player.velocity.x),MAX_VELOCITY.x) * sign(player.velocity.x)
	player.velocity.y = min(abs(player.velocity.y),MAX_VELOCITY.y) * sign(player.velocity.y)

func handle_jump(delta):
	if Input.is_action_pressed("Jump") and player.is_on_floor():
		jump(delta)

func handle_inputs(delta):
	if state == PlayerStates.IDLE:
		if Input.is_action_just_pressed("Attack"):
			attack()
		if Input.is_action_just_pressed("Ability"):
			ability()


func hit():
	print("player hit")
	
func attack():
	print("attack")

func ability():
	print("ability")

func move(delta):
	player.velocity.x += movement * SPEED * delta

func jump(delta):
	player.velocity.y = -JUMP_HEIGHT
	
func slide(delta):
	player.velocity.x -= player.velocity.x * SLIDE * delta
