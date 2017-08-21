IMPORT	Targus,	ut;
EXPORT	Layout_Targus	:=	Targus.Layout_Consumer_Out_Unfiltered AND NOT 
	[
		ScrubsBits1,
		ScrubsBits2
	];