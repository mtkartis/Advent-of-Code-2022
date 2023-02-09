extends Node

const INPUT = "res://input.txt"

#-------------------------------------FUNCS-------------------------------------
func _ready():
	print(tally_overlap(delineate_input(load_input(INPUT))))

func load_input(input:String)->String:
	var file = File.new()
	file.open(input, File.READ)
	var sInput = file.get_as_text()
	return sInput

func delineate_input(input:String)->Array:
	var d1Input = input.rsplit("\n")
	var d2Input = []
	for x in d1Input:
		d2Input.append(x.rsplit(","))
	return d2Input

func compare_pair(pair:Array)->bool:
	#pair = [first,second]
	var first = pair[0].rsplit("-")
	var second = pair[1].rsplit("-")
#	print(first)
#	print(second)
	#first bigger than second
	#PAIR 8 IS NOT CORRECT, says that the first is bigger than second
#	print(first[0])
#	print(second[0])
#	print(first[1])
#	print(second[1])
	if int(first[0]) <= int(second[0]) and int(first[1]) >= int(second[1]):
#			print("First bigger than second")
			return true
	#second bigger than first
	if int(first[0]) >= int(second[0]) and int(first[1]) <= int(second[1]):
#			print("Second bigger than first")
			return true
	if int(first[1]) >= int(second[0]) and int(first[1]) <= int(second[1]):
			return true
	if int(first[0]) <= int(second[1]) and int(first[1]) >= int(second[0]):
			return true
	return false

func tally_overlap(input:Array)->int:
	var overlaps:int = 0
	for pair in input:
#		print(pair)
		if compare_pair(pair):
#			print(true)
			overlaps += 1
			continue
#		print(false)
	return overlaps
