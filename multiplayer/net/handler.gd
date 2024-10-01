class_name Handler extends RefCounted


var request_handlers: Dictionary = {}

var pong: Pong = Pong.new()
var alert: Alert = Alert.new()
var access_successful: AccessSuccessful = AccessSuccessful.new()
var account_created: AccountCreated = AccountCreated.new()
var account_deleted: AccountDeleted = AccountDeleted.new()
var account_recovered: AccountRecovered = AccountRecovered.new()
var password_changed: PasswordChanged = PasswordChanged.new()
var character_list: CharacterList = CharacterList.new()
var character_created: CharacterCreated = CharacterCreated.new()
var character_deleted: CharacterDeleted = CharacterDeleted.new()
var character_selected: CharacterSelected = CharacterSelected.new()
var map_characters_to: MapCharactersTo = MapCharactersTo.new()
var new_character_to: NewCharacterTo = NewCharacterTo.new()
var character_moved: CharacterMoved = CharacterMoved.new()
var character_disconnected: CharacterDisconnected = CharacterDisconnected.new()
var character_teleported: CharacterTeleported = CharacterTeleported.new()
var chat_message_map: ChatMessageMap = ChatMessageMap.new()
var chat_message_global: ChatMessageGlobal = ChatMessageGlobal.new()
var chat_message_bubble: ChatMessageBubble = ChatMessageBubble.new()

func _init() -> void:
	request_handlers[ServerHeaders.Headers.PONG] = Callable(
		pong, "handle"
	)

	request_handlers[ServerHeaders.Headers.ALERT] = Callable(
		alert, "handle"
	)

	request_handlers[ServerHeaders.Headers.ACCESS_SUCCESSFUL] = Callable(
		access_successful, "handle"
	)

	request_handlers[ServerHeaders.Headers.ACCOUNT_CREATED] = Callable(
		account_created, "handle"
	)

	request_handlers[ServerHeaders.Headers.ACCOUNT_DELETED] = Callable(
		account_deleted, "handle"
	)

	request_handlers[ServerHeaders.Headers.ACCOUNT_RECOVERED] = Callable(
		account_recovered, "handle"
	)

	request_handlers[ServerHeaders.Headers.PASSWORD_CHANGED] = Callable(
		password_changed, "handle"
	)

	request_handlers[ServerHeaders.Headers.CHARACTER_LIST] = Callable(
		character_list, "handle"
	)

	request_handlers[ServerHeaders.Headers.CHARACTER_CREATED] = Callable(
		character_created, "handle"
	)

	request_handlers[ServerHeaders.Headers.CHARACTER_DELETED] = Callable(
		character_deleted, "handle"
	)

	request_handlers[ServerHeaders.Headers.CHARACTER_SELECTED] = Callable(
		character_selected, "handle"
	)

	request_handlers[ServerHeaders.Headers.MAP_CHARACTERS_TO] = Callable(
		map_characters_to, "handle"
	)

	request_handlers[ServerHeaders.Headers.NEW_CHARACTER_TO] = Callable(
		new_character_to, "handle"
	)

	request_handlers[ServerHeaders.Headers.CHARACTER_MOVED] = Callable(
		character_moved, "handle"
	)

	request_handlers[ServerHeaders.Headers.CHARACTER_DISCONNECTED] = Callable(
		character_disconnected, "handle"
	)

	request_handlers[ServerHeaders.Headers.CHAT_MESSAGE_MAP] = Callable(
		chat_message_map, "handle"
	)

	request_handlers[ServerHeaders.Headers.CHAT_MESSAGE_GLOBAL] = Callable(
		chat_message_global, "handle"
	)

	request_handlers[ServerHeaders.Headers.CHAT_MESSAGE_BUBBLE] = Callable(
		chat_message_bubble, "handle"
	)


func handle_message(message: ServerMessage, scene_tree: SceneTree) -> void:
	var message_id: int = message.get_id()
	var alert_ui: AlertUI = AlertUI.new()

	if request_handlers.has(message_id):
		var handler: Callable = request_handlers[message_id]
		if handler.is_valid():
			handler.call(message, scene_tree)
		else:
			alert_ui.show_alert(scene_tree, 'Erro ao processar a mensagem...')
