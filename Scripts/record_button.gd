extends Button

var effect
var recording


func _ready():
	# We get the index of the "Record" bus.
	var idx = AudioServer.get_bus_index("Record")
	# And use it to retrieve its first effect, which has been defined
	# as an "AudioEffectRecord" resource.
	effect = AudioServer.get_bus_effect(idx, 0)
	text = "Record"


func _on_button_down() -> void:
	effect.set_recording_active(true)
	text = "Recording..."


func _on_button_up() -> void:
	recording = effect.get_recording()
	text = "Record"
	effect.set_recording_active(false)
	text = "Record"
	#print(recording)
	#print(recording.format)
	#print(recording.mix_rate)
	#print(recording.stereo)
	var data = recording.get_data()
	print(data.size())
