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
var char_created: CharacterCreated
var char_deleted: CharacterDeleted
var char_selected: CharacterSelected
var map_chars_to: NotifyExistingCharacters
var new_char_to: OthersOfNewCharacter
var char_moved: CharacterMoved
var char_disconnected: CharacterDisconnected


func _init() -> void:
	ping_incoming = Pong.new()
	alert_incoming = AlertIncoming.new()
	access_account = AccessAccountSuccess.new()
	create_account = CreateAccountSuccess.new()
	delete_account = DeleAccountSuccess.new()
	recover_account = RecoverAccountSuccess.new()
	change_password = ChangePasswordSuccess.new()
	char_list = CharListIncoming.new()
	char_created = CharacterCreated.new()
	char_deleted = CharacterDeleted.new()
	char_selected = CharacterSelected.new()
	map_chars_to = NotifyExistingCharacters.new()
	new_char_to = OthersOfNewCharacter.new()
	char_moved = CharacterMoved.new()
	char_disconnected = CharacterDisconnected.new()

	register_requests()


func register_requests() -> void:
	request_handlers[ServerHeaders.list.Ping] = Callable(ping_incoming, "handle")
	request_handlers[ServerHeaders.list.Alert] = Callable(alert_incoming, "handle")
	request_handlers[ServerHeaders.list.AccessAccountSuccess] = Callable(access_account, "handle")
	request_handlers[ServerHeaders.list.CreateAccountSuccess] = Callable(create_account, "handle")
	request_handlers[ServerHeaders.list.DeleteAccountSuccess] = Callable(delete_account, "handle")
	request_handlers[ServerHeaders.list.RecoverAccountSuccess] = Callable(recover_account, "handle")
	request_handlers[ServerHeaders.list.ChangePasswordSuccess] = Callable(change_password, "handle")
	request_handlers[ServerHeaders.list.CharacterList] = Callable(char_list, "handle")
	request_handlers[ServerHeaders.list.CharacterCreated] = Callable(char_created, "handle")
	request_handlers[ServerHeaders.list.CharacterDeleted] = Callable(char_deleted, "handle")
	request_handlers[ServerHeaders.list.CharacterSelected] = Callable(char_selected, "handle")
	request_handlers[ServerHeaders.list.NotifyExistingCharacters] = Callable(map_chars_to, "handle")
	request_handlers[ServerHeaders.list.OthersOfNewCharacter] = Callable(new_char_to, "handle")
	request_handlers[ServerHeaders.list.CharacterMoved] = Callable(char_moved, "handle")
	request_handlers[ServerHeaders.list.CharacterDisconnected] = Callable(char_disconnected, "handle")


func handle_message(message: ServerMessage, scene_tree: SceneTree) -> void:
	var message_id: int = message.get_id()
	var alert: AlertUI = AlertUI.new()

	if request_handlers.has(message_id):
		var handler: Callable = request_handlers[message_id]
		if handler.is_valid():
			handler.call(message, scene_tree)
		else:
			alert.show_alert(scene_tree, 'Erro ao processar a mensagem...')
