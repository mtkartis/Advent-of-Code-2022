extends Node

const INPUT_PATH = "res://input.txt"


onready var displayText = $Label

#-------------------------------FUNC--------------------------------------------
func _ready():
	print(input_valid())
	displayText.set_text(get_input(INPUT_PATH))
#	print(delineate_input())
#	print(find_highest_elf_calories(summate_elves(delineate_input())))
	var separateElves = summate_elves(delineate_input())
#	var sortedElves = sort_top_three_elves(separateElves)
	print(find_total_top_three_calories(separateElves))





func sort_top_three_elves(input:Array)->Array:
	input.sort_custom(self,"descending_int_Sort")
	return input

func descending_int_sort(a, b)->bool:
	return a > b

func find_total_top_three_calories(input:Array)->int:
	var totalCalories:int = 0
	for x in 3:
		var topCal = input.max()
		var topIndex = input.find(topCal)
		totalCalories += input.pop_at(topIndex)
	return totalCalories

func find_highest_elf_calories(input:Array)->int:
	var highestCalories:int = 0
	for elf in input:
		if elf > highestCalories:
			highestCalories = elf
	return highestCalories

func summate_elves(delimitedInput:Array)->Array:
	var elfSums:Array = []
	var ElfBin:int = 0
	for calories in delimitedInput:
		if calories == "":
			elfSums.append(ElfBin)
			ElfBin = 0
			continue
		ElfBin += int(calories)
	return elfSums

func delineate_input()->Array:
	var inputString:String = get_input(INPUT_PATH)
	var result:Array = inputString.rsplit("\n")
	return result

func get_input(input)->String:
	var file = File.new()
	file.open(input, File.READ)
	return file.get_as_text()

func input_valid()-> bool:
	var file = File.new()
	if file.file_exists(INPUT_PATH):
		return true
	return false
