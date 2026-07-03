extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var enemy:Enemy = Enemy.new(self)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	enemy.handle_movement(delta)

func hit():
	enemy.hit()
