class_name CharListIncoming extends RefCounted


func handle(message : ServerMessage, scene_tree: SceneTree) -> void:
    var character_list_tree := '/root/Main/Menu/ListCharacterUI'
    var character_list := scene_tree.root.get_node(character_list_tree) as CharacterUi

    var character_size := message.get_int8()
    var max_characters := message.get_int8()

    var characters := []

    for i in range(character_size):
        var character_id := message.get_int32()
        var character_name := message.get_string()
        var character_gender := message.get_string()
        var char_map := message.get_int32()
        var char_map_x := message.get_int32()
        var char_map_y := message.get_int32()
        var char_direction := message.get_int32()

        var character_data := {
            "id": character_id,
            "name": character_name,
            "gender": character_gender,
            "map": char_map,
            "x": char_map_x,
            "y": char_map_y,
            "direction": char_direction,
        }

        characters.append(character_data)

    character_list.show()
    character_list.update_character_panels(characters, max_characters)
