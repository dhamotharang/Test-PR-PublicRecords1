IMPORT	Business_Credit_Scoring,	ut, STD;
EXPORT	fn_ReleaseDates(STRING pVersion	=	(STRING8)Std.Date.Today())	:=	MODULE
				
	EXPORT	PreviousMonth					:=	ut.Month_Math(pVersion[1..8],-1)[1..6];
	EXPORT	StartDate									:=	PreviousMonth+'01';
	EXPORT	EndDate											:=	PreviousMonth+(STRING)ut.Month_Days((UNSIGNED)PreviousMonth);

END;
