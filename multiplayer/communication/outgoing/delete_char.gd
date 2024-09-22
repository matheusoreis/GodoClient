class_name DeleteChar extends ClientMessage


func _init(character_id: int) -> void:
    super._init(ClientHeaders.list.DeleteChar)

    self.put_int32(character_id)
