extends Label

var busy: bool = false

@onready var player: Player = $".."

func say(text_to_say: String) -> void:
	if busy:
		return
	busy = true
	player.speaking = true
	visible_characters = 0
	var lines: PackedStringArray = text_to_say.split("\n")
	for line in lines:
		visible_characters = 0
		text = line
		for _i in line.length():
			visible_characters += 1
			Sounds.play_sound("speak", -30.0)
			await get_tree().create_timer(0.08).timeout
		await get_tree().create_timer(0.05).timeout
		
	await get_tree().create_timer(0.5).timeout
	visible_characters = 0
	busy = false
	player.speaking = false
	
