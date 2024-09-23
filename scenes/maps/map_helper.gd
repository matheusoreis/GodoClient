class_name MapHelper extends Node

# Função para garantir que o mapa está instanciado no jogo
func ensure_map_is_instantiated(scene_tree: SceneTree) -> MapBase:
	var _alert: AlertUI = AlertUI.new()
	
	var current_map_tree := '/root/Main/Game/MapBase'
	var current_map = scene_tree.root.get_node_or_null(current_map_tree)

	if current_map == null:
		_alert.show_alert(scene_tree, 'Erro ao processar o mapa, desconectando...')
		Multiplayer.websocket.disconnect_from_host()
	
	return current_map as MapBase
