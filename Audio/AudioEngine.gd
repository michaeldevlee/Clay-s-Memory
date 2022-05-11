extends Node2D

onready var sfx_player = get_node("SFX Player")
onready var music_player = get_node("AudioStreamPlayer")

var level_music = preload("res://Audio/LevelMusic.wav")

func play_SFX(stream : AudioStream, volume):
	sfx_player.set_volume_db(volume)
	sfx_player.set_stream(stream)
	sfx_player.play()

func play_music (stream : AudioStream, volume):
	music_player.set_volume_db(volume)
	music_player.set_stream(stream)
	music_player.play()
