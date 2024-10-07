class_name CreateAccountUI extends PanelContainer

@export_category('Componentes')
@export var email_line: LineEdit
@export var password_line: LineEdit
@export var re_password_line: LineEdit
@export var access_button: Button

@export_category('Referências')
@export var access_account_ui: PanelContainer


func _on_close_button_pressed() -> void:
	self.hide()
	access_account_ui.show()


func _on_email_line_text_changed(new_text: String) -> void:
	if _is_valid_email(new_text):
		email_line.remove_theme_color_override("font_color")
		access_button.disabled = false
	else:
		email_line.add_theme_color_override("font_color", Color.RED)
		access_button.disabled = true


func _on_password_line_text_changed(new_text: String) -> void:
	if _is_valid_password(new_text):
		password_line.remove_theme_color_override("font_color")
		access_button.disabled = false
	else:
		password_line.add_theme_color_override("font_color", Color.RED)
		access_button.disabled = true


func _on_re_password_line_text_changed(new_text: String) -> void:
	if _is_valid_password(new_text):
		password_line.remove_theme_color_override("font_color")
		access_button.disabled = false
	else:
		password_line.add_theme_color_override("font_color", Color.RED)
		access_button.disabled = true


func _on_access_button_pressed() -> void:
	var alert: AlertUI = AlertUI.new()

	if password_line.text != re_password_line.text:
		alert.show_alert(get_tree(), 'A senha informada não são iguais!')
		return

	if password_line.text.length() < 3 || re_password_line.text.length() < 3:
		alert.show_alert(get_tree(), 'A senha informada é muito pequena!')

	CreateAccount.new(email_line.text, password_line.text).send()
	#var outgoing = CreateAccount.new(email_line.text, password_line.text)
	#outgoing.send()


func _is_valid_email(email: String) -> bool:
	var email_regex: RegEx = RegEx.new()
	email_regex.compile(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
	return email_regex.search(email) != null


func _is_valid_password(password: String) -> bool:
	return password.length() >= 3
