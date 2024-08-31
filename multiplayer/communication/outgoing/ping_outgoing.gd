class_name PingOutgoing extends ClientMessage


func _init() -> void:
	super._init(ServerHeaders.list.pong)
