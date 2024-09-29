class_name CreateCharacter extends ClientMessage


func _init(name: String, gender_id: int) -> void:
	super._init(ClientHeaders.Headers.CREATE_CHARACTER)

	self.put_string(name)
	self.put_int32(gender_id)
