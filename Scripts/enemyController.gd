extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var enemy:Enemy = Enemy.new(self)

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	enemy.handle_movement(delta)

func on_hit(hit_area):
	if hit_area.tag != "enemy":
		enemy.on_hit(hit_area)

func die():
	queue_free()
