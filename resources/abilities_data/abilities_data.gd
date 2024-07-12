extends Resource
class_name AbilitiesData

@export var name: String
@export var scene: PackedScene
@export var description: String
@export var type: String
@export var tags: Array[String]

var level: int = 0
var max_level: int = 5