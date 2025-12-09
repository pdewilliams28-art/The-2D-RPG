extends CharacterBody2D
class_name Player
@export var move_speed: float = 100.0
@export var push_strength: float = 140.0
@export var acceleration: float = 10.0


var is_attacking: bool = false

#TODO figure out why player goes with block when pushing down
func _ready() -> void:
	position = SceneManager.player_spawn_position
	$Weapon.visible = false
	%Weapon_area.monitoring = false
	
	
func _process(delta:float):
	if Input.is_action_just_pressed("interact"):
		attack()
		
func _physics_process(delta: float) -> void:
	if not is_attacking:
		move_player()
	push_blocks()
	
	move_and_slide()
	
func move_player():
	var move_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = velocity.move_toward(move_vector * move_speed, acceleration)

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

func push_blocks():
	var collision: KinematicCollision2D = get_last_slide_collision()
	if collision:
			#get colliding node
		var collider_node = collision.get_collider()
		if collider_node.is_in_group("Movable"):
			#get direction of collision
			# make negative
			var collision_normal: Vector2 = collision.get_normal()
			collider_node.apply_central_force(-collision_normal * push_strength)

func attack():
	#show the weapon, somewhere hide the weapon
	is_attacking = true
	velocity = Vector2.ZERO
	$Weapon.visible = true
	#turn collision on and off
	%Weapon_area.monitoring = true
	$Weapon_Timer.start()
	#check what animation is playing
	var player_animation: String = $AnimatedSprite2D.animation
	if player_animation == "walk_right":
		$AnimatedSprite2D.play("attack_right")
	elif player_animation == "walk_left":
		$AnimatedSprite2D.play("attack_left")
	elif player_animation == "walk_up":
		$AnimatedSprite2D.play("attack_up")
		$AnimationPlayer.play("swing_up")
	elif player_animation == "walk_down":
		$AnimatedSprite2D.play("attack_down")
		


func _on_hitbox_body_entered(body: Node2D) -> void:
	SceneManager.player_hp -= 1
	print(SceneManager.player_hp)
	# die function reint scene
	if SceneManager.player_hp <= 0:
		die()
	#pushback
	var distance_to_player: Vector2
	distance_to_player = global_position - body.global_position
	var knockback_direction: Vector2 = distance_to_player.normalized()
	var knockback_strength: float = 700
	velocity += knockback_direction * knockback_strength
	
	
func die():
	SceneManager.player_hp = 3
	get_tree().call_deferred("reload_current_scene")


func _on_weapon_area_body_entered(body: Node2D) -> void:
	#subtract 1 from hp, add hp to enemy
	body.hp -= 1
	if body.hp <= 0:
		body.queue_free()
	
	pass # Replace with function body.


func _on_weapon_timer_timeout() -> void:
	#show the weapon, somewhere hide the weapon
	is_attacking = false
	$Weapon.visible = false
	#turn collision on and off
	%Weapon_area.monitoring = false
	#check what animation is playing
	var player_animation: String = $AnimatedSprite2D.animation
	if player_animation == "attack_right":
		$AnimatedSprite2D.play("walk_right")
	elif player_animation == "attack_left":
		$AnimatedSprite2D.play("walk_left")
	elif player_animation == "attack_up":
		$AnimatedSprite2D.play("walk_up")
	elif player_animation == "attack_down":
		$AnimatedSprite2D.play("walk_down")
