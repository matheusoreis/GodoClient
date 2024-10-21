class_name PingIncoming extends Node


func handle(_message : ServerMessage, scene_tree: SceneTree) -> void:
	var receiver_time: float = Time.get_ticks_msec()
	var latency: float = round(receiver_time - Globals.sender_ping_time)
	
	PingCore.new().core(scene_tree, latency)
