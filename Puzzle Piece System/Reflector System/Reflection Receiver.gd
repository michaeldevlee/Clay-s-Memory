extends Node2D
class_name Reflection_Receiver

signal receiver_status_changed (receiver, status)

var fully_shined : bool = false setget update_receiver_status

func update_receiver_status(value):
	fully_shined = value
	emit_signal("receiver_status_changed", self, fully_shined)
