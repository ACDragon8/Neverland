extends CharacterBody2D

@export var raycast:RayCast2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var enemy:Enemy = Enemy.new(self)


func _ready() -> void:
	enemy.display_hp()
	pass

func _physics_process(delta: float) -> void:
	enemy.handle_movement(delta)

func on_hit(hit_area):
	if hit_area.tag != "enemy":
		enemy.on_hit(hit_area)

func die():
	queue_free()

func set_label(text):
	$Label.text = text
