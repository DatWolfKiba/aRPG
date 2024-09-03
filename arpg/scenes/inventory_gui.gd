extends Control

signal opened
signal closed

var isOpen: bool = false 
# Called when the node enters the scene tree for the first time.
func open():
	visible = true
	isOpen = true
	opened.emit()
	
func close():
	visible = false
	isOpen = false
	closed.emit()
