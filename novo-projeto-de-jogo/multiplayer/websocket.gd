class_name WebSocketClient extends RefCounted

signal connected
signal disconnected
signal packet_received(packet_buf: PackedByteArray)

var _socket: WebSocketPeer
var _connected: bool = false


func _init():
	_socket = WebSocketPeer.new()


func connect_to_host(host: String, port: int, use_ssl := false) -> Error:
	var url = "ws://" + host + ":" + str(port)

	if use_ssl:
		url = "wss://" + host + ":" + str(port)

	var error = _socket.connect_to_url(url)

	if error != OK:
		return error

	return OK


func disconnect_from_host() -> void:
	_socket.close()
	_connected = false
	disconnected.emit()


func send_packet(packet: Packet) -> Error:
	if not _connected:
		return ERR_CONNECTION_ERROR

	var result := _socket.put_packet(packet.to_packet_byte_array())
	if result != OK:
		disconnect_from_host()

	return result


func poll() -> void:
	_socket.poll()
	var state = _socket.get_ready_state()

	if state == WebSocketPeer.STATE_OPEN:
		if not _connected:
			_connected = true
			connected.emit()

		while _socket.get_available_packet_count() > 0:
			var packet = _socket.get_packet()
			packet_received.emit(packet)

	elif state == WebSocketPeer.STATE_CLOSING or state == WebSocketPeer.STATE_CLOSED:
		if _connected:
			_connected = false
			disconnected.emit()
