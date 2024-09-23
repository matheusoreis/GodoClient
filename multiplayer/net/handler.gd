class_name Handler extends RefCounted

var request_handlers: Dictionary = {}
var ping_incoming: Pong
var alert_incoming: AlertIncoming
var access_account: AccessAccountSuccess
var create_account: CreateAccountSuccess
var delete_account: DeleAccountSuccess
var recover_account: RecoverAccountSuccess
var change_password: ChangePasswordSuccess
var char_list: CharListIncoming
var char_created: CharCreated
var char_deleted: CharDeleted
var char_selected: CharSelected
var map_chars_to: MapCharsTo
var new_char_to: NewCharToMap
var char_moved: CharMoved
var char_disconnected: CharDisconnected


func _init() -> void:
	ping_incoming = Pong.new()
	alert_incoming = AlertIncoming.new()
	access_account = AccessAccountSuccess.new()
	create_account = CreateAccountSuccess.new()
	delete_account = DeleAccountSuccess.new()
	recover_account = RecoverAccountSuccess.new()
	change_password = ChangePasswordSuccess.new()
	char_list = CharListIncoming.new()
	char_created = CharCreated.new()
	char_deleted = CharDeleted.new()
	char_selected = CharSelected.new()
	map_chars_to = MapCharsTo.new()
	new_char_to = NewCharToMap.new()
	char_moved = CharMoved.new()
	char_disconnected = CharDisconnected.new()

	register_requests()


func register_requests() -> void:
	request_handlers[ServerHeaders.list.Ping] = Callable(ping_incoming, "handle")
	request_handlers[ServerHeaders.list.Alert] = Callable(alert_incoming, "handle")
	request_handlers[ServerHeaders.list.AccessAccountSuccess] = Callable(access_account, "handle")
	request_handlers[ServerHeaders.list.CreateAccountSuccess] = Callable(create_account, "handle")
	request_handlers[ServerHeaders.list.DeleteAccountSuccess] = Callable(delete_account, "handle")
	request_handlers[ServerHeaders.list.RecoverAccountSuccess] = Callable(recover_account, "handle")
	request_handlers[ServerHeaders.list.ChangePasswordSuccess] = Callable(change_password, "handle")
	request_handlers[ServerHeaders.list.CharList] = Callable(char_list, "handle")
	request_handlers[ServerHeaders.list.CharCreated] = Callable(char_created, "handle")
	request_handlers[ServerHeaders.list.CharDeleted] = Callable(char_deleted, "handle")
	request_handlers[ServerHeaders.list.CharSelected] = Callable(char_selected, "handle")
	request_handlers[ServerHeaders.list.MapCharsTo] = Callable(map_chars_to, "handle")
	request_handlers[ServerHeaders.list.NewCharToMap] = Callable(new_char_to, "handle")
	request_handlers[ServerHeaders.list.CharMoved] = Callable(char_moved, "handle")
	request_handlers[ServerHeaders.list.CharDisconnected] = Callable(char_disconnected, "handle")


func handle_message(message: ServerMessage, scene_tree: SceneTree) -> void:
	var message_id: int = message.get_id()
	var alert: AlertUI = AlertUI.new()

	if request_handlers.has(message_id):
		var handler: Callable = request_handlers[message_id]
		if handler.is_valid():
			handler.call(message, scene_tree)
		else:
			alert.show_alert(scene_tree, 'Erro ao processar a mensagem...')
