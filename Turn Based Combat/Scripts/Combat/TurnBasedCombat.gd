extends Node2D

export(Resource) var enemy = null #exportando o "Mentor"

signal textbox_closed

var current_Dellman_health = 0
var current_enemy_health = 0





enum QuestionType {TEXT, IMAGE, VIDEO, AUDIO}

export (Resource) var bd_Quiz # acesso ao banco de dados
export (Color) var color_right
export (Color) var color_wrong

var buttons := [] # como precisamos de um array c todos os botoes, declaramos essa var
var index :=0  # index é indice, no caso a representa a pergunta atual do meu banco de dados
var quiz_shuffle := []
var correct := 0

onready var question_texts := $Textbox/Label
onready var question_image := $question_info/Panel/question_image
onready var question_video := $question_info/Panel/question_video
onready var question_audio := $question_info/Panel/question_audio





func _ready() -> void:
	
	$Textbox.hide()
	
	set_health($Mentor/ProgressBar, enemy.health, enemy.health) #define a vida dos personagens
	set_health($Dellman/ProgressBar, GlobalVariables.current_health, GlobalVariables.total_health)
	
	current_Dellman_health = GlobalVariables.current_health
	current_enemy_health = enemy.health
	
	display_text("Mentor: Are you prepared to face me?")
	yield(self, "textbox_closed")
	$ColorRect2/question_holder.show()
	
	
	for _button in $ColorRect2/question_holder.get_children(): #fazendo uma interação dentro dos buttons do nó quesiton holder
		buttons.append(_button) # adiciona os botões filhos do nó
	
	quiz_shuffle=randomize_array(bd_Quiz.bd)
	load_quiz()


func _input(event):
	if (Input.is_action_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT)) and $Textbox.visible:
		$Textbox.hide()
		emit_signal("textbox_closed")
		

func display_text(text):
	$Textbox.show()
	$Textbox/Label.text = text


#func _on_Fight_pressed(): #starting the fight // começando a luta
#	if $ColorRect2.visible == false:
#		$ColorRect2.visible = true
#	$ColorRect/Fight.visible = false
#	$Textbox.show()
#	question_texts.text = str(quiz_shuffle[index].question_info) # declarando que question_text vai receber a var bd do nosso bd_quiz, precisamos declarar qual o item e fazemos pelo index, depois pegamos o texto através da question_info definada no script "res_question" que exporta as variaves das perguntas
	
#func _input(event):   #to make the text box dissapear when pressing space or mouse
#	if (Input.is_action_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT) and ///.visible)
#	// .hide()


func set_health(progress_bar, health, total_health): #função para a verificação da vida
	progress_bar.value = health
	progress_bar.max_value = total_health
	progress_bar.get_node("Label").text = "HP:%d/%d" % [health, total_health] #appear health percentage



func enemy_turn():
#	$ColorRect2.hide()
	display_text("The Mentor gethers their vast knowledge!")
	yield(self, "textbox_closed")
#	$ColorRect2.show()
	
	current_Dellman_health = max(0, current_Dellman_health - enemy.damage)
	set_health($Dellman/ProgressBar, current_Dellman_health, GlobalVariables.total_health)
	
	$AnimationPlayer.play("Dellman.damage")
	yield($AnimationPlayer,"animation_finished")
	
#	$ColorRect2.hide()
	display_text("Mentor dealt %d damage!" % enemy.damage)
	yield(self, "textbox_closed")
#	$ColorRect2.show()


func _on_Button_pressed(): #ataque fraco
	
#	$ColorRect2.hide()
	display_text("You try to remember what you've just seen, but there's nothing there...")
	yield(self, "textbox_closed")
