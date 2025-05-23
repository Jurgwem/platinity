extends Node2D

var tileResource : Resource = load("res://INST/tile.tscn");
var step : int = 32;
var points : int = 0;
var genCount : int = 0;
var spawnOffset : int = 32;

func _ready() -> void:
	#for x in 100:
		#for y in 80:
			#var tile : Node2D = tileResource.instantiate();
			#tile.position = Vector2(100 + step * x, -step * y);
			#add_child(tile);
	pass
	
func _physics_process(_delta: float) -> void:
	points = $"../player".position.x / 32;
	
	if globals.best < points:
		globals.best = points;
	
	$"../camera/UI/tries".text = str("TRIES: ", globals.deaths);
	$"../camera/UI/best".text = str("BEST: ", globals.best);
	$"../camera/UI/curr".text = str("PTS: ", points);
	
	if genCount < (points + spawnOffset):
		for n in range(genCount, (points + spawnOffset)):
			for y in 100:
				var tile : Node2D = tileResource.instantiate();
				tile.position = Vector2(96 + step * n, -step * y);
				add_child(tile);
		genCount = points + spawnOffset;
	pass
