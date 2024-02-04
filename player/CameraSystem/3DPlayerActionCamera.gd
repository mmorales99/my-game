class_name ActionCamera
extends Node3D

static var CameraController = load("res://player/CameraSystem/CameraController.gd") 
@export var Camera_Anchor: Node3D

func _init():
	pass

#static func get_anchor(baseNode: Node, anchor_name : NodePath):
	#assert(not null == anchor_name, "The anchor name cannot be null")
	#assert(not null == baseNode, "An action camera cannot be used by itself.
		#Needs an anchor node to be used as orbiting center.")
	#assert(baseNode.has_node(anchor_name), "No anchor node was present.
		#Maybe node's path is not correct.")
	#var anchor_node = baseNode.get_node(anchor_name).get_node("cam_anchor")
	#return anchor_node
