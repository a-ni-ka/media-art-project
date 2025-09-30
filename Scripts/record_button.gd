extends Button

var effect: AudioEffect
var recording: AudioStreamWAV
var format := AudioStreamWAV.FORMAT_16_BITS
var spectrum: AudioEffectInstance
var volume: float

@onready var audio_stream_record := $AudioStreamRecord
@onready var audio_stream_player := $AudioStreamPlayer


func _ready():
	# We get the index of the "Record" bus.
	var idx = AudioServer.get_bus_index("Record")
	# And use it to retrieve its first effect, which has been defined
	# as an "AudioEffectRecord" resource.
	effect = AudioServer.get_bus_effect(idx, 0)
	spectrum = AudioServer.get_bus_effect_instance(idx, 1)
	text = "Answer"


func _on_button_down() -> void:
	effect.set_recording_active(true)
	text = "Listening..."


func _on_button_up() -> void:
	text = "Answer"
	effect.set_recording_active(false)
	volume = spectrum.get_magnitude_for_frequency_range(0, 10000).length()
	recording = effect.get_recording()
	recording.set_format(format)
	audio_stream_player.stream = recording
	audio_stream_player.play()
	#print("button: ", volume)
