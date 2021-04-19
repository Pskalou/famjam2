extends Node2D


const FRONTIERE= 55
const TOP_OFFSET= Vector2(32,32)
const RETURN_ACCEL= 20

			
var on_going_drag = -1


func _process(delta):
	if on_going_drag == -1:
		var pos_diff = (Vector2(0,0) - TOP_OFFSET) - position
		position += pos_diff * RETURN_ACCEL * delta


func get_pad_position():
	return position + TOP_OFFSET


func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed() ):		
		var event_dist_from_center = (event.position - get_parent().global_position).length()

		if event_dist_from_center <= FRONTIERE * global_scale.x or event.get_index() == on_going_drag:
			set_global_position(event.position - TOP_OFFSET * global_scale)
			
			if get_pad_position().length() > FRONTIERE:
				set_position( get_pad_position().normalized() * FRONTIERE - TOP_OFFSET)
			
			on_going_drag = event.get_index() 
	
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == on_going_drag:
		on_going_drag = -1


const SEUIL = 10
func get_value():
	if get_pad_position().length() > SEUIL:
		return get_pad_position().normalized()
	else:
		return Vector2(0,0)
