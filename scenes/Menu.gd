extends Control

enum menu_pages{
	MAIN,
	CREDITS
}

onready var Pages := $Pages
onready var m_Main := $Pages/Main
onready var m_Credits := $Pages/Credits
onready var BtnPlay := $Pages/Main/VBoxContainer/VBoxContainer/BtnPlay


func _ready():
	BtnPlay.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel") and not visible:
		show_menu()


func show_menu(menu_page: int = menu_pages.MAIN):
	get_tree().paused = true
	var TW = create_tween().set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS).set_parallel().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	
	if not visible:
		visible = true
		Pages.anchor_left = -0.5
		Pages.anchor_right = 0.5
		modulate = Color(1.0, 1.0, 1.0, 0.5)
		TW.tween_property(Pages, "anchor_left", 0.0, 0.15)
		TW.tween_property(Pages, "anchor_right", 1.0, 0.15)
		TW.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.15)
	
	var page
	var button_focus
	match menu_page:
		menu_pages.MAIN:
			page = m_Main
			button_focus = BtnPlay
			
		menu_pages.CREDITS:
			page = m_Credits
			button_focus = page.get_node("VBoxContainer/BtnBack")
	
	for i in Pages.get_children():
		i.visible = false
	
	page.visible = true
	button_focus.grab_focus()
	
	page.anchor_left = -0.5
	page.anchor_right = 0.5
	page.modulate = Color(1.0, 1.0, 1.0, 0.5)
	TW.tween_property(page, "anchor_left", 0.0, 0.15)
	TW.tween_property(page, "anchor_right", 1.0, 0.15)
	TW.tween_property(page, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.15)
	yield(TW, "finished")

func hide_menu():
	if visible:
		var TW = create_tween().set_pause_mode(SceneTreeTween.TWEEN_PAUSE_PROCESS).set_parallel().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		TW.tween_property(Pages, "anchor_left", -0.5, 0.15)
		TW.tween_property(Pages, "anchor_right", 0.5, 0.15)
		TW.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.15)
		yield(TW, "finished")
		get_tree().paused = false
		visible = false


func _on_BtnPlay_pressed():
	hide_menu()

func _on_BtnCredits_pressed():
	show_menu(menu_pages.CREDITS)

func _on_BtnBack_pressed():
	show_menu(menu_pages.MAIN)
