class_name BaseCharacter
extends CharacterBody2D

@export_category('Nodes')
@export var _name: Label
@export var _camera: Camera2D
@export var _raycast: RayCast2D
@export var _texture: Sprite2D
@export var _animation: AnimationPlayer
@export var target_area: Area2D
@export var _emote_sprite: Sprite2D
@export var _emote_animation: AnimationPlayer

var player_id: int
var player_name: String
var is_local_player: bool = true
var gender: String

@export_category('Variables')
@export var _raycast_size =  13
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

enum Emotes {
	ANGRY,
	ATTENTION,
	CONFUSED,
	IDEA,
	LOVE,
	MUSIC,
	QUESTION,
	SHAME,
	SLEEPING,
	TALKING
}

var _is_moving: bool = false
var action: CHAR_ACTION = CHAR_ACTION.IDLE
var direction: CHAR_DIRECTION = CHAR_DIRECTION.DOWN

var time_since_last_send: float = 0.0
var send_delay: float = 0.05


func _ready() -> void:
	_camera.enabled = is_local_player
	_name.text = player_name
	_raycast.target_position = Vector2.DOWN * _raycast_size
	_name.hide()


func _physics_process(delta: float) -> void:
	if is_local_player:
		_move(delta)
		_update_animation(direction)


func _move(delta: float) -> void:
	var direction_vector: Vector2 = _get_input_direction()

	if direction_vector.length() > 0:
		self.velocity = direction_vector.normalized() * _move_speed
		_is_moving = true
		action = CHAR_ACTION.WALKING

		if direction_vector.x < 0:
			direction = CHAR_DIRECTION.LEFT
			_raycast.target_position = Vector2.LEFT * _raycast_size
		elif direction_vector.x > 0:
			direction = CHAR_DIRECTION.RIGHT
			_raycast.target_position = Vector2.RIGHT * _raycast_size
		elif direction_vector.y < 0:
			direction = CHAR_DIRECTION.UP
			_raycast.target_position = Vector2.UP * _raycast_size
		elif direction_vector.y > 0:
			direction = CHAR_DIRECTION.DOWN
			_raycast.target_position = Vector2.DOWN * _raycast_size

		_raycast.force_raycast_update()

		time_since_last_send += delta
		if time_since_last_send >= send_delay:
			send_movement()
			time_since_last_send = 0.0
	else:
		if !_is_moving:
			send_movement()

		self.velocity = Vector2.ZERO
		_is_moving = false
		action = CHAR_ACTION.IDLE

	self.move_and_slide()


func _get_input_direction() -> Vector2:
	var direction_vector: Vector2 = Vector2(
			Input.get_axis("walking_left", "walking_right"),
			Input.get_axis("walking_up", "walking_down")
	)

	return direction_vector


func set_texture(current_sprite: String) -> void:
	var sprites_location: String = 'res://assets/graphics/entities/characters/'
	var texture: Texture2D = load(sprites_location + current_sprite + '.png')

	if texture:
		_texture.texture = texture


func send_movement():
	MoveCharacter.new(
		action,
		round(position.x),
		round(position.y),
		direction,
		velocity.x,
		velocity.y
	).send()


func update_remote_position(s_action: int, s_position_x: int, s_position_y: int, s_direction: int, _s_velocity_x: int, _s_velocity_y: int):
	if not is_local_player:
		var server_action = int_to_action(s_action)
		var server_direction = int_to_direction(s_direction)

		if server_action == CHAR_ACTION.WALKING:
			_is_moving = true
		else:
			_is_moving = false

		var tween = create_tween()
		var new_position: Vector2 = Vector2(s_position_x, s_position_y)
		tween.tween_property(self, "position", new_position, 0.1)
		_update_animation(server_direction)


func _update_animation(character_direction: CHAR_DIRECTION) -> void:
	if _is_moving:
		_play_idle_animation(character_direction)
	else:
		_play_walking_animation(character_direction)


func _play_idle_animation(character_direction: CHAR_DIRECTION):
	if character_direction == CHAR_DIRECTION.LEFT:
		_animation.play("walking_left")
	elif character_direction == CHAR_DIRECTION.UP:
		_animation.play("walking_up")
	elif character_direction == CHAR_DIRECTION.RIGHT:
		_animation.play("walking_right")
	elif character_direction == CHAR_DIRECTION.DOWN:
		_animation.play("walking_down")


func _play_walking_animation(character_direction: CHAR_DIRECTION):
	if character_direction == CHAR_DIRECTION.LEFT:
		_animation.play("idle_left")
	elif character_direction == CHAR_DIRECTION.UP:
		_animation.play("idle_up")
	elif character_direction == CHAR_DIRECTION.RIGHT:
		_animation.play("idle_right")
	elif character_direction == CHAR_DIRECTION.DOWN:
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


func _on_target_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		print("Clique detectado no BaseCharacter.")


func play_emote(current_emote: int) -> void:
	match current_emote:
		Emotes.ANGRY:
			_emote_animation.play('angry')
		Emotes.ATTENTION:
			_emote_animation.play('attention')
		Emotes.CONFUSED:
			_emote_animation.play('confused')
		Emotes.IDEA:
			_emote_animation.play('idea')
		Emotes.LOVE:
			_emote_animation.play('love')
		Emotes.MUSIC:
			_emote_animation.play('music')
		Emotes.QUESTION:
			_emote_animation.play('question')
		Emotes.SHAME:
			_emote_animation.play('shame')
		Emotes.SLEEPING:
			_emote_animation.play('sleeping')
		Emotes.TALKING:
			_emote_animation.play('talking')
		_:
			_emote_animation.stop()


func _on_emote_animation_animation_started(anim_name: StringName) -> void:
	_emote_sprite.show()


func _on_emote_animation_animation_finished(anim_name: StringName) -> void:
	_emote_sprite.hide()
