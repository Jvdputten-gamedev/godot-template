extends GutTest


var main_menu_scene



func before_each():
	main_menu_scene = preload("res://ui/main_menu/main_menu.tscn").instantiate()
	add_child_autoqfree(main_menu_scene)


func test_clicking_options_disables_main_menu():
	main_menu_scene._on_options_button_down()
	assert_false(main_menu_scene.main_menu_container.visible)

func test_on_options_button_down_options_active():
	main_menu_scene._on_options_button_down()
	assert_true(main_menu_scene.options_menu.visible)


