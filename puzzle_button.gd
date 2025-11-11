extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("aaahhh")
	#play animation
	#open a door by sneding a signal
	$AnimatedSprite2D.play("On")

func _on_body_exited(body: Node2D) -> void:
	print("airrr")
	$AnimatedSprite2D.play("Off")
	#play off animation
	#shut the door
