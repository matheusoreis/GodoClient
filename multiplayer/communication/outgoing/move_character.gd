class_name MoveCharacter extends ClientMessage


func _init(action: int, position_x: int, position_y: int, direction: int, velocity_x: int, velocity_y: int) -> void:
	super._init(ClientHeaders.Headers.MOVE_CHARACTER)

	self.put_int8(action)
	self.put_int32(position_x)
	self.put_int32(position_y)
	self.put_int8(direction)
	self.put_int32(velocity_x)
	self.put_int32(velocity_y)