#	$ColorRect2.show()
	
	current_enemy_health = max(0, current_enemy_health - GlobalVariables.damage1)
	set_health($Mentor/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("Mentor_damage")
	yield($AnimationPlayer,"animation_finished")
	#animação... não sei muito o que falar sobre isso...
	
#	$ColorRect2.hide()
	display_text("You dealt %d damage!" % GlobalVariables.damage1)
	yield(self, "textbox_closed")
#	$ColorRect2.show()
	
	if current_enemy_health == 0:
		display_text("You could cure the Mentor!")
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("Mentor.died")
		yield($AnimationPlayer,"animation_finished")
		
		yield(get_tree().create_timer(0.40),"timeout")
		get_tree().quit()
	
	if current_Dellman_health == 0:
		display_text("You were defeated...")
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("Dellman.died")
		yield($AnimationPlayer,"animation_finished")
		
		yield(get_tree().create_timer(0.40),"timeout")
		get_tree().quit()
	
	enemy_turn()
	


func _on_Button2_pressed(): #ataque mediano
	
#	$ColorRect2.hide()
	display_text("You remember what you learn, but will it be enough?")
	yield(self, "textbox_closed")
#	$ColorRect2.show()
	
	current_enemy_health = max(0, current_enemy_health - GlobalVariables.damage2)
	set_health($Mentor/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("Mentor_damage")
	yield($AnimationPlayer,"animation_finished")
	#animação... não sei muito o que falar sobre isso...
	
#	$ColorRect2.hide()
	display_text("You dealt %d damage!" % GlobalVariables.damage2)
	yield(self, "textbox_closed")
#	$ColorRect2.show()
	
	if current_enemy_health == 0:
		display_text("You could cure the Mentor!")
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("Mentor.died")
		yield($AnimationPlayer,"animation_finished")
		
		yield(get_tree().create_timer(0.40),"timeout")
		get_tree().quit()
	
	if current_Dellman_health == 0:
		display_text("You were defeated...")
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("Dellman.died")
		yield($AnimationPlayer,"animation_finished")
		
		yield(get_tree().create_timer(0.40),"timeout")
		get_tree().quit()
	
	enemy_turn()


func _on_Button3_pressed(): #ataque mediano
	
#	$ColorRect2.hide()
	display_text("You concentrate your power and focus on your knowledge!")
	yield(self, "textbox_closed")
#	$ColorRect2.show()
	
	current_enemy_health = max(0, current_enemy_health - GlobalVariables.damage3)
	set_health($Mentor/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("Mentor_damage")
	yield($AnimationPlayer,"animation_finished")
	#animação... não sei muito o que falar sobre isso...
	
#	$ColorRect2.hide()
	display_text("You dealt %d damage!" % GlobalVariables.damage3)
	yield(self, "textbox_closed")
#	$ColorRect2.show()
	
	if current_enemy_health == 0:
		display_text("You could cure the Mentor!")
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("Mentor.died")
		yield($AnimationPlayer,"animation_finished")
		
		yield(get_tree().create_timer(0.40),"timeout")
		get_tree().quit()
	
	
	if current_Dellman_health == 0:
		display_text("You were defeated...")
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("Dellman.died")
		yield($AnimationPlayer,"animation_finished")
		
		yield(get_tree().create_timer(0.40),"timeout")
		get_tree().quit()
	
	enemy_turn()


func _on_Button4_pressed(): #ataque forte
	
#	$ColorRect2.hide()
	display_text("You gather new ideas and reflect upon your inner self!")
	yield(self, "textbox_closed")
#	$ColorRect2.show()
	
	current_enemy_health = max(0, current_enemy_health - GlobalVariables.damage4)
	set_health($Mentor/ProgressBar, current_enemy_health, enemy.health)
	
	$AnimationPlayer.play("Mentor_damage")
	yield($AnimationPlayer,"animation_finished")
	#animação... não sei muito o que falar sobre isso...
	
#	$ColorRect2.hide()
	display_text("You dealt %d damage!" % GlobalVariables.damage4)
	yield(self, "textbox_closed")
#	$ColorRect2.show()
	
	if current_enemy_health == 0:
		display_text("You could cure the Mentor!")
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("Mentor.died")
		yield($AnimationPlayer,"animation_finished")
		
		yield(get_tree().create_timer(0.40),"timeout")
		get_tree().quit()
	
	
	if current_Dellman_health == 0:
		display_text("You were defeated...")
		yield(self, "textbox_closed")
		
		$AnimationPlayer.play("Dellman.died")
		yield($AnimationPlayer,"animation_finished")
		
		yield(get_tree().create_timer(0.40),"timeout")
		get_tree().quit()
	
	enemy_turn()














func load_quiz() -> void:
	
	if index >= bd_Quiz.bd.size():
		print("Acabaram as perguntas")
		game_over()
		return # comando para sair da função
		
	
#	$Textbox.show()
	question_texts.text = str(quiz_shuffle[index].question_info) # declarando que question_text vai receber a var bd do nosso bd_quiz, precisamos declarar qual o item e fazemos pelo index, depois pegamos o texto através da question_info definada no script "res_question" que exporta as variaves das perguntas
	print(question_texts)
	
	var options = randomize_array(bd_Quiz.bd[index].options)
	
	for i in buttons.size():
		buttons[i].text=str(options[i]) # preenchendo os buttons com as options ou alternativas
		buttons[i].connect("pressed", self, "buttons_answer", [buttons[i]]) # criando o sinal pressed nesse mesmo scrpit, com a func buttons_answer, passando o próprio botão como argumento
		
	match bd_Quiz.bd[index].type:
		QuestionType.TEXT: # se o question type for texto, escona o panel
			$Textbox.show()
		
		QuestionType.IMAGE: # se o question type for imagem, habilita o panel
			$Textbox.show()
			question_image.texture=bd_Quiz.bd[index].question_image
			
		QuestionType.VIDEO: # se o question type for imagem, habilita o panel
			$Textbox.show()
			question_video.strem=bd_Quiz.bd[index].question_video
			question_video.play()
			
		QuestionType.AUDIO: # se o question type for video, habilita o panel
			$Textbox.show()
			# question_image.texture=load("res arquivo que eu quiser")
			question_audio.stream=bd_Quiz.bd[index].question_audio
			question_audio.play()
			
func buttons_answer(button) -> void:
	print(button.text)
	if bd_Quiz.bd[index].correct == button.text:
		button.modulate = color_right
		correct += 1
	else:
		button.modulate = color_wrong
		
#	question_audio.stop() # para a reprodução se n fica repetindo
#	question_video.stop()
	
	yield (get_tree().create_timer(5), "timeout") # criando temporizador de 1 s, para continuar o processo
	for bt in buttons: # para cada bt em buttons a gnt vai pegar o modulate e voltar para o padrão
		bt.modulate=Color.white
		bt.disconnect("pressed", self, "buttons_answer")
	
#	question_audio.stream=null # apenas apra evitar bugs
#	question_video.stream=null
	index +=1 # quando ele responder, ele irá para a outra pergunta
	load_quiz()
	
func randomize_array(array: Array) -> Array: #funcao para randomizar um array
	randomize()
	var array_temp := array #criando var temporario para receber o array
	array_temp.shuffle()
	return array_temp # retornando o array randozmizado

func game_over() -> void:
	$game_over.show()
	$game_over/txt_result.text=str(correct, "/", bd_Quiz.bd.size())


#func _on_button_restart_pressed():
#	get_tree().reload_current_scene()
