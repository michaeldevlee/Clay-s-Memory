extends Node2D
class_name Reflection_Receiver_Key

signal all_receivers_shined

var receiver_list = {}
var receiver_list_values

func _ready():
	var receivers = get_children()
	
	if receivers:
		for x in receivers.size():
			var receiver = receivers[x]
			if receiver.is_in_group("Receiver"):
				receiver.connect("receiver_status_changed", self, "update_receiver_status")
				receiver_list[receiver] = false
	
	print(receiver_list)

func update_receiver_status(receiver : Reflection_Receiver, shined : bool):
	
	print(receiver)
	if receiver and receiver_list:
		receiver_list[receiver] = shined
	
	receiver_list_values = receiver_list.values()
	
	if receiver_list_values.has(false):
		print("not done yet")
		return
	
	print("finished all receivers")
	emit_signal("all_receivers_shined")
