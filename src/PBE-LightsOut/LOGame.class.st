Class {
	#name : #LOGame,
	#superclass : #BorderedMorph,
	#instVars : [
		'cells',
		'cellsPerSide'
	],
	#classVars : [
		'cellsPerSide'
	],
	#category : #'PBE-LightsOut'
}

{ #category : #'as yet unclassified' }
LOGame class >> example10 [ 
	" Logame new.  "
	(LOGame new cellsPerSide: 20) openInHand
]

{ #category : #'as yet unclassified' }
LOGame class >> example20 [
	" LOGame example20 "
	(LOGame new cellsPerSide: 20) openInHand
]

{ #category : #initialization }
LOGame >> cellsPerSide [
	"The number of cells along each side of the game"
	^10
]

{ #category : #initialization }
LOGame >> initialize [ 
	|sampleCell width height n |
	super initialize.
	n := self cellsPerSide.
	sampleCell:= LOCell new.
	width := sampleCell width.
	height := sampleCell height.
	self bounds: (5@5 extent: (width*n) @(height *n) + (2 * self borderWidth)).
	cells := Array2D new:n tabulate: [ :i :j| self newCellAt: i at: j ]  
]

{ #category : #'event handling' }
LOGame >> mouseMove: anEvent [
]

{ #category : #initialization }
LOGame >> newCellAt: i at: j [
	"Create a cell for position (i,j) and add it to my on-screen
	representation at the appropriate screen position. Answer the
	new cell"
	| c origin |
	c := LOCell new.
	origin := self innerBounds origin.
	self addMorph: c.
	c position: ((i - 1) * c width) @ ((j - 1) * c height) + origin.
	c mouseAction: [ self toggleNeighboursOfCellAt: i at: j ].
	^c
]

{ #category : #'game logic' }
LOGame >> toggleNeighboursOfCellAt: i at: j [
i > 1
ifTrue: [ (cells at: i - 1 at: j) toggleState ].
i < self cellsPerSide
ifTrue: [ (cells at: i + 1 at: j) toggleState ].
j > 1
ifTrue: [ (cells at: i at: j - 1) toggleState ].
j < self cellsPerSide
ifTrue: [ (cells at: i at: j + 1) toggleState ]
]
