class_name CreateChar extends ClientMessage


func _init(name: String, gender_id: int) -> void:
    super._init(ClientHeaders.list.CreateChar)

    self.put_string(name)
    self.put_int32(gender_id)
