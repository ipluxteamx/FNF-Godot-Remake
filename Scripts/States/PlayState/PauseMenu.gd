extends Node2D

var playState

var selectedDifficulty = 2
var selectedSpeed = 1

var inOptions = false

var options = ["RESUME", "RESTART SONG", "OPTIONS", "EXIT TO TITLE"]

func _ready():
	var _c_loaded = get_tree().current_scene.connect("scene_loaded", self, "_scene_loaded")
	
	playState = get_tree().current_scene.current_scene
	$CanvasLayer/PauseMenu/Options.options = options
	
	var label = $CanvasLayer/PauseMenu/Label
	$Tween.interpolate_property(label, "rect_position:y", -100, label.rect_position.y, 1.6, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(label, "modulate:a", 0, 1, 1.6, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()
	
	$CanvasLayer/OptionsMenu.enabled = false

func _process(_delta):
	if (get_tree().paused == false):
		queue_free()
	
	if (Input.is_action_just_pressed("cancel")):
		if (!inOptions):
			get_tree().paused = false
		elif (!$CanvasLayer/OptionsMenu/EditValue/ValueEdit.visible):
			toggleOptions(false)
	
	pause_text_process()

func option_selected(selected):
	match (selected):
		0:
			get_tree().paused = false
		1:
			playState.restart_playstate()
		2:
			toggleOptions(true)
		3:
			Main.change_to_main_menu()
			
func pause_text_process():
	var pauseText = playState.song.capitalize() + "\n" + playState.difficulty.to_upper() + "\n" + str(playState.speed) + "x"
	
	$CanvasLayer/PauseMenu/Label.text = pauseText

func _scene_loaded():
	get_tree().paused = false

func toggleOptions(enable):
	if (enable):
		inOptions = true
		
		$CanvasLayer/OptionsMenu.enabled = true
		$CanvasLayer/OptionsMenu.visible = true
		
		$CanvasLayer/PauseMenu/Options.enabled = false
		$CanvasLayer/PauseMenu.visible = false
	else:
		inOptions = false
		
		$CanvasLayer/OptionsMenu.enabled = false
		$CanvasLayer/OptionsMenu.visible = false
		
		$CanvasLayer/PauseMenu/Options.enabled = true
		$CanvasLayer/PauseMenu.visible = true
