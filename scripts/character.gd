extends KinematicBody

const MOUSE_SENSITIVITY = 0.2
const MOVEMENT_SPEED = 5

onready var camera = $Camera
onready var raycast = $Camera/RayCast

func walk(delta):
	var direction = Vector3()
	if Input.is_action_pressed("walk_north"):
		direction -= camera.global_transform.basis.z
	if Input.is_action_pressed("walk_south"):
		direction += camera.global_transform.basis.z
	if Input.is_action_pressed("walk_east"):
		direction += camera.global_transform.basis.x
	if Input.is_action_pressed("walk_west"):
		direction -= camera.global_transform.basis.x
	direction.y = 0
	direction = direction.normalized()	
	move_and_slide(direction * MOVEMENT_SPEED)

func pan(mouse_axis):
	var horizontal = -mouse_axis.x * MOUSE_SENSITIVITY
	var vertical = -mouse_axis.y * MOUSE_SENSITIVITY
	rotate_y(deg2rad(horizontal))
	camera.rotate_x(deg2rad(vertical))
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)

func interact(entity):
	if is_looking_at(entity):
		entity.get_node("MeshInstance/AnimationPlayer").play("default")
			
func is_looking_at(entity):
	raycast.force_raycast_update()
	if raycast.is_colliding():
		if raycast.get_collider() == entity:
			return true
	return false
