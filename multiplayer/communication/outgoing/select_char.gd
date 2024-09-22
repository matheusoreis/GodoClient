class_name SelectChar extends ClientMessage


func _init(character_id: int, map_id: int) -> void:
    super._init(ClientHeaders.list.SelectChar)

    self.put_int32(character_id)
    self.put_int32(map_id)
