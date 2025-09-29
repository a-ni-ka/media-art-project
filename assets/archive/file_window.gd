extends Window

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
var state = "none"
var confetti = preload("res://Scenes/File_Window/confetti.tscn")
var reader = preload("res://Scenes/reader_window.tscn")
var secret_window = preload("res://Scenes/File_Window/secret_window.tscn")
var tries = 0
var passwords = ["password", "mince", "secret", "guess", "castle", "drowssap", "please", "algebra", "sondern", "fähigkeit"]
var password = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_close_requested() -> void:
	self.position = Vector2i(-1000, 0)
	self.size = Vector2i(267,450)
	self.hide()

func _on_hobbies_pressed() -> void:
	if state != "hobby":
		$work_files.position = Vector2(269,-300)
		$hobby_files.position = Vector2 (269,3)
		state = "hobby"
	else:
		pass

func _on_work_pressed() -> void:
	if state != "work":
		$work_files.position = Vector2(269,3)
		$hobby_files.position = Vector2(269,-300)
		state = "work"
	else:
		pass

func _on_file_button_pressed() -> void:
	var obj = confetti.instantiate()
	obj.position = position + Vector2i(size.x / 2.0, 50)
	obj.display.connect(_on_confetti_display)
	add_sibling(obj)

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


func _on_secret_pressed() -> void:
	var obj = secret_window.instantiate()
	obj.closed.connect(_on_secret_closed)
	obj.password = passwords[tries % 10]
	obj.tries = tries
	add_child(obj)

func _on_secret_closed(x):
	tries += x
