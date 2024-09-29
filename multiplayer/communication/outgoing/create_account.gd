class_name CreateAccount extends ClientMessage


var constants = Constants.new()


func _init(email: String, password: String) -> void:
	super._init(ClientHeaders.Headers.CREATE_ACCOUNT)

	self.put_string(email)
	self.put_string(password)
	self.put_int16(constants.major_version)
	self.put_int16(constants.minor_version)
	self.put_int16(constants.revision_version)
