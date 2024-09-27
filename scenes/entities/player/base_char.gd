class_name BaseCharacter
extends CharacterBody2D

@export var _name: Label
@export var _camera: Camera2D
@export var _raycast: RayCast2D
@export var _texture: Sprite2D
@export var _animation: AnimationPlayer
@export var target_area: Area2D

var player_id: int
var player_name: String
var is_local_player: bool = true

@export_category('Variables')
@export var _raycast_vertical =  8
@export var _raycast_horizontal = 12

@export var _move_speed: float = 100

enum CHAR_DIRECTION {
	LEFT,
	UP,
	RIGHT,
	DOWN
}

enum CHAR_ACTION {
	IDLE,
	WALKING,
}

var _is_moving: bool = false
var action: CHAR_ACTION = CHAR_ACTION.IDLE
var direction: CHAR_DIRECTION = CHAR_DIRECTION.DOWN

var time_since_last_send: float = 0.0
var send_delay: float = 0.05


func _ready() -> void:
	_camera.enabled = is_local_player
	_name.text = player_name


func _physics_process(delta: float) -> void:
	if is_local_player:
		_move(delta)
		_update_animation(direction)


func _move(delta: float) -> void:
	var direction_vector: Vector2 = _get_input_direction()

	if direction_vector.length() > 0:
		velocity = direction_vector.normalized() * _move_speed
		_is_moving = true
		action = CHAR_ACTION.WALKING

		if direction_vector.x < 0:
			direction = CHAR_DIRECTION.LEFT
		elif direction_vector.x > 0:
			direction = CHAR_DIRECTION.RIGHT
		elif direction_vector.y < 0:
			direction = CHAR_DIRECTION.UP
		elif direction_vector.y > 0:
			direction = CHAR_DIRECTION.DOWN

		time_since_last_send += delta
		if time_since_last_send >= send_delay:
			send_movement()
			time_since_last_send = 0.0
	else:
		if !_is_moving:
			send_movement()

		velocity = Vector2.ZERO
		_is_moving = false
		action = CHAR_ACTION.IDLE

	move_and_slide()


func _get_input_direction() -> Vector2:
	var direction_vector: Vector2 = Vector2(
			Input.get_axis("walking_left", "walking_right"),
			Input.get_axis("walking_up", "walking_down")
	)

	return direction_vector


func send_movement():
	var move_message = MoveChar.new(
		action,
		round(position.x),
		round(position.y),
		direction,
		velocity.x,
		velocity.y
	)

	move_message.send()


func update_remote_position(action: int, position_x: int, position_y: int, direction: int, velocity_x: int, velocity_y: int):
	if not is_local_player:
		var remote_action = int_to_action(action)
		var remote_direction = int_to_direction(direction)

		if remote_action == CHAR_ACTION.WALKING:
			_is_moving = true
		else:
			_is_moving = false

		var tween = create_tween()
		var new_position: Vector2 = Vector2(position_x, position_y)
		tween.tween_property(self, "position", new_position, 0.1)

		print('Action: ', action)
		print('Direction: ', direction)
		_update_animation(remote_direction)


func _update_animation(direction: CHAR_DIRECTION) -> void:
	if _is_moving:
		_play_idle_animation(direction)
	else:
		_play_walking_animation(direction)


func _play_idle_animation(direction: CHAR_DIRECTION):
	if direction == CHAR_DIRECTION.LEFT:
		_animation.play("walking_left")
	elif direction == CHAR_DIRECTION.UP:
		_animation.play("walking_up")
	elif direction == CHAR_DIRECTION.RIGHT:
		_animation.play("walking_right")
	elif direction == CHAR_DIRECTION.DOWN:
		_animation.play("walking_down")


func _play_walking_animation(direction: CHAR_DIRECTION):
	if direction == CHAR_DIRECTION.LEFT:
		_animation.play("idle_left")
	elif direction == CHAR_DIRECTION.UP:
		_animation.play("idle_up")
	elif direction == CHAR_DIRECTION.RIGHT:
		_animation.play("idle_right")
	elif direction == CHAR_DIRECTION.DOWN:
		_animation.play("idle_down")


func int_to_action(action_int: int) -> CHAR_ACTION:
	var current_action: CHAR_ACTION

	match action_int:
		0:
			current_action = CHAR_ACTION.IDLE
		1:
			current_action = CHAR_ACTION.WALKING
		_ :
			current_action = CHAR_ACTION.IDLE

	return current_action


func int_to_direction(direction_int: int) -> CHAR_DIRECTION:
	var current_direction: CHAR_DIRECTION

	match direction_int:
		0:
			current_direction = CHAR_DIRECTION.LEFT
		1:
			current_direction = CHAR_DIRECTION.UP
		2:
			current_direction = CHAR_DIRECTION.RIGHT
		3:
			current_direction = CHAR_DIRECTION.DOWN
		_ :
			current_direction = CHAR_DIRECTION.DOWN

	return current_direction


func direction_to_vector():
	pass
