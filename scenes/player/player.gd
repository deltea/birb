class_name Player extends CharacterBody2D

@export_category("Movement")
@export var max_speed = 150.0
@export var jump_velocity = 280.0
@export var gravity = 1000.0
@export var fall_gravity = 1500.0
@export var wall_fall_velocity = 80.0
@export var acceleration = 50.0
@export var deceleration = 30.0
@export var coyote_time = 0.15
@export var buffer_time = 0.15
@export var jump_cut_multiplier = 0.5
@export var push_force = 1000.0

@export_category("Animation")
@export var squash = 0.4
@export var stretch = 0.4

@onready var sprite: Sprite2D = $Sprite2D

var jumped = false
var coyote_timer = 0.0
var buffer_timer = buffer_time
var can_move = true
var target_scale = Vector2.ONE;
var target_rot = 0.0;

@onready var scale_dynamics: DynamicsSolverVector = Dynamics.create_dynamics_vector(2.0, 0.5, 2.0);
@onready var rot_dynamics: DynamicsSolver = Dynamics.create_dynamics(10.0, 0.5, 10.0);

func _enter_tree() -> void:
	RoomManager.current_room.player = self

func _process(_dt: float) -> void:
	sprite.scale = scale_dynamics.update(target_scale);
	sprite.rotation_degrees = rot_dynamics.update(target_rot)

func _physics_process(delta: float) -> void:
	coyote_timer += delta
	buffer_timer += delta

	var x_input := Input.get_axis("left", "right")

	if not is_on_floor():
		if velocity.y > 0:
			if is_on_wall() and x_input:
				velocity.y = wall_fall_velocity
			else:
				velocity.y += fall_gravity * delta
		else:
			velocity.y += gravity * delta

	if can_move:
		if x_input:
			velocity.x = move_toward(velocity.x, x_input * max_speed, acceleration)
			sprite.flip_h = x_input < 0
		else:
			velocity.x = move_toward(velocity.x, 0.0, deceleration)
	else:
		velocity.x = 0

	if can_move and x_input and is_on_floor():
		target_rot = sin(Clock.time * 20.0) * 15.0

	if (Input.is_action_just_pressed("jump") or buffer_timer < buffer_time) and not jumped and can_move:
		if is_on_floor() or coyote_timer < coyote_time:
			velocity.y = -jump_velocity
			scale_dynamics.set_value(Vector2.ONE + Vector2(-stretch, stretch))
			rot_dynamics.set_value(sprite.rotation_degrees)
			jumped = true

	if Input.is_action_just_released("jump") and velocity.y < 0.0:
		velocity.y *= jump_cut_multiplier

	if Input.is_action_just_pressed("jump") and not is_on_floor():
		buffer_timer = 0.0

	# if Input.is_action_just_pressed("down"):
	# 	position.y += 2

	var was_on_floor = is_on_floor()
	move_and_slide()

	if not was_on_floor and is_on_floor():
		scale_dynamics.set_value(Vector2.ONE + Vector2(squash, -squash))
		jumped = false
	elif was_on_floor and not is_on_floor() and not jumped:
		coyote_timer = 0.0

	if get_slide_collision_count() > 0:
		var collision = get_slide_collision(0)
		var collider = collision.get_collider()
		if collider is RigidBody2D and position.y > collider.position.y:
			(collider as RigidBody2D).apply_force(-collision.get_normal() * push_force)

func trampolined(force: float):
	velocity.y = -force
