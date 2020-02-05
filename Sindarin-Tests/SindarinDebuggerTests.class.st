Class {
	#name : #SindarinDebuggerTests,
	#superclass : #TestCase,
	#instVars : [
		'breakpointsBeforeTest',
		'testObjectPoint'
	],
	#category : #'Sindarin-Tests'
}

{ #category : #tests }
SindarinDebuggerTests >> helperMethod1 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod10 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod11 [
	| a |
	a := 5.
	self helperMethod12.
	self helperMethod12.
	^ 3
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod12 [
	| i |
	i := 5.
	[ i=0 ] whileFalse: [ i := i - 1 ].
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod13 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod14 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod15 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod16 [
	^ 1+1.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod17: storeContextBlock [
	storeContextBlock value: thisContext.
	Point x:5 y: 7.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod18: anArg with: anotherArg [
	Point x: 5 y: 7.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod19 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod2 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod20 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod21 [
	self helperMethod22
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod22 [
	^ Point new
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod23 [
	testObjectPoint sign.
	testObjectPoint extent: (Point x:3 y: 4).
	Point new.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod24 [
	| p |
	p := Point new.
	p sign.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod3 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod4 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod5 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod6 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod7 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod8 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> helperMethod9 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #tests }
SindarinDebuggerTests >> runCaseManaged [
	^ self runCase
]

{ #category : #running }
SindarinDebuggerTests >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	breakpointsBeforeTest := VirtualBreakpoint all.
	VirtualBreakpoint all removeAll.
	testObjectPoint := Point x: 1 y: 2.
]

{ #category : #running }
SindarinDebuggerTests >> tearDown [
	VirtualBreakpoint all removeAll.
	breakpointsBeforeTest do: [ :brkpt | VirtualBreakpoint all add: brkpt ].
]

{ #category : #tests }
SindarinDebuggerTests >> testAddStepHook [
	| stepCounter stepHook scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod11 ].
	stepCounter := 0.
	stepHook := [ stepCounter := stepCounter + 1 ].
	scdbg addStepHook: stepHook.
	scdbg step.
	self assert: stepCounter equals: 1.
	scdbg step; stepOver.
	self assert: stepCounter equals: 21.
	scdbg removeStepHook: stepHook.
	scdbg stepOver.
	self assert: stepCounter equals: 21
]

{ #category : #tests }
SindarinDebuggerTests >> testArguments [
	| p scdbg |
	p := Point new.
	scdbg := SindarinDebugger debug: [ self helperMethod18: 1 with: p ].
	scdbg step.
	self assert: scdbg arguments size equals: 2.
	self assert: (scdbg arguments at: 1) equals: 1.
	self assert: (scdbg arguments at: 2) equals: p
	
]

{ #category : #tests }
SindarinDebuggerTests >> testAssignmentValue [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod2 ].
	scdbg step.
	self assert: scdbg assignmentValue equals: 5
]

{ #category : #tests }
SindarinDebuggerTests >> testAssignmentVariableName [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod3 ].
	scdbg step.
	self assert: scdbg assignmentVariableName equals: #a
]

{ #category : #tests }
SindarinDebuggerTests >> testContext [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod15 ].
	self assert: scdbg context equals: scdbg debugSession interruptedContext.
	scdbg step.
	self assert: scdbg context equals: scdbg debugSession interruptedContext
]

{ #category : #tests }
SindarinDebuggerTests >> testContinue [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod19 ].
	scdbg
		step;
		step.
	self assert: scdbg node isMessage.
	self assert: scdbg node selector equals: #asInteger.
	scdbg setBreakpoint.
	scdbg := SindarinDebugger debug: [ self helperMethod19 ].
	scdbg continue.
	self assert: scdbg node isMessage.
	self assert: scdbg node selector equals: #asInteger
]

{ #category : #tests }
SindarinDebuggerTests >> testContinueUntilTheEnd [
	"Test the #continue method when no breakpoint/halt is set. It should step the execution until the end and NOT freeze the image"

	| scdbg semaphore |
	self flag: 'What is "setup code for the timeout?'.
	"VVV Setup code for the timeout"
	semaphore := Semaphore new.
	[ "^^^ Setup code for the timeout"
	scdbg := SindarinDebugger debug: [ self helperMethod20 ].
	scdbg continue.
	self assert: scdbg isExecutionFinished.

	"VVV Code for the timeout"
	semaphore signal ] fork.
	semaphore
		wait: 5 seconds
		onCompletion: [ 'success' ]
		onTimeout: [ "^^^ Setup code for the timeout" self assert: false description: 'Test timed out' ]
]

{ #category : #tests }
SindarinDebuggerTests >> testIsExecutionFinished [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod16 ].
	self deny: scdbg isExecutionFinished.
	scdbg
		stepOver;
		step;
		step;
		stepOver;
		step;
		stepOver;
		step.
	"Reached `self isActiveProcess` in Process>>#terminate"
	self assert: scdbg isExecutionFinished
]

{ #category : #tests }
SindarinDebuggerTests >> testMessageArguments [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod4 ].
	scdbg step; step.
	self assert: scdbg messageArguments isEmpty.
	scdbg stepOver.
	self assert: (scdbg messageArguments at: 1) equals: 5.
	self assert: (scdbg messageArguments at: 2) equals: 3
]

{ #category : #tests }
SindarinDebuggerTests >> testMessageReceiver [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod5 ].
	self assert: scdbg messageReceiver equals: self.
	scdbg step; step.
	self assert: scdbg messageReceiver equals: '3'
]

{ #category : #tests }
SindarinDebuggerTests >> testMessageSelector [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod6 ].
	self assert: scdbg messageSelector equals: #helperMethod6.
	scdbg step; step.
	self assert: scdbg messageSelector equals: #asInteger.
	scdbg stepOver.
	self assert: scdbg messageSelector equals: #x:y:
]

{ #category : #tests }
SindarinDebuggerTests >> testMessageTo [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod23 ].
	scdbg step.	"Step to <testObjectPoint sign.> call"
	self assert: (scdbg message: #sign to: testObjectPoint).
	scdbg
		stepOver;
		stepOver.	"Step to <testObjectPoint extent: ...> call"
	self assert: (scdbg message: #extent: to: testObjectPoint).
	
	"Should return false with wrong selector but correct receiver"
	self deny: (scdbg message: #bogus to: testObjectPoint).
	
	"Should return false with correct selector but wrong receiver"
	self deny: (scdbg message: #extent: to: Point new)	
]

{ #category : #tests }
SindarinDebuggerTests >> testMessageToInstanceOf [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod24 ].
	scdbg step; stepOver: 2. "Step to <p sign> call"
	self assert: (scdbg message: #sign toInstanceOf: Point).
	self assert: (scdbg message: #sign toInstanceOf: Object).
	self deny: (scdbg message: #sign toInstanceOf: Rectangle).
	self deny: (scdbg message: #bogus toInstanceOf: Point)
]

{ #category : #tests }
SindarinDebuggerTests >> testMethod [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod7 ].
	self assert: scdbg method equals: SindarinDebuggerTests>>#testMethod.
	scdbg step.
	self assert: scdbg method equals: SindarinDebuggerTests>>#helperMethod7.
	scdbg step; step.
	self assert: scdbg method equals: String>>#asInteger
]

{ #category : #tests }
SindarinDebuggerTests >> testNode [
	| node scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod1 ].
	node := scdbg node.
	self assert: node isMessage.
	self assert: node selector equals: #helperMethod1.
	scdbg step.
	node := scdbg node.
	self assert: node isAssignment.
	self assert: node variable name equals: #a.
	scdbg step.
	node := scdbg node.
	self assert: node isMessage.
	self assert: node selector equals: #asInteger
]

{ #category : #tests }
SindarinDebuggerTests >> testOnceBreakpoint [
	| breakpoint scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod19 ].
	scdbg step; step.
	self assert: scdbg node isMessage.
	self assert: scdbg node selector equals: #asInteger.
	breakpoint := scdbg setBreakpoint.
	breakpoint once.
	scdbg := SindarinDebugger debug: [ self helperMethod19 ].
	scdbg continue.
	scdbg := SindarinDebugger debug: [ self helperMethod19 ].
	scdbg continue.
	self assert: scdbg isExecutionFinished
]

{ #category : #tests }
SindarinDebuggerTests >> testReceiver [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod8 ].
	self assert: scdbg receiver equals: self.
	scdbg step.
	self assert: scdbg receiver equals: self.
	scdbg step; step.
	self assert: scdbg receiver equals: '3'
]

{ #category : #tests }
SindarinDebuggerTests >> testRemoveBreakpoint [
	| breakpoint scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod19 ].
	scdbg step; step.
	self assert: scdbg node isMessage.
	self assert: scdbg node selector equals: #asInteger.
	breakpoint := scdbg setBreakpoint.
	breakpoint remove.
	scdbg := SindarinDebugger debug: [ self helperMethod19 ].
	scdbg continue.
	self assert: scdbg isExecutionFinished
]

{ #category : #tests }
SindarinDebuggerTests >> testSelector [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod9 ].
	self assert: scdbg selector equals: #testSelector.
	scdbg step.
	self assert: scdbg selector equals: #helperMethod9.
	scdbg step; step.
	self assert: scdbg selector equals: #asInteger
]

{ #category : #tests }
SindarinDebuggerTests >> testSetBreakpoint [
	self flag: 'What is this test?'.
	self testContinue
]

{ #category : #tests }
SindarinDebuggerTests >> testSkip [
	| a p scdbg |
	a := 1.
	scdbg := SindarinDebugger
		debug: [ a := 2.
			p := Point x: 2 y: 3 ].
	scdbg skip.
	self assert: a equals: 1.
	scdbg skip.
	scdbg step.
	self assert: p equals: nil
]

{ #category : #tests }
SindarinDebuggerTests >> testSkipWith [
	| a p scdbg |
	a := 1.
	scdbg := SindarinDebugger
		debug: [ a := 2.
			p := Point x: 2 y: 3 ].
	scdbg skipWith: 3.
	self assert: a equals: 1.
	scdbg skipWith: 5.
	scdbg step.
	self assert: p equals: 5
]

{ #category : #tests }
SindarinDebuggerTests >> testStack [
	| context1 context2 storeContextBlock scdbg |
	storeContextBlock := [ :thisCtx | context2 := thisCtx ].
	scdbg := SindarinDebugger
		debug: [ context1 := thisContext.
			self helperMethod17: storeContextBlock ].
	scdbg step.
	self assert: scdbg stack first equals: context1.
	scdbg
		step;
		stepOver.
	self assert: scdbg stack first equals: context2.
	self assert: (scdbg stack at: 2) equals: context1
]

{ #category : #tests }
SindarinDebuggerTests >> testStep [
	| node scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod13 ].
	scdbg step.
	node := scdbg node.
	self assert: node isAssignment.
	self assert: node variable name equals: #a.
	scdbg step.
	node := scdbg node.
	self assert: node isMessage.
	self assert: node selector equals: #asInteger
]

{ #category : #tests }
SindarinDebuggerTests >> testStepOver [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod14 ].
	scdbg stepOver.
	self assert: scdbg node isBlock
]

{ #category : #tests }
SindarinDebuggerTests >> testStepOverReturnNode [
	|scdbg|
	scdbg := SindarinDebugger debug: [ self helperMethod21 ].
	scdbg step; step.
	scdbg stepOver.
	self shouldnt: [scdbg stepOver] raise: SteppingATerminatingProcess.
	self assert: scdbg selector equals: #helperMethod21.
	self assert: scdbg node isMethod.
	self flag: 'Why is the following commented? Should it be tested somehow?'
"	self assert: scdbg node isBlock."
]

{ #category : #tests }
SindarinDebuggerTests >> testStepUntil [
	| i scdbg |
	i := 20.
	scdbg := SindarinDebugger
		debug: [ [ i = 0 ] whileFalse: [ i := i - 1 ] ].
	scdbg stepUntil: [ i = 12 ].
	self assert: i equals: 12
]

{ #category : #tests }
SindarinDebuggerTests >> testSteppingAnExecutionSignalingExceptions [
	| scdbg |
	scdbg := SindarinDebugger
		debug: [ 1 / 0.
			2 / 0.
			3 / 0 ].
	self
		should: [ scdbg
				stepOver;
				stepOver;
				stepOver ]
		raise: UnhandledExceptionSignalledByADebuggedExecution
]

{ #category : #tests }
SindarinDebuggerTests >> testTemporaries [
	| scdbg |
	scdbg := SindarinDebugger debug: [ self helperMethod10 ].
	self assert: scdbg temporaries size equals: 1.
	scdbg step.
	self assert: scdbg temporaries size equals: 1.
	self assert: (scdbg temporaries at: #a) equals: nil.
	scdbg step.
	self assert: scdbg temporaries size equals: 1.
	self assert: (scdbg temporaries at: #a) equals: 5
]

{ #category : #tests }
SindarinDebuggerTests >> testWhenHitBreakpoint [
	| breakpoint toggle scdbg |
	toggle := false.
	scdbg := SindarinDebugger debug: [ self helperMethod19 ].
	scdbg step; step.
	self assert: scdbg node isMessage.
	self assert: scdbg node selector equals: #asInteger.
	breakpoint := scdbg setBreakpoint.
	breakpoint whenHit: [ toggle := true ].
	scdbg := SindarinDebugger debug: [ self helperMethod19 ].
	scdbg continue.
	self assert: toggle
]