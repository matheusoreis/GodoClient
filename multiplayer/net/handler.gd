class_name Handler extends RefCounted

var request_handlers: Dictionary = {}
var ping_incoming: PingIncoming
var alert_incoming: AlertIncoming

func _init() -> void:
	register_requests()


func register_requests() -> void:
	ping_incoming = PingIncoming.new()
	alert_incoming = AlertIncoming.new()

	request_handlers[ServerHeaders.list.ping] = Callable(ping_incoming, "handle")
	request_handlers[ServerHeaders.list.alert] = Callable(alert_incoming, "handle")


func handle_message(message: ServerMessage, scene_tree: SceneTree) -> void:
	var message_id: int = message.get_id()

	if request_handlers.has(message_id):
		var handler: Callable = request_handlers[message_id]
		if handler.is_valid():
			handler.call(message, scene_tree)
		else:
			print("Não válido: ", message_id)
