class_name ChatUI extends PanelContainer

@export_category('Componentes')
@export var chat_history: RichTextLabel
@export var chat_options: OptionButton
@export var chat_message: LineEdit
@export var send_message: Button


func add_history_message(message: String) -> void:
	chat_history.append_text(message + '\n')


func _on_send_message_pressed() -> void:
	if chat_message.text.length() < 3:
		return;

	ChatMessage.new(
		chat_options.get_selected_id(),
		chat_message.text,
	).send()
