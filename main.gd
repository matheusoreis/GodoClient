extends Control

@export var _fps_label: Label

var _client: WebSocketClient
var _handler: Handler
var _alert: AlertUI
var _constants: Constants

var _alert_timer: Timer
var _ping_interval: float = 1.0
var _time_elapsed: float = 0.0


func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	
	_client = Multiplayer.websocket
	_handler = Handler.new()
	_alert = AlertUI.new()
	_constants = Constants.new()
	
	_alert_timer = Timer.new()
	_alert_timer.set_wait_time(6)
	_alert_timer.set_one_shot(true)
	_alert.name = 'AlertTimer'
	add_child(_alert_timer)
	
	_client.connect_to_host(_constants.host, _constants.port)
	_client.connecting.connect(_on_connecting)
	_client.open.connect(_on_open)
	_client.closing.connect(_on_closing)
	_client.closed.connect(_on_closed)
	_client.received.connect(_on_received)


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_client.disconnect_from_host()
		get_tree().quit()


func _process(delta) -> void:
	_fps_label.text = 'Fps: ' + str(Engine.get_frames_per_second())
	
	if _client != null:
		_client.poll()

		_time_elapsed += delta
		if _time_elapsed >= _ping_interval:
			_send_ping()
			_time_elapsed = 0.0


func _on_connecting() -> void:
	_alert.show_alert(get_tree(), 'Conectando ao servidor...')


func _on_open() -> void:
	_alert.show_alert(get_tree(), 'Conectado ao servidor...')


func _on_closing() -> void:
	if not _alert_timer.is_stopped():
		return

	_alert.show_alert(get_tree(), 'Desconectando do servidor...')
	_alert_timer.start()


func _on_closed() -> void:
	if not _alert_timer.is_stopped():
		return

	_alert.show_alert(get_tree(), 'Não foi possível se conectar ao servidor!')
	_alert_timer.start()


func _on_received(buffer: PackedByteArray) -> void:
	if buffer.size() < 2:
		_client.disconnect_from_host()
		return

	var client_message: ServerMessage = ServerMessage.new(buffer)
	_handler.handle_message(client_message, get_tree())


func _send_ping() -> void:
	var ping_message = Ping.new()
	Globals.sender_ping_time = Time.get_ticks_msec()
	ping_message.send()
