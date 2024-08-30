class_name ClientMessage extends RefCounted

var _buffer: StreamPeerBuffer


func _init(buffer: PackedByteArray):
	_buffer = StreamPeerBuffer.new()
	_buffer.data_array = buffer
	_buffer.seek(0)


func get_id() -> int:
	return _buffer.get_16()


func get_content() -> PackedByteArray:
	var content_size = _buffer.get_available_bytes()
	var content = PackedByteArray()
	content.resize(content_size)
	_buffer.get_data(content)
	return content


func get_int8() -> int:
	return _buffer.get_u8()


func get_int16() -> int:
	return _buffer.get_u16()


func get_int32() -> int:
	return _buffer.get_u32()


func get_string() -> String:
	return _buffer.get_utf8_string()
