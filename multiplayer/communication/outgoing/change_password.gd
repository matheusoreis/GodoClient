class_name ChangePassword extends ClientMessage


func _init() -> void:
	super._init(ClientHeaders.Headers.CHANGE_PASSWORD)
