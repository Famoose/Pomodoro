extends CanvasLayer
class_name TimeManager

@onready var timer: Timer = $Timer
@onready var label: Label = $Label

signal timer_start()
signal timer_stop()

func _ready():
	timer.timeout.connect(stop)

func _process(_delta):
	var time_elapsed = 	timer.time_left
	label.text = format_seconds(time_elapsed)


func format_seconds(full_seconds: float):
	var minutes = floor(full_seconds/60)
	var seconds = full_seconds - (minutes * 60)
	return "%02d:%02d" % [minutes, seconds]


func _input(event):
	if event.is_action_pressed("start_session"):
		startTimerWithMinutes(30)
	if event.is_action_pressed("start_break"):
		startTimerWithMinutes(5)
	if event.is_action_pressed("start_long_break"):
		startTimerWithMinutes(10)
	if event.is_action_pressed("stop"):
		stop()
	
	
func startTimerWithMinutes(min: int):
	timer.stop()
	timer.wait_time = min * 60
	timer.start()
	timer_start.emit()
	
	
func stop():
	timer.stop()
	timer.wait_time = 0
	_process(0)
	
	timer_stop.emit()
