class_name ServertMessage extends RefCounted

var _buffer: StreamPeerBuffer


func _init(id: int):
	_buffer = StreamPeerBuffer.new()
	_buffer.data_array = PackedByteArray()
	_buffer.resize(2)
	_buffer.put_u16(id)


func put_bytes(value: PackedByteArray) -> void:
	_buffer.put_data(value)


func put_int8(value: int) -> void:
	_buffer.put_u8(value)


func put_int16(value: int) -> void:
	_buffer.put_u16(value)


func put_int32(value: int) -> void:
	_buffer.put_u32(value)


func put_string(value: String) -> void:
	_buffer.put_utf8_string(value)


func get_buffer() -> PackedByteArray:
	return _buffer.data_array
