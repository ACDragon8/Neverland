extends Area2D

@export_file("*.tscn") var next_zone:String
@export var player:CharacterBody2D
@export var scene:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.owner == player:
		var root = get_tree().get_root()
		print("next zone")
		var zone = load(next_zone)
		var zone_inst = zone.instantiate()
		root.add_child(zone_inst)
		scene.queue_free()
