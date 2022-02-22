extends Node

signal pick_up_event_initiated (puzzle_piece, type)
signal stash_event_initiated(puzzle_piece)

var puzzle_piece_symbol = preload("res://Puzzle Piece System/Puzzle Symbols/Puzzle/Puzzle.png")
var platform_symbol = preload("res://Puzzle Piece System/Puzzle Symbols/Platform/Weight.png")
var reflector_symbol = preload("res://Puzzle Piece System/Puzzle Symbols/Reflector/Reflector.png")
var weight_symbol = preload("res://Puzzle Piece System/Puzzle Symbols/Weight/Weight.png")

var triangle = preload("res://Puzzle Piece System/Puzzle Pieces/Triangle/Triangle.png")
var square = preload("res://Puzzle Piece System/Puzzle Pieces/Square/Square.png")
var rectangle = preload("res://Puzzle Piece System/Puzzle Pieces/Rectangle/Rectangle.png")
var circle = preload("res://Puzzle Piece System/Puzzle Pieces/Circle/Circle.png")
var platform = preload("res://Puzzle Piece System/Puzzle Pieces/Platform/Platform.png")

var shapes = {
	
	 triangle : "Triangle",
	 square : "Square",
	 rectangle : "Rectangle",
	 circle : "Circle",
	 platform : "Platform"
}

var picked_up_piece

func _ready():
	connect("pick_up_event_initiated", self, "update_picked_up_piece")

func update_picked_up_piece(puzzle_piece, type):
	match type:
		"PICK_UP":
			if picked_up_piece == null:
				picked_up_piece = puzzle_piece
		"DROP":
			if picked_up_piece:
				picked_up_piece = null
	
