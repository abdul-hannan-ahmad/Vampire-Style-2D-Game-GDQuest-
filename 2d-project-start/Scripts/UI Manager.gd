extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var message_label: Label = $Message
@onready var restart_button: Button = $"Restart Button"
@onready var quit_button: Button = $"Quit Button"

var message: String
var score: int

signal restart


func _ready() -> void:
	new_game()


func new_game():
	message = "GET READY"
	score = 0
	restart_button.hide()
	quit_button.hide()
	
	
func game_over():
	message = "GAME OVER"
	restart_button.show()
	quit_button.show()
	
	
func _process(_delta: float) -> void:
	message_label.text = message
	score_label.text = str(score)


func _on_game_scene_start_game() -> void:
	message = ""


func _on_game_scene_stop_game() -> void:
	game_over()


func _on_restart_button_pressed() -> void:
	new_game()
	restart.emit()
