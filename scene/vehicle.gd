extends Node3D
class_name Vehicle

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func startDriveAnimation():
	$AnimationPlayer.play("drive")
	startLights()
	
func stopDriveAnimation():
	$AnimationPlayer.stop()
	stopLights()

func startLights():
	$LightsAnimation.play_backwards("lights")
	
func stopLights(): 
	$LightsAnimation.play("lights")
