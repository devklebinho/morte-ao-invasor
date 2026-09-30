extends CharacterBody2D
# BODYTEST

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")

	if direction:
		velocity.x = direction * SPEED

		if direction > 0:
			anim.flip_h = true
		elif direction < 0:
			anim.flip_h = false

		anim.play("walk")

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")

	move_and_slide()
