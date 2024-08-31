class_name WebSocketClient extends Node

signal connecting
signal open
signal closing
signal closed
signal received(packet_buf: PackedByteArray)

var _socket: WebSocketPeer
var _connected: bool = false
var _alert: AlertUI
var _handler: Handler

func _init():
	_socket = WebSocketPeer.new()
	_alert = AlertUI.new()
	_handler = Handler.new()


func connect_to_host(host: String, port: int, use_ssl := false) -> void:
	var url = "ws://" + host + ":" + str(port)

	if use_ssl:
		url = "wss://" + host + ":" + str(port)

	var error = _socket.connect_to_url(url)

	if error != OK:
		_connected = false
		closed.emit()
	else:
		connecting.emit()


func disconnect_from_host() -> void:
	_socket.close()
	closing.emit()
	closed.emit()


func send_message(message: ClientMessage) -> Error:
	if !_connected:
		return ERR_CONNECTION_ERROR

	var result := _socket.put_packet(message.get_buffer())

	if result != OK:
		disconnect_from_host()

	return result


func poll() -> void:
	_socket.poll()
	var state := _socket.get_ready_state()

	print(state)

	match state:
		WebSocketPeer.STATE_CONNECTING:
			connecting.emit()

		WebSocketPeer.STATE_OPEN:
			if !_connected:
				_connected = true
				open.emit()

				while _socket.get_available_packet_count() > 0:
					var packet = _socket.get_packet()
					received.emit(packet)

		WebSocketPeer.STATE_CLOSING:
			closing.emit()

		WebSocketPeer.STATE_CLOSED:
			closed.emit()
