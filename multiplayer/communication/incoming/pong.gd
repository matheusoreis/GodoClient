class_name Pong extends RefCounted


const ping_label_location: String = '/root/Main/Shared/InfoLocation/ContentVBox/PingLabel'


func handle(_message : ServerMessage, scene_tree: SceneTree) -> void:
    var receiver_time := Time.get_ticks_msec()
    var latency = round(receiver_time - Globals.sender_ping_time)

    var label: Label = scene_tree.root.get_node(ping_label_location) as Label

    if label == null:
        return

    var ping: String
    if latency < 5:
        ping = 'Local'
    else:
        ping = str(latency)

    label.text = 'Ping: ' + ping
