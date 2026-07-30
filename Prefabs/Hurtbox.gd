class_name Hurtbox extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(
		func _on_area_entered(hit_area: Hitbox) -> void:
		if hit_area != null and owner.has_method("on_hit"):
			owner.on_hit(hit_area)
)
