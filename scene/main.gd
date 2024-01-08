extends Node3D

@export var offset: int = 27
@export var speed: float

@onready var props: Node3D = $props
@onready var vehicle: Vehicle = $Vehicle
@onready var time_manager: TimeManager = $TimeManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var propss: Array[Node3D] = []

var stopped: bool = true
var isParked: bool = false

func _ready():
	var props0 = props.duplicate() as Node3D
	var props2 = props.duplicate() as Node3D
	add_child(props0)
	add_child(props2)
	props2.position.x += offset
	props0.position.x -= offset
	propss.append(props0)
	propss.append(props)
	propss.append(props2)
	
	time_manager.timer_start.connect(on_timer_started)
	time_manager.timer_stop.connect(on_timer_stopped)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if stopped:
		return
	
	#scroll
	var x_scroll_position_delta = speed * delta
	for p in propss:
		p.position.x -= x_scroll_position_delta
	
	if propss[0].position.x <= -offset * 1.5:
		var tmp = propss[0]
		propss[0] = propss[1]
		propss[1] = propss[2]
		propss[2] = tmp
		propss[2].position.x = propss[1].position.x + offset
		

func on_timer_started():
	vehicle.startDriveAnimation()
	if isParked:
		animation_player.play_backwards("park")
		animation_player.animation_finished.connect(func (name): stopped = false, CONNECT_ONE_SHOT)
	else:
		stopped = false
	
func on_timer_stopped():
	stopped = true
	isParked = true
	animation_player.play("park")
	animation_player.animation_finished.connect(func (name): vehicle.stopDriveAnimation(), CONNECT_ONE_SHOT)
	
	
