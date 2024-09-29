class_name MapHelper extends Node

# Função para garantir que o mapa está instanciado no jogo
func ensure_map_is_instantiated(scene_tree: SceneTree, current_map: int) -> BaseMap:
	var alert_ui: AlertUI = AlertUI.new()

	var current_map_location := '/root/Main/Game/Map' + str(current_map)
	var current_map_node = scene_tree.root.get_node_or_null(
		current_map_location
	)

	if current_map_node == null:
		alert_ui.show_alert(scene_tree, 'Erro ao processar o mapa, desconectando...')
		Multiplayer.websocket.disconnect_from_host()

	return current_map_node as BaseMap
