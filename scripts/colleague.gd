extends CharacterBody2D


const SPEED = 300.0

var last_direction: Vector2 = Vector2.RIGHT
var sight_offset: Vector2

@export var sight_offset_up: Vector2 = Vector2(3.75, -7.0)
@export var sight_offset_down: Vector2 = Vector2(-3.75, -7.0)

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sight: Area2D = $AnimatedSprite2D/sight


func _ready() -> void:
	# Initialise sight offset
	sight_offset = sight.position

func _physics_process(_delta: float) -> void:
	process_movement()
	process_animation()
	move_and_slide()
	update_sight_offset()
	
	
# ---------------------------------------------------------------------------------------
# MOVEMENT & ANIMATION
# ---------------------------------------------------------------------------------------

func process_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	pass
	
func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("move", last_direction)
	else:
		play_animation("idle", last_direction)

func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0:
		animated_sprite_2d.flip_h = dir.x < 0
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_top")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_bottom")


# ---------------------------------------------------------------------------------------
# SIGHT
# ---------------------------------------------------------------------------------------

func update_sight_offset() -> void:
	if last_direction.x > 0:
		# Facing Right
		sight.rotation_degrees = 0
		sight.scale = Vector2(1, 1)
		sight.position = Vector2(abs(sight_offset.x), sight_offset.y)
		
	elif last_direction.x < 0:
		# Facing Left
		sight.rotation_degrees = 0
		sight.scale = Vector2(-1, 1)
		sight.position = Vector2(-abs(sight_offset.x), sight_offset.y)
		
	elif last_direction.y < 0:
		# Facing Up
		sight.rotation_degrees = -90
		sight.scale = Vector2(1, 1)
		sight.position = sight_offset_up
		
	elif last_direction.y > 0:
		# Facing Down
		sight.rotation_degrees = 90
		sight.scale = Vector2(1, 1)
		sight.position = sight_offset_down

func _on_sight_area_entered(area: Area2D) -> void:
	if area.name == "Visible":
		print("Found")
