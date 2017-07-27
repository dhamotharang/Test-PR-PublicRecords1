EXPORT Mod_Sets := Module

EXPORT threshld:=0.05;

EXPORT Consortium
		:=
			[
			'AL'
			,'FL'
			,'GA'
			,'LA'
			,'MS'
			]
			;

EXPORT Benefit_Type
		:=
			[
			'D'
			,'S'
			,'T'
			,'U'
			,'M'
			,'C'
			,'N'
			]
			;

EXPORT Gender
		:=
			[
			'F'
			,'M'
			,'U'
			]
			;

EXPORT Race
		:=
			[
			'A'
			,'B'
			,'N'
			,'O'
			,'P'
			,'U'
			,'W'
			]
			;

EXPORT Ethnicity
		:=
			[
			'H'
			,'N'
			,'U'
			]
			;

EXPORT SSN_Type
		:=
			[
			'A'
			,'P'
			,'D'
			]
			;

EXPORT Actual_Type := 'A';
EXPORT Pseudo_Type := 'P';
EXPORT Default_Type := 'D';

EXPORT DOB_Type
		:=
			[
			'A'
			,'P'
			,'D'
			]
			;

EXPORT Eligible_Status
		:=
			[
			'D'
			,'E'
			,'I'
			,'N'
			,'A'
			]
			;

EXPORT	States
		:=
			[
			 'AK' 
			 ,'AL' 
			 ,'AR' 
			 ,'AZ' 
			 ,'CA' 
			 ,'CO' 
			 ,'CT' 
			 ,'DC' 
			 ,'DE' 
			 ,'FL' 
			 ,'GA' 
			 ,'HI' 
			 ,'IA' 
			 ,'ID' 
			 ,'IL' 
			 ,'IN' 
			 ,'KS' 
			 ,'KY' 
			 ,'LA' 
			 ,'MA' 
			 ,'MD' 
			 ,'ME' 
			 ,'MI' 
			 ,'MN' 
			 ,'MO' 
			 ,'MS' 
			 ,'MT' 
			 ,'NC' 
			 ,'ND' 
			 ,'NE' 
			 ,'NH' 
			 ,'NJ' 
			 ,'NM' 
			 ,'NV' 
			 ,'NY' 
			 ,'OH' 
			 ,'OK' 
			 ,'OR' 
			 ,'PA' 
			 ,'RI' 
			 ,'SC' 
			 ,'SD' 
			 ,'TN' 
			 ,'TX' 
			 ,'UT' 
			 ,'VA' 
			 ,'VT' 
			 ,'WA' 
			 ,'WI' 
			 ,'WV' 
			 ,'WY' 
			]
	;

EXPORT RegexBadAddress
		:=
			 '(.*)('
			+'.SAME.'
			+'|.GENERAL.DELIVERY.'
			+'|.GENERALDELIVERY.'
			+'|.HOMELESS.'
			+'|DONALD.LEE.HOLLOWELL'
			+')(.*)';

EXPORT SetBadAddress
    :=
			[
			'SAME'
			,'GENERAL DELIVERY'
			,'GENERALDELIVERY'
			,'HOMELESS'
			,'DONALD LEE HOLLOWELL'
			]
	;

END;