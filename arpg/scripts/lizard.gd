extends CharacterBody2D

@export var detection_radius: float = 50.0  # Adjustable detection radius
@export var start_health: int = 10  # Adjustable health for the boss
@export var charge_duration: float = 1.0  # Adjustable charge duration

@onready var player: Node2D = get_tree().get_root().get_node("World/Player")
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var collisionShape: CollisionShape2D = $CollisionShape2D
@onready var charge_timer: Timer = $ChargeTimer  # Assuming a Timer node for handling charge duration

var isDead: bool = false
var health: int = start_health
var isCharging: bool = false

enum State {
	IDLE,
	CHARGE,
	ATTACK,
	DEAD
}

var state: State = State.IDLE

func _ready() -> void:
	collisionShape.disabled = false
	health = start_health  # Initialize health
	charge_timer.wait_time = charge_duration  # Set the charge duration

	# Connect the timer's timeout signal to handle the end of charging
	charge_timer.timeout.connect(_on_charge_timer_timeout)

func _physics_process(delta: float) -> void:
	if isDead:
		return
	
	var distance_to_player = global_position.distance_to(player.global_position)

	match state:
		State.IDLE:
			if distance_to_player < detection_radius:
				state = State.CHARGE
			idle_behavior()

		State.CHARGE:
			if not isCharging:
				start_charge()

		State.ATTACK:
			attack_behavior()

		State.DEAD:
			return  # Do nothing if dead

	update_animation()

func idle_behavior() -> void:
	animations.play("idle")  # Play idle animation, if you have one

func start_charge() -> void:
	isCharging = true
	animations.play("charge")  # Play charge animation
	charge_timer.start()  # Start the charge timer

func attack_behavior() -> void:
	animations.play("attack")  # Play attack animation
	# Additional attack logic can be added here if necessary

func update_animation() -> void:
	if state == State.DEAD:
		return
	if velocity.length() == 0 and animations.is_playing():
		animations.stop()

# Handle collision with player's weapon
func _on_hurt_box_area_entered(area: Area2D) -> void:
	if area.is_in_group("weapon"):  # Check if the area is part of the player's weapon
		health -= area.damage
		if health <= 0 and not isDead:
			die()

func die() -> void:
	isDead = true
	state = State.DEAD
	animations.play("death")
	collisionShape.disabled = true
	await animations.animation_finished
	queue_free()  # Remove the boss from the scene after death

# Handle end of charge state
func _on_charge_timer_timeout() -> void:
	isCharging = false
	state = State.ATTACK  # Transition to attack state after charging
	# You can add logic here to ensure the attack only happens after charge is complete
