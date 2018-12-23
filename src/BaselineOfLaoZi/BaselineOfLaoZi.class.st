Class {
	#name : #BaselineOfLaoZi,
	#superclass : #BaselineOf,
	#category : #BaselineOfLaoZi
}

{ #category : #baselines }
BaselineOfLaoZi >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec baseline: 'SpecWizard' with: [ spec repository: 'github://sbragagnolo/specwizard' ].
			spec baseline: 'TaskItShell' with: [ spec repository: 'github://sbragagnolo/taskit' ].
			spec baseline: 'ROSDDS' with: [ spec repository: 'github://sbragagnolo/ROSDDS/src' ].
			spec package: 'LaoZi' with: [ spec requires: #('SpecWizard' 'TaskItShell' 'ROSDDS') ] ]
]
