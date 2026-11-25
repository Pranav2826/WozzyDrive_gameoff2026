extends Panel
@onready var current: Label = $Current
@onready var best: Label = $Best
@onready var try: Button = $Try
@onready var quit: Button = $Quit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Gm.score_panel=self
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func show_res(current_time:String,best_time:String):
	current.text = "Current Time:" + current_time
	best.text = "Best Time:" + best_time


func _on_try_pressed() -> void:
	Gm.reset()
	get_tree().paused = false
	Gm.is_game_over = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	



func _on_quit_pressed() -> void:
	if OS.has_feature("web"):
		JavaScriptBridge.eval("window.close()")
	else:
		get_tree().quit()
