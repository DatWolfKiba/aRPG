extends CharacterBody2D

class_name enemy

@export var speed: float = 30.0
@export var detection_radius: float = 50.0  # Adjust this value as needed for testing
@onready var attack_timer: Timer = $AttackTimer
@onready var player: Node2D = get_tree().get_root().get_node("World/Player")

var random_num: float

enum State {
	SURROUND,
	ATTACK,
	HIT,
}

var state: State = State.SURROUND

func _ready() -> void:
	print("Enemy script is ready")  # Debug print
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	random_num = rng.randf()
	attack_timer.timeout.connect(_on_AttackTimer_timeout)
	print("Player node: ", player)  # Debug print

func _physics_process(delta: float) -> void:
	print("Physics process running")  # Check if this runs
	var distance_to_player = global_position.distance_to(player.global_position)
	print("Distance to player: ", distance_to_player)  # Debug print

	match state:
		State.SURROUND:
			print("In SURROUND state. Distance: ", distance_to_player)  # Debug print
			if distance_to_player < detection_radius:
				state = State.ATTACK  # Switch to ATTACK state if within range
			else:
				move_to_target(get_circle_position(random_num), delta)
		State.ATTACK:
			print("Entering ATTACK state")  # Debug print
			move_to_target(player.global_position, delta)
		State.HIT:
			move_to_target(player.global_position, delta)
			print("HIT")  # Trigger the slash animation here

func move_to_target(target: Vector2, delta: float) -> void:
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * speed
	velocity = desired_velocity
	move_and_slide()  # No arguments here

func get_circle_position(random: float) -> Vector2:
	var kill_circle_center = player.global_position
	var radius: float = 40.0
	var angle: float = random * PI * 2.0
	var x: float = kill_circle_center.x + cos(angle) * radius
	var y: float = kill_circle_center.y + sin(angle) * radius

	return Vector2(x, y)

func _on_AttackTimer_timeout() -> void:
	state = State.ATTACK
