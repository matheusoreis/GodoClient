class_name Handler extends RefCounted


var request_handlers: Dictionary = {}

var ping: PingIncoming = PingIncoming.new()
var alert: AlertIncoming = AlertIncoming.new()
var access_account: AccessAccountIncoming = AccessAccountIncoming.new()
var account_created: CreateAccountIncoming = CreateAccountIncoming.new()
#var account_deleted: AccountDeleted = AccountDeleted.new()
#var account_recovered: AccountRecovered = AccountRecovered.new()
#var password_changed: PasswordChanged = PasswordChanged.new()
#var character_list: CharacterList = CharacterList.new()
#var character_created: CharacterCreated = CharacterCreated.new()
#var character_deleted: CharacterDeleted = CharacterDeleted.new()
#var character_selected: CharacterSelected = CharacterSelected.new()
#var map_characters_to: MapCharactersTo = MapCharactersTo.new()
#var new_character_to: NewCharacterTo = NewCharacterTo.new()
#var character_moved: CharacterMoved = CharacterMoved.new()
#var character_disconnected: CharacterDisconnected = CharacterDisconnected.new()
#var character_teleported: CharacterTeleported = CharacterTeleported.new()


func _init() -> void:
	request_handlers[ServerHeaders.Headers.PING] = Callable(
		ping, "handle"
	)

	request_handlers[ServerHeaders.Headers.ALERT] = Callable(
		alert, "handle"
	)

	request_handlers[ServerHeaders.Headers.ACCESS_ACCOUNT] = Callable(
		access_account, "handle"
	)
#
	#request_handlers[ServerHeaders.Headers.CREATE_ACCOUNT] = Callable(
		#account_created, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.DELETE_ACCOUNT] = Callable(
		#account_deleted, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.RECOVER_ACCOUNT] = Callable(
		#account_recovered, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.CHANGE_PASSWORD] = Callable(
		#password_changed, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.CHARACTER_LIST] = Callable(
		#character_list, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.CREATE_CHARACTER] = Callable(
		#character_created, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.DELETE_CHARACTER] = Callable(
		#character_deleted, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.SELECT_CHARACTER] = Callable(
		#character_selected, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.MAP_CHARACTERS_TO] = Callable(
		#map_characters_to, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.NEW_CHARACTER_TO] = Callable(
		#new_character_to, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.MOVE_CHARACTER] = Callable(
		#character_moved, "handle"
	#)
#
	#request_handlers[ServerHeaders.Headers.DISCONNECT_CHARACTER] = Callable(
		#character_disconnected, "handle"
	#)
	#
	#request_handlers[ServerHeaders.Headers.TELEPORT_CHARACTER] = Callable(
		#character_teleported, "handle"
	#)


func handle_message(message: ServerMessage, scene_tree: SceneTree) -> void:
	var message_id: int = message.get_id()
	var alert_ui: AlertUI = AlertUI.new()
	
	if request_handlers.has(message_id):
		var handler: Callable = request_handlers[message_id]
		
		if handler.is_valid():
			handler.call(message, scene_tree)
		else:
			alert_ui.show_alert(scene_tree, 'Erro ao processar a mensagem...')
