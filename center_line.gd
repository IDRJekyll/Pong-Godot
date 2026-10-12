extends Node2D

func _draw() -> void:
	for y in range(20, 648, 40):
		draw_rect(Rect2(574, y, 4, 20), Color.WHITE)
		
func _ready() -> void:
	queue_redraw()


func _on_vs_ai_button_pressed() -> void:
	pass # Replace with function body.


func _on_two_players_button_pressed() -> void:
	pass # Replace with function body.


func _on_exit_button_pressed() -> void:
	pass # Replace with function body.


func _on_back_to_menu_button_pressed() -> void:
	pass # Replace with function body.
