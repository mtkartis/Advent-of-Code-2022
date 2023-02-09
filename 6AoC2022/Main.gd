extends Node

const input:String = "res://input.txt"




#-----------------------------------FUNCS---------------------------------------
func _ready():
	var processedInput = load_input(input)
	print(find_codon_index(processedInput))

func load_input(input:String)->String:
	var file = File.new()
	file.open(input, File.READ)
	var sFile = file.get_as_text()
	return sFile

func find_codon_index(input:String)->int:
	var codon:Array = []
	var processedIndex:int = 0
	for letter in input:
		processedIndex += 1
		codon.append(letter)
		if codon.size() > 14:
			codon.remove(0)
			if is_codon_unique(codon):
				return processedIndex
	return -1
		

func is_codon_unique(codon:Array)->bool:
	for x in codon.size():
		for y in codon.size():
			if x == y: continue
			if codon[x] == codon [y]:
				return false
	return true
