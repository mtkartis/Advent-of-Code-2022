extends Node

const input = "res://input.txt"


#A = rock, B = paper, C = scissors || X = Rock, Y = Paper, Z = scissors;
var outcomes:Dictionary = {
	"A X": (3+0),
	"A Y": (1+3),
	"A Z": (2+6),
	"B X": (1+0),
	"B Y": (2+3),
	"B Z": (3+6),
	"C X": (2+0),
	"C Y": (3+3),
	"C Z": (1+6),
	}


onready var grid = $ScrollContainer/GridContainer

#----------------------------------FUNC-----------------------------------------
func _ready():
	var processedInput = deliminate_input(load_input(input))
#	print(processedInput)
	display_input(processedInput)
	print(tally_results(processedInput))


func is_input_valid(input:String)->bool:
	var file = File.new()
	return file.file_exists(input)

func load_input(input:String)->String:
	var file = File.new()
	file.open(input, File.READ)
	return file.get_as_text()

func deliminate_input(input:String)->Array:
	var splitInput = input.rsplit("\n")
	for index in splitInput:
		if typeof(index) != TYPE_STRING:
			splitInput.remove(splitInput.find(index))
	return splitInput

func tally_results(input:Array)->int:
	var total:int = 0
	for index in input:
		if index is String:
			total += outcomes.get(index)
	return total

func display_input(input:Array)->void:
	for index in input:
		var trial = Button.new()
		grid.add_child(trial)
		trial.set_text(index)
