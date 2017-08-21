IMPORT	Death_Master,	ut;
EXPORT	Layout_Death_Master_SSA	:=	Death_Master.Layout_States.Death_Master_Base AND NOT 
	[
		ScrubsBits1
	];