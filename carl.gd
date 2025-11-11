extends CharacterBody2D
class_name Player
@export var move_speed: float = 100.0
@export var push_strength: float = 140.0
#TODO figure out why player goes with block when pushing down
func _ready() -> void:
	position = SceneManager.player_spawn_position

func _physics_process(delta: float) -> void:
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = move_vector * move_speed
	
	if velocity.x > 0:
		$AnimatedSprite2D.play("walk_right")
	elif velocity.x < 0:
		$AnimatedSprite2D.play("walk_left")
	elif velocity.y > 0:
		$AnimatedSprite2D.play("walk_down")
	elif velocity.y < 0:
		$AnimatedSprite2D.play("walk_up")
	else:
		$AnimatedSprite2D.stop	
		
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision:
			#get colliding node
		var collider_node = collision.get_collider()
		if collider_node.is_in_group("Movable"):
			#get direction of collision
			# make negative
			var collision_normal: Vector2 = collision.get_normal()
			collider_node.apply_central_force(-collision_normal * push_strength)
	move_and_slide()
