class_name CreateCharacter extends ClientMessage


func _init(name: String, gender_id: int, character_texture: String) -> void:
	super._init(ClientHeaders.Headers.CREATE_CHARACTER)

	self.put_string(name)
	self.put_int8(gender_id)
	self.put_string(character_texture)
