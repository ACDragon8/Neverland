extends Area2D

@export_file("*.tscn") var next_zone:String
@export var player:CharacterBody2D
@export var root:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("next zone")
	#root.queue_free()
	#var zone = load(next_zone)
	#var zone_inst = zone.instantiate()
	#root.add_child(zone_inst)
