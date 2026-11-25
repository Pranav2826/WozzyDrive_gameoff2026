extends Node2D
const SAVE_PATH = "user://highscore.cfg"
var best_time:float
var is_game_over = false
@export var timer: Timer
@export var minutes: Label
@export var seconds: Label
@export var msecs: Label
@export var score_panel: Panel
@export var current: Label
@export var best: Label

@onready var car_scene_1: PackedScene = preload("res://scenes/balc_car.tscn")
@onready var car_scene: PackedScene = preload("res://scenes/car.tscn")
const LANES: Array[float] = [157.0, 270.0, 385.0]
var time_passed:float
var mins
var secs
var msecss
func _ready() -> void:
	load_record()
	
	
	
	
func _process(delta: float) -> void:
	if is_game_over:
		return
		
	time_passed += delta
	
	
func game_over():
	if is_game_over:
		return
	is_game_over=true
	
	if time_passed>best_time:
		best_time=time_passed
		save_record()
	print("Run Time:",format_time(time_passed))
	print("Best Time:",format_time(best_time))
	if score_panel:
		score_panel.show_res(format_time(time_passed) , format_time(best_time))
	score_panel.show()
func save_record():
	var config = ConfigFile.new()
	config.set_value("Scores" , "best_time" , best_time)
	config.save(SAVE_PATH)
	
func load_record():
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		best_time = config.get_value("Scores" , "best_time" , 0.0)
		
		
func format_time(t:float)-> String:
	mins = int(t/60)
	secs = fmod(t,60.0)
	msecss = int(fmod(t*1000.0,1000.0))
	return "%02d:%02d.%03d" % [mins,secs,msecss]
	
func reset():
	time_passed=0
	is_game_over = false

func _on_timer_timeout() -> void:
		var available_lanes:Array[float] = LANES.duplicate()
		available_lanes.shuffle()
		print("spawned")
		var car = car_scene.instantiate()
		add_child(car)
		car.global_position = Vector2(available_lanes.pop_back(), -35.0)
		if time_passed >= 30.0:
			print("car2")
			var car_2 = car_scene_1.instantiate()
			add_child(car_2)
			car_2.global_position = Vector2(available_lanes.pop_back(),randf_range(-160,-280))
			
