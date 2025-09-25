extends Window

signal change_wallpaper(path)
signal bird_up

#Different Texts this window is supposed to pint onto the reader window, some of these texts have been generated using Chat GPT
#region Text Dict
var texts: Dictionary = {"Transcript": "Team Check-In Meeting Transcript

Date: Monday, September 15, 2025
Time: 10:00 AM – 10:45 AM
Attendees: Sarah (Manager), John (Marketing), Priya (Product), Daniel (Engineering), Lisa (Design), Mike (Sales)

Sarah (Manager):
Alright, let’s get started. Thanks, everyone, for joining. Today we’ll do a quick round of updates, go over blockers, and then talk about the upcoming product launch timeline. Let’s start with Marketing. John?

John (Marketing):
Thanks, Sarah. We wrapped up the Q4 campaign planning last Friday. The creative is in review with Legal. We're also running A/B tests on the new landing pages — early results show a 12% lift in conversions, which is promising.

Sarah:
Great. Any blockers?

John:
Just waiting on final approval from Legal, which we should get by Thursday.

Sarah:
Good. Let’s move to Product. Priya?

Priya (Product):
Sure. The roadmap is updated to reflect the latest feature requests from the last stakeholder meeting. We're finalizing specs for the mobile push notifications feature. I’ll need some input from Engineering on feasibility by Wednesday.

Sarah:
Daniel, can your team take a look?

Daniel (Engineering):
Yep, we’re already reviewing it. We’ll send feedback by EOD tomorrow. We’re also 80% through backend integration for the analytics dashboard. Should be ready for internal testing early next week.

Priya:
Perfect, thanks.

Sarah:
Lisa, anything from Design?

Lisa (Design):
Yes. We’ve completed the mockups for the onboarding flow and shared them in Figma. I’ll schedule a design review tomorrow afternoon. We’re also starting work on the revamped settings UI this week.

Sarah:
Thanks, Lisa. Sales update, Mike?

Mike (Sales):
Quick one — we hit 92% of our target last month. We’re seeing strong interest in the enterprise tier. I’ll be meeting with the Product team later to discuss client feedback on custom reporting features.

Priya:
Yes, I’ve got that on the calendar for Thursday.

Sarah:
Awesome. Last item: the product launch. I want us to aim for October 10th, but only if testing stays on track. Daniel, is that realistic?

Daniel:
Assuming QA goes smoothly next week, yes. I’ll flag it if there’s any risk.

Sarah:
Good. Let’s tentatively lock that in. Action items will go out after this. Any other issues?

[Everyone shakes heads or says “Nope”]

Sarah:
Alright, thanks everyone. Have a good week!

Meeting ends: 10:42 AM",
"Meeting Plan": "Meeting Plan: Weekly Team Check-In

Date: Monday, September 15, 2025
Time: 10:00 AM – 10:45 AM
Location: Zoom / Conference Room A
Meeting Lead: Sarah (Team Manager)
Attendees: Sarah, John, Priya, Daniel, Lisa, Mike

Meeting Objectives:

Share key updates from each department

Identify any blockers or resource needs

Align on timelines for the upcoming product launch

Clarify action items and responsibilities

Agenda:
Time	Topic	Owner
10:00 – 10:05	Welcome & Objectives Overview	Sarah
10:05 – 10:15	Marketing Update (Campaign progress, KPIs, approvals)	John
10:15 – 10:20	Product Update (Roadmap changes, feature status)	Priya
10:20 – 10:25	Engineering Update (Dev progress, testing timelines)	Daniel
10:25 – 10:30	Design Update (UI/UX progress, review schedule)	Lisa
10:30 – 10:35	Sales Update (Pipeline, client feedback)	Mike
10:35 – 10:40	Product Launch Planning (Date confirmation, dependencies)	Sarah
10:40 – 10:45	Q&A / Open Floor / Next Steps Review	All
Pre-Meeting Preparation:

All team leads should submit key updates in the shared doc by 9:00 AM

Review the product launch checklist

Bring any questions or concerns about inter-team dependencies

Expected Outcomes:

Clear understanding of current progress and roadblocks

Confirmed timeline for product launch

Updated list of action items and owners",
"Union Letter": "Subject: Request for Support / Inquiry Regarding Union Representation

Dear [Union Representative's Name or Union Representative],

I hope this letter finds you well. I am writing to formally reach out on behalf of myself and/or fellow employees at [Company Name/Department] regarding [brief explanation – e.g., a workplace concern, a question about union benefits, interest in unionizing, etc.].

We value the role the union plays in protecting workers’ rights and ensuring fair and equitable treatment in the workplace. Recently, we have experienced [brief description of the issue — e.g., changes in working conditions, concerns about management decisions, confusion about contract terms, etc.], and we would appreciate guidance on how best to proceed.

Specifically, we would like to request:

[Support with understanding our rights under the current collective agreement]

[Assistance in addressing a grievance or workplace issue]

[Information about the process for initiating union representation, if not currently represented]

[A meeting with a union representative to discuss next steps]

We are committed to fostering a respectful and transparent work environment and believe that working together with the union is essential in achieving that goal.

Please let us know the appropriate next steps and if a meeting can be scheduled at your earliest convenience. You can contact me at [Phone Number] or [Email Address].

Thank you for your time and support. We look forward to hearing from you soon.",
"DO NOT DELETE": "The Password is in another castle",
"Important Information": "Try to remeber the password!",
"Contract": "You will work and you will get a teeensy bit of the profit
Sign here
____________"}
#endregion
# Scenes to be spawned in code
var confetti = preload("res://Scenes/File_Window/confetti.tscn")
var reader = preload("res://Scenes/reader_window.tscn")
var secret_window = preload("res://Scenes/File_Window/secret_window.tscn")
var bird = preload("res://Scenes/File_Window/bird.tscn")
var number_picker = preload("res://Scenes/shitty_input/number_picker.tscn")
var picture_window = preload("res://Scenes/image_window.tscn")
var no_hobby = preload("res://Scenes/File_Window/no_hobbies.tscn")
var minesweeper = preload("res://Scenes/games/minesweeper.tscn")
var simon_says = preload("res://Scenes/games/simon.tscn")
var creation = preload("res://Scenes/File_Window/creation_window.tscn")
# Different variables which are necessary in the code
var tries = 0
var state = "none"
var passwords = ["password", "mince", "secret", "guess", "castle", "drowssap", "please", "algebra", "sondern", "fähigkeit"]
var password = ""
var birds = 0
#Children which are referenced more often
@onready var folders = $VBoxContainer/HSplitContainer/folders
@onready var work = $work_files
@onready var hobby = $hobby_files
@onready var timer: Timer = $Timer
@onready var bird_button: Button = $hobby_files/bird_watching/Button
@onready var patheditor: LineEdit = $VBoxContainer/Control/return/filepath/HBoxContainer/patheditor
@onready var birdwatching_files: Control = $birdwatching_files


func _ready():
	hide()
	position = Vector2i(-2000,0)
	patheditor.text = "Home >"

func _on_close_requested() -> void:
	position = Vector2i (-1000,0)
	hide()
# Switches displayed files to those in the hobby node
func _on_hobbies_pressed() -> void:
	if state != "hobby":
		work.reparent(self)
		work.position = Vector2(-250,-250)
		hobby.reparent(folders)
		state = "hobby"
		birdwatching_files.reparent(self)
		birdwatching_files.position = Vector2(-250,-250)
		patheditor.text = "Home > Hobby"
	else:
		pass
# Switches displayed files to those in the work node
func _on_work_pressed() -> void:
	if state != "work":
		hobby.reparent(self)
		hobby.position = Vector2(-250,-250)
		work.reparent(folders)
		birdwatching_files.reparent(self)
		birdwatching_files.position = Vector2(-250,-250)
		state = "work"
		patheditor.text = "Home > Work"
	else:
		pass
# When important document file is clicked, spawns a flying pdf file onto the desktop
func _on_file_button_pressed() -> void:
	var obj = confetti.instantiate()
	obj.position = position + Vector2i(size.x / 2.0, 50)
	obj.display.connect(_on_confetti_display)
	add_sibling(obj)
#When one of those flying pdf files is clicked, displays the text associated with it in the reader window
func _on_confetti_display(type: String, point: Vector2):
	var obj = reader.instantiate()
	var text = ""
	tries += 1
	match type:
		"Transcipt":
			text = texts["Transcript"]
		"Meeting Plan":
			text = texts["Meeting Plan"]
		"Important Information":
			text = texts["Important Information"]
		"DO NOT DELETE":
			text = texts["DO NOT DELETE"]
		"Union Letter":
			text = texts["Union Letter"]
		"Contract":
			text = texts["Contract"]
	password = "-- " + passwords[tries % 10] + " --"
	text = text.insert(randi_range(0, text.length()-1), password)
	obj.write(text, point)
	add_sibling(obj)
#Opens another window in which a password can be entered.
#This password changes with every time a password is attempted to be entered and with everytime someone tries to find the password in the important documents pdfs, into which the password is inserted at a random position
func _on_secret_pressed() -> void:
	var obj = secret_window.instantiate()
	obj.closed.connect(_on_secret_closed)
	obj.password = passwords[tries % 10]
	obj.tries = tries
	add_child(obj)
#To keep track of the amount of tries a person has spent trying to find the password
func _on_secret_closed(x):
	tries += x
#Moves the window ever so slightly if the "go back" or "go forward" button are pushed
func _on_back_button_down() -> void:
	position.x -= 10

func _on_forward_button_down() -> void:
	position.x += 10
#When the birdwatching file is pressed spawns birds on each side of the desktop, which fly back and forth
func _on_bird_button_pressed() -> void:
	bird_up.emit()
	for x in randi_range(5,20):
		var obj = bird.instantiate()
		add_sibling(obj)
		if obj.direction < 0:
			obj.global_position = Vector2(randi_range(1700, 2200), randi_range(20,700))
		else:
			obj.global_position = Vector2(randi_range(-100, -600), randi_range(20,700))
		birds += 1
	$sound.play()
	timer.wait_time = 15.0
	bird_button.disabled = true
	timer.start()

func _on_timer_timeout() -> void:
	timer.stop()
	bird_button.disabled = false
	var obj = number_picker.instantiate()
	obj.title = "Bird Count"
	obj.text = "How many Birds did you see?"
	obj.correct_number = birds
	obj.number_range = [5,20]
	obj.select.connect(_on_number_selected)
	add_sibling(obj)

func _on_number_selected(x):
	if birds != x:
		$sound.stream = load("res://assets/sounds/wrong.mp3")
		$sound.play()
	else:
		$sound.stream = load("res://assets/sounds/epic_eagle_scream_xxx.mp3")
		$sound.play()
		change_wallpaper.emit("res://assets/visuals/bird_wallpaper.jpg")
		hobby.reparent(self)
		hobby.position = Vector2(-250,-250)
		work.reparent(self)
		work.position = Vector2(-250,-250)
		birdwatching_files.reparent(folders)
		state = "bird"
		patheditor.text = "Home > Hobby > Bird Watching"

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text == "relinquo":
		get_tree().quit()

func _on_bird_pic_button_pressed() -> void:
	var obj = picture_window.instantiate()
	obj.title = "Epic Eagle"
	obj.image = "res://assets/visuals/bird_wallpaper.jpg"
	obj.global_position = Vector2i(500,400)
	add_sibling(obj)

func _on_cut_pressed() -> void:
	change_wallpaper.emit("res://assets/visuals/wallpaper_cut.jpg")
	$VBoxContainer/Control/PanelContainer/interact/cut.disabled = true
	$sound.stream = load("res://assets/sounds/scissors.mp3")
	$sound.play()
	$VBoxContainer/Control/PanelContainer/interact/paste.disabled = false

func _on_paste_pressed() -> void:
	$VBoxContainer/Control/PanelContainer/interact/paste.disabled = true
	$VBoxContainer/Control/PanelContainer/interact/cut.disabled = false
	change_wallpaper.emit("res://assets/visuals/wallpaper_putz.jpg")
	$sound.stream = load("res://assets/sounds/putz.wav")
	$sound.play()

func _on_detection_pressed() -> void:
	if not Gamemaster.click_icon.has("Important Documents"):
		Gamemaster.click_icon["Important Documents"] = 0
	if not Gamemaster.click_icon.has("Reports"):
		Gamemaster.click_icon["Reports"] = 0
	if Gamemaster.click_icon["Important Documents"] + Gamemaster.click_icon["Reports"] < 50:
		var obj = no_hobby.instantiate()
		add_sibling(obj)
	else:
		var obj = minesweeper.instantiate()
		add_sibling(obj)

func _on_drawing_pressed() -> void:
	if not Gamemaster.click_icon.has("Important Documents"):
		Gamemaster.click_icon["Important Documents"] = 0
	if not Gamemaster.click_icon.has("Reports"):
		Gamemaster.click_icon["Reports"] = 0
	if Gamemaster.click_icon["Important Documents"] + Gamemaster.click_icon["Reports"] < 50:
		var obj = no_hobby.instantiate()
		add_sibling(obj)
	else:
		var obj = simon_says.instantiate()
		add_sibling(obj)

func _on_focus_entered() -> void:
	if "minesweeper" and "simon" in Gamemaster.flags:
		$VBoxContainer/HSplitContainer/folders/hobby_files/tutorial.show()

func _on_tutorial_pressed() -> void:
	var obj = reader.instantiate()
	obj.write("3: uo \n Search for it", get_mouse_position())
	add_sibling(obj)

func _on_new_pressed() -> void:
	var obj = creation.instantiate()
	add_sibling(obj)

func _on_copy_pressed() -> void:
	var obj = picture_window.instantiate()
	obj.title = "Copy"
	obj.image = "res://assets/visuals/folder.png"
	obj.global_position = Vector2i(700,500)
	add_sibling(obj)
