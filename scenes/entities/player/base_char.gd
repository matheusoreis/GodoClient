class_name BaseCharacter
extends CharacterBody2D

@export var _name: Label
@export var _camera: Camera2D
@export var _raycast: RayCast2D
@export var _texture: Sprite2D
@export var _animation: AnimationPlayer
@export var target_area: Area2D


@export_category('Variables')
@export var _move_speed: float = 96
@export var _raycast_vertical =  8
@export var _raycast_horizontal = 12

var player_id: int
var player_name: String
var is_local_player: bool = true


enum Direction {
	LEFT,
	UP,
	RIGHT,
	DOWN,
}

var last_direction: Vector2 = Vector2.ZERO
var direction_to_server: Direction
var previous_position: Vector2 = Vector2.ZERO

var time_since_last_send: float = 0.0
var send_delay: float = 0.1


signal char_clicked(char: BaseCharacter)


func _ready() -> void:
	_camera.enabled = is_local_player
	_name.text = player_name
	target_area.position = previous_position


func _physics_process(delta: float) -> void:
	if is_local_player:
		_move()
		
		_update_raycast()
		
		if _raycast.is_colliding():
			velocity = Vector2.ZERO
			_play_idle_animation() 
		else:
			move_and_slide()
		
		_check_position_change(delta)
		_update_animation()


func _move() -> void:
	var direction: Vector2 = Vector2(
		Input.get_axis("walking_left", "walking_right"),
		Input.get_axis("walking_up", "walking_down")
	)
	
	if direction != Vector2.ZERO:
		last_direction = direction.normalized()
		_update_direction_to_server()

	velocity = direction.normalized() * _move_speed


func _update_animation() -> void:
	if velocity.length() == 0:
		_play_idle_animation()
	else:
		_play_walking_animation()


func _update_direction_to_server() -> void:
	if last_direction.x < 0:
		direction_to_server = Direction.LEFT
	elif last_direction.x > 0:
		direction_to_server = Direction.RIGHT
	elif last_direction.y < 0:
		direction_to_server = Direction.UP
	elif last_direction.y > 0:
		direction_to_server = Direction.DOWN


func _check_position_change(delta: float) -> void:
	if position != previous_position:
		time_since_last_send += delta
		
		if time_since_last_send >= send_delay:
			send_movement()
			previous_position = position
			time_since_last_send = 0.0


func _update_raycast() -> void:
	var raycast_length: float
	
	if last_direction.y != 0:
		raycast_length = _raycast_vertical
	else:
		raycast_length = _raycast_horizontal

	_raycast.target_position = last_direction * raycast_length
	_raycast.force_raycast_update()


func _play_idle_animation() -> void:
	if last_direction.x < 0:
		_animation.play("idle_left")
	elif last_direction.x > 0:
		_animation.play("idle_right")
	elif last_direction.y < 0:
		_animation.play("idle_up")
	elif last_direction.y > 0:
		_animation.play("idle_down")


func _play_walking_animation() -> void:
	if velocity.x < 0:
		_animation.play("walking_left")
	elif velocity.x > 0:
		_animation.play("walking_right")
	elif velocity.y < 0:
		_animation.play("walking_up")
	elif velocity.y > 0:
		_animation.play("walking_down")


func send_movement():
	var move_message = MoveChar.new(round(position.x), round(position.y), direction_to_server)
	move_message.send()


func update_remote_position(new_position: Vector2, new_direction: int):
	if not is_local_player:
		var tween = create_tween()
		tween.tween_property(self, "position", new_position, 0.1)


func _on_target_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print('emitiu')
