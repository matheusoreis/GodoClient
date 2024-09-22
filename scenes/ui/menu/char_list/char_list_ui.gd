class_name CharacterUi extends PanelContainer


@export_category('Referências')
@export var access_account_ui: PanelContainer
@export var slots_hbox: HBoxContainer


func update_character_panels(characters: Array, max_characters: int) -> void:
	var slot_panel_res := preload("res://scenes/ui/menu/char_list/slot_panel.tscn") as PackedScene

	for child in slots_hbox.get_children():
		slots_hbox.remove_child(child)
		child.queue_free()

	for i in range(max_characters):
		var panel_instantiate: Panel = slot_panel_res.instantiate() as Panel
		slots_hbox.add_child(panel_instantiate)

		var character_content: VBoxContainer = panel_instantiate.get_node('ContentMargin/ContentVBox')
		var new_button: Button = panel_instantiate.get_node('ContentMargin/NewButton')

		if i < characters.size():
			var character_data = characters[i]

			var name_label: Label = panel_instantiate.get_node('ContentMargin/ContentVBox/NameLabel')
			if name_label:
				name_label.text = character_data["name"]

			var play_button: Button = panel_instantiate.get_node('ContentMargin/ContentVBox/PlayButton')
			if play_button:
				play_button.pressed.connect(_on_play_button_pressed.bind(panel_instantiate, character_data["id"], character_data["map"]))

			var delete_button: Button = panel_instantiate.get_node('ContentMargin/ContentVBox/DeleteButton')
			if delete_button:
				delete_button.pressed.connect(_on_delete_button_pressed.bind(panel_instantiate, character_data["id"]))

			character_content.show()
			new_button.hide()
		else:
			character_content.hide()
			new_button.show()

			if new_button:
				new_button.pressed.connect(_on_new_button_pressed.bind(panel_instantiate, i))



func _on_new_button_pressed(_panel: Panel, _index: int) -> void:
	hide()
	var create_char_tree := '/root/Main/Menu/CreateCharUI'
	var create_char_ui = get_tree().root.get_node(create_char_tree) as PanelContainer
	create_char_ui.show()


func _on_play_button_pressed(_panel: Panel, id: int, map: int) -> void:
	var outgoing = SelectChar.new(id, map)
	outgoing.send()


func _on_delete_button_pressed(_panel: Panel, index: int,) -> void:
	var outgoing = DeleteChar.new(index)
	outgoing.send()


func _on_close_button_pressed() -> void:
	get_tree().quit()