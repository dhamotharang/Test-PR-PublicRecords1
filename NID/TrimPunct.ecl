rgxPunct := '[ ,+!?_*&:;#%".()\'/\\\\-]+';		//  ,+;!?_*&:#%"'/\-
rgxPunct1 := '[ ,+!?_*&:;#%."\'/\\\\-]+';		//  ,+;!?_*&:#%"'/\-
EXPORT string TrimPunct(string s) := 
	TRIM(IF(REGEXFIND('^\\(.+\\)$',s),
			REGEXREPLACE(rgxPunct+'$',
						REGEXREPLACE('^'+rgxPunct,s,''),
			''),
			REGEXREPLACE(rgxPunct1+'$',
						REGEXREPLACE('^'+rgxPunct1,s,''),
			'')),LEFT,RIGHT);	
