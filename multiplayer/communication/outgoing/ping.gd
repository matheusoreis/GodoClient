class_name Ping extends ClientMessage


func _init() -> void:
    super._init(ClientHeaders.list.Pong)
