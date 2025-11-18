extends StaticBody2D
@export var button_pressed_needed: int = 1
var buttons_pressed: int = 0

func _on_puzzle_button_pressed() -> void:
	buttons_pressed += 1
	print("buttons pressed: ", buttons_pressed)
	if buttons_pressed >= button_pressed_needed:
		visible = false
		$CollisionShape2D.set_deferred("disabled",true)

func _on_puzzle_button_unpressed() -> void:
	buttons_pressed -= 1
	print("buttons pressed: ", buttons_pressed)
	if buttons_pressed < button_pressed_needed:
		visible = true
		$CollisionShape2D.set_deferred("disabled", false)
