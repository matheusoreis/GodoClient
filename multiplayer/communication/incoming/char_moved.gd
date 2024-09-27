class_name CharacterMoved extends RefCounted

func handle(message: ServerMessage, scene_tree: SceneTree) -> void:
    var char_id := message.get_int32()
    var _char_map := message.get_int32()
    var action := message.get_int8()
    var position_x := message.get_int32()
    var position_y := message.get_int32()
    var direction := message.get_int8()
    var velocity_x := message.get_int32()
    var velocity_y := message.get_int32()

    var current_map_tree := '/root/Main/Game/MapBase/Chars'
    var current_map = scene_tree.root.get_node(current_map_tree)

    if current_map:
        var character_instance: BaseCharacter = current_map.get_node_or_null(str(char_id))

        if character_instance and not character_instance.is_local_player:
            character_instance.update_remote_position(
                action,
                position_x,
                position_y,
                direction,
                velocity_x,
                velocity_y
            )
