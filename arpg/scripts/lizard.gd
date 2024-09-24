extends CharacterBody2D

@export var speed: float = 30.0
@export var detection_radius: float = 50.0  # Adjust this value as needed
@export var idle_distance: float = 100.0  # Adjustable distance for idle movement
@export var start_idle_direction: String = "Right"  # Dropdown for idle direction
@onready var player: Node2D = get_tree().get_root().get_node("World/Player")
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var collisionShape: CollisionShape2D = $CollisionShape2D

var isDead: bool = false
var idle_direction: int = 1  # 1 for right, -1 for left
var idle_start_position: Vector2
var idle_target_position: Vector2

enum State {
	IDLE,
	SURROUND,
}

var state: State = State.IDLE

func _ready() -> void:
	collisionShape.disabled = false
	idle_direction = 1 if start_idle_direction == "Right" else -1  # Set initial idle direction based on inspector
	idle_start_position = global_position
	idle_target_position = idle_start_position + Vector2(idle_distance * idle_direction, 0)

func _physics_process(delta: float) -> void:
	if isDead:
		return
	
	var distance_to_player = global_position.distance_to(player.global_position)

	match state:
		State.IDLE:
			if distance_to_player < detection_radius:
				state = State.SURROUND
			else:
				idle_movement(delta)

		State.SURROUND:
			if distance_to_player >= detection_radius:
				state = State.IDLE  # Return to IDLE if player is out of range
				reset_idle_position()  # Reset idle target position when returning to IDLE
			else:
				move_to_target(player.global_position, delta)

	update_animation()

func idle_movement(delta: float) -> void:
	# Update the x position only to ensure left-right movement
	if abs(global_position.x - idle_target_position.x) < 1.0:  # Check if close enough to target
		idle_direction *= -1  # Switch direction
		idle_target_position = idle_start_position + Vector2(idle_distance * idle_direction, 0)  # Update target position

	# Move horizontally without affecting the y position
	velocity.x = speed * idle_direction
	velocity.y = 0  # Ensure no vertical movement
	move_and_slide()

func reset_idle_position() -> void:
	# Reset the target position to the current position when returning to IDLE
	idle_start_position = global_position
	idle_target_position = idle_start_position + Vector2(idle_distance * idle_direction, 0)

func move_to_target(target: Vector2, delta: float) -> void:
	var direction = (target - global_position).normalized()
	velocity = direction * speed
	move_and_slide()

func update_animation() -> void:
	if velocity.length() == 0:
		if animations.is_playing():
			animations.stop()
	else:
		var direction = ""
		if abs(velocity.x) > abs(velocity.y):  # Prioritize horizontal movement
			direction = "Right" if velocity.x > 0 else "Left"
		else:  # Vertical movement
			direction = "Up" if velocity.y < 0 else "Down"
		
		animations.play("walk" + direction)

func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		print("Player hit by raccoon!")  # Optional debug print

	if area == $hitBox: return 
	$hitBox.set_deferred("monitorable", false) 
	isDead = true
	animations.play("death")
	await animations.animation_finished
	queue_free()
