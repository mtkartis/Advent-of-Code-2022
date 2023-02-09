extends Node

const INPUT = "res://input.txt"


var a_score = {}

onready var container = $ScrollContainer/VBoxContainer


#--------------------------------FUNC-------------------------------------------
func _ready():
	create_a_score_dict()
	var processedInput = group_elves(serialize_input(load_input(INPUT)))
	display_input(processedInput)
#	var extractedCommon = []
#	for i in processedInput.size():
#		extractedCommon.append(find_common_compartment_type(processedInput[i]))
	var priorityArray = convert_to_priority(processedInput)
	print(total_priority(priorityArray))
#	print(extractedCommon)
#	print(a_score)

func create_a_score_dict()->void:
	var keys = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	for i in keys.length():
		a_score[keys[i]] = (i + 1)


func is_input_valid(input:String)->bool:
	var file = File.new()
	return file.file_exists(input)

func load_input(input:String)->String:
	var file = File.new()
	file.open(input, File.READ)
	var sInput = file.get_as_text()
	return sInput

func serialize_input(input:String)->Array:
	var serial = input.rsplit("\n")
	return serial

func display_input(input:Array)->void:
	for index in input:
		var sack = Button.new()
		container.add_child(sack)
		sack.set_text(str(index))

func split_all_sacks(input:Array)->Array:
	var splitInput = []
	for sack in input:
		splitInput.append(split_sack(sack))
	return splitInput

func split_sack(sack:String)->Array:
	var splitSack = []
	var sackLength = sack.length()
	splitSack.append(sack.substr(0, sackLength/2))
	splitSack.append(sack.substr(sackLength/2, sackLength - 1))
	return splitSack

func find_common_compartment_type(sack:Array)->String:
	#sack = [left, right]
	var common:String = ""
	for c in sack[0].length():
		if sack[0].find(sack[1][c]) != -1:
			common = sack[1][c]
			break
	return common

func group_elves(input:Array)->Array:
	var commonList:Array = []
	for i in 100:
		var group:Array = [input[3*i], input[(3*i)+1], input[(3*i)+2]]
		commonList.append(find_common_sticker_type(group))
#		if i == input.size()/3 - 1:
#			print(group)
	return commonList

func find_common_sticker_type(sacks:Array)->String:
	#sacks = [1,2,3]
#	print(sacks)
	#find smallest elf, find biggest elf, compare smallest in biggest, make array, then find in medium
	var possibleMatches:Array = []
	var lengths:Array = []
	for i in 3:
		lengths.append(sacks[i].length())
	var shortestIndex:int = lengths.find(lengths.min())
#	print(shortestIndex)
	var longestIndex:int = lengths.find(lengths.max())
#	print(longestIndex)
	var middleIndex:int =  -1 * (shortestIndex + longestIndex)
	for c in sacks[shortestIndex]:
		if sacks[longestIndex].find(c) != -1:
			possibleMatches.append(c)
#	print(possibleMatches)
	for c in possibleMatches:
		if sacks[middleIndex].find(c) != -1:
#			print(c)
			return c
	return "ERROR"

func convert_to_priority(common:Array)->Array:
	var priority_list = []
	for type in common:
		priority_list.append(a_score.get(type))
	return priority_list

func total_priority(priority:Array)->int:
	var total = 0
	for p in priority:
		total += p
	return total
