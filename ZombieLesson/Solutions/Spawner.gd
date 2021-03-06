extends Node2D

var spawn_points : PoolVector2Array
var player

export var spawn_time: float = 1
export (PackedScene) var zombie := preload("res://Scn/Actors/AIChaser.tscn")

func _ready() -> void:
	# get screen size
	var screen_size := get_viewport_rect().size * 1.5

	# Spawn at midpoints of screen
	spawn_points = [
		Vector2(screen_size.x / 2, 0),
		Vector2(screen_size.x / 2, screen_size.y),
		Vector2(0, screen_size.y / 2),
		Vector2(screen_size.x, screen_size.y / 2)
	]
	player = get_node("../Player")
	spawn_zomb()
	
	# Set spawn time
	$SpawnTimer.wait_time = spawn_time
	$SpawnTimer.start()

# Spawn in a zombie!
func spawn_zomb() -> void:
	var zomb = zombie.instance()
	add_child(zomb) # add child underneath "EnemySpawner"
	zomb.position = spawn_points[randi() % 4] + player.global_position - spawn_points[0] - spawn_points[2]
	zomb.target = player # so that our zombie knows who to follow

# When our timer runs out, we want it to spawn a zombie (eg: every 5 seconds)
func _on_Timer_timeout() -> void:
	spawn_zomb()
