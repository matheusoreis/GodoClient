class_name MoveChar extends ClientMessage


func _init(posX: int, posY: int, direction: int, animation: String) -> void:
	super._init(ClientHeaders.list.MoveChar)
	
	self.put_int32(posX)
	self.put_int32(posY)
	self.put_int32(direction)
	self.put_string(animation)
