extends CharacterBody2D
### TODO : have enmey forget target after they have escaped for a while.
### fatigue, sliding physics
@export var speed: float = 50.0
#what to chase
var target: Node2D

func _physics_process(delta: float) -> void:
	#add attack state
	if target:
		chasing()
	else:
		#random or patrol
		pass
	animate_enemy()
	
	move_and_slide()

func chasing():
	var distance_to_player: Vector2
	distance_to_player = target.global_position - global_position
	var direction_normal: Vector2 = distance_to_player.normalized()
	if speed > 0.0:
		speed -= 0.01
	velocity = direction_normal * speed
	
	move_and_slide()
	
func animate_enemy():
	var normal_velocity: Vector2 = velocity.normalized()
	print("normal velocity: ", normal_velocity)
	if normal_velocity.x > 0.7:
		$AnimatedSprite2D.play("right")
	elif normal_velocity.x < -0.7:
		$AnimatedSprite2D.play("left")
	elif normal_velocity.y > 0.7:
		$AnimatedSprite2D.play("down")
	elif normal_velocity.y < -0.7:
		$AnimatedSprite2D.play("up")
		
		

func _on_chasing_radius_body_entered(body: Node2D) -> void:
	if body is Player:
		target = body
		speed = 20
