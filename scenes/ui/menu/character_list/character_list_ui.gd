class_name CharacterListUI extends PanelContainer


@export_category('Referências')
@export var slots_hbox: HBoxContainer


func update_character_panels(characters: Array, max_characters: int) -> void:
	const slot_panel_location: String = 'res://scenes/ui/menu/character_list/slot_panel.tscn'
	var slot_panel_preload: PackedScene = preload(slot_panel_location)

	for child in slots_hbox.get_children():
		slots_hbox.remove_child(child)
		child.queue_free()

	for i in range(max_characters):
		var slot_panel_instantiate: Panel = slot_panel_preload.instantiate()
		slots_hbox.add_child(slot_panel_instantiate)

		var character_content: VBoxContainer = slot_panel_instantiate.get_node(
			'ContentMargin/ContentVBox'
		)

		var new_character_button: Button = slot_panel_instantiate.get_node(
			'ContentMargin/NewButton'
		)

		if i < characters.size():
			var character_data = characters[i]

			var name_label: Label = slot_panel_instantiate.get_node(
				'ContentMargin/ContentVBox/NameLabel'
			)
			if name_label:
				name_label.text = character_data["character_name"]

			var play_button: Button = slot_panel_instantiate.get_node(
				'ContentMargin/ContentVBox/PlayButton'
			)
			if play_button:
				play_button.pressed.connect(
					_on_play_button_pressed.bind(
						character_data["character_id"],
						character_data["character_current_map"]
					)
				)

			var delete_button: Button = slot_panel_instantiate.get_node(
				'ContentMargin/ContentVBox/DeleteButton'
			)
			if delete_button:
				delete_button.pressed.connect(
					_on_delete_button_pressed.bind(
						character_data["character_id"]
					)
				)

			character_content.show()
			new_character_button.hide()
		else:
			character_content.hide()
			new_character_button.show()

			if new_character_button:
				new_character_button.pressed.connect(
					_on_new_button_pressed.bind()
				)


func _on_new_button_pressed() -> void:
	self.hide()
	var create_char_tree := '/root/Main/MenuUI/CreateCharacterUI'
	var create_char_ui = get_tree().root.get_node(create_char_tree) as PanelContainer
	create_char_ui.show()


func _on_play_button_pressed(id: int, map: int) -> void:
	SelectCharacter.new(id).send()


func _on_delete_button_pressed(index: int,) -> void:
	DeleteCharacter.new(index).send()


func _on_close_button_pressed() -> void:
	get_tree().quit()
