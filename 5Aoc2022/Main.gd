extends Node

const INITIAL:String = "res://initialCrates.txt"
const MOVEMENTS:String = "res://movements.txt"

#--------------------------------------FUNCS------------------------------------
func _ready():
	var initial = load_input(INITIAL)
	var movements = load_input(MOVEMENTS)
	var dInitial = delimit_initial(initial)
	var final = execute_movements(movements, dInitial)
	print(final)
	print(get_top_crates(final))

func load_input(input:String)->String:
	var file = File.new()
	file.open(input, File.READ)
	var lFile = file.get_as_text()
	return lFile

func delimit_initial(input:String)->Array:
	var dArray = []
	var sInput = input.rsplit("\n")
	for stack in sInput:
		var rStack = []
		for crate in stack:
			rStack.append(crate)
		dArray.append(rStack)
	return dArray

func execute_movements(moves:String, initCrates:Array)->Array:
	var sMoves:Array = moves.rsplit("\n")
	var moveTimes:int = 0
	var firstStackIndex:int = 0
	var secondStackIndex:int = 0
	for step in sMoves:
		var words:Array = step.rsplit(" ")
		for x in words.size():
			if x == 1:
				moveTimes = int(words[x])
			if x == 3:
				firstStackIndex = int(words[x]) - 1
			if x == 5:
				secondStackIndex = int(words[x]) - 1
		var crates:Array = initCrates[firstStackIndex].slice(-moveTimes, -1, 1, true)
		initCrates[firstStackIndex].resize(initCrates[firstStackIndex].size() - moveTimes)
		initCrates[secondStackIndex].append_array(crates)
		
#		for times in moveTimes:
#			var crate:String = initCrates[firstStackIndex].pop_back()
#			initCrates[secondStackIndex].append(crate)
	return initCrates

func get_top_crates(input:Array)->String:
	var tops:String = ""
	for stack in input.size():
		tops += str(input[stack][-1])
	return tops
