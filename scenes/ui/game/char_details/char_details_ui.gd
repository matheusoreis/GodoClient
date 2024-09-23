class_name CharacterDetail extends PanelContainer

@export_category('Componentes')
@export var title_label: Label
@export var gender_label: Label


func _on_close_button_pressed() -> void:
	title_label.text = ''
	gender_label.text = ''
	hide()
