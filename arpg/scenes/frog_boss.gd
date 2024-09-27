extends CharacterBody2D

@export var detection_radius: float = 100.0  # Adjustable detection radius for player
@export var charge_time: float = 1.0  # Adjustable time for the charge state
@export var health: int = 1  # Adjustable boss health
@onready var player: Node2D = get_tree().get_root().get_node("World/Player")
@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var attack_timer: Timer = $AttackTimer

var is_dead: bool = false
var state: State = State.IDLE

enum State {
	IDLE,
	CHARGE,
	ATTACK,
}

func _ready() -> void:
	attack_timer.one_shot = true
	attack_timer.wait_time = charge_time
	# Only connect the signal if it isn't already connected
	var callable_to_connect = Callable(self, "_on_animation_player_animation_finished")
	if not animations.is_connected("animation_finished", callable_to_connect):
		animations.connect("animation_finished", callable_to_connect)

func _physics_process(delta: float) -> void:
	if is_dead:
		return
	
	var distance_to_player = global_position.distance_to(player.global_position)

	match state:
		State.IDLE:
			if distance_to_player < detection_radius:
				enter_charge_state()

		State.CHARGE:
			if attack_timer.time_left == 0:
				enter_attack_state()

		State.ATTACK:
			if distance_to_player >= detection_radius:
				state = State.IDLE
				animations.play("idle")

	update_animation()

func enter_charge_state() -> void:
	state = State.CHARGE
	animations.play("charge")
	attack_timer.start()

func enter_attack_state() -> void:
	state = State.ATTACK
	animations.play("attack")

func update_animation() -> void:
	if is_dead:
		return
	if not animations.is_playing():
		animations.play("idle")

func _on_hurt_box_area_entered(area: Area2D) -> void:
	take_damage()

func take_damage() -> void:
	health -= 1
	if health <= 0:
		$hitBox.set_deferred("monitorable", false)  # Disable hitbox upon death
		die()

func die() -> void:
	is_dead = true
	animations.play("death")
	await animations.animation_finished  # Wait for the death animation to complete
	queue_free()  # Remove the boss from the scene

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "death":
		queue_free()
