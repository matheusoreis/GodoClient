class_name MoveChar extends ClientMessage


func _init(action: int, positionX: int, positionY: int, direction: int, velocityX: int, velocityY: int) -> void:
    super._init(ClientHeaders.list.MoveChar)

    self.put_int8(action)
    self.put_int32(positionX)
    self.put_int32(positionY)
    self.put_int8(direction)
    self.put_int32(velocityX)
    self.put_int32(velocityY)
