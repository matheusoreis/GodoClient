extends PanelContainer

@export_category('Componentes')
@export var name_line: LineEdit
@export var create_button: Button
@export var genders_button: OptionButton

@export_category('Referências')
@export var character_list_ui: PanelContainer


func _on_close_button_pressed() -> void:
	self.hide()
	character_list_ui.show()


func _on_create_button_pressed() -> void:
	CreateCharacter.new(name_line.text, genders_button.get_selected_id()).send()
