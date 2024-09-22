class_name CreateAccount extends ClientMessage


func _init(email: String, password: String) -> void:
    super._init(ClientHeaders.list.CreateAccount)
    var constants = Constants.new()

    self.put_string(email)
    self.put_string(password)
    self.put_int16(constants.major_version)
    self.put_int16(constants.minor_version)
    self.put_int16(constants.revision_version)
