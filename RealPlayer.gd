extends KinematicBody2D

const acceleration = 25 
const max_speed = 100
const friction = 25

enum{
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var velocity = Vector2.ZERO

onready var animationplayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationstate = animationtree.get("parameters/playback")

func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state()

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationtree.set("parameters/Idle/blend_position",input_vector)
		animationtree.set("parameters/Run/blend_position",input_vector)
		animationtree.set("parameters/Attacking/blend_position",input_vector)
		animationstate.travel("Run")
		velocity += input_vector * acceleration * delta
		velocity = velocity.clamped(max_speed * delta)
	else:
		animationstate.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO,friction * delta)
	
	if Input.is_action_just_pressed("ui_attack"):
		state = ATTACK
 #warning-ignore:return_value_discarded
	move_and_collide(velocity)

func attack_state():
	animationstate.travel("Attacking")
	
func attack_animation_finish():
	state = MOVE


# warning-ignore:unused_argument
func _on_SwordHit_area_entered(area):
	pass
