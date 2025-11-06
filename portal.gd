extends Area2D

@export var next_scene : String

@export var player_location : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("entered the portal")
	
	if body is Player:
		SceneManager.player_spawn_position = player_location
		get_tree().change_scene_to_file.call_deferred(next_scene)
		
		
func _on_body_exited(body: Node2D) -> void:
	print("exited the portal")
	pass
