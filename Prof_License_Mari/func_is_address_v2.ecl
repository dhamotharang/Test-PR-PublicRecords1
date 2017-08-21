export boolean func_is_address_v2(string pInput) :=
			   REGEXFIND('(^| )[0-9]*[ ]?(st|nd|rd|th) ((n|s|e|w|ne|nw|se|sw)[\\.]?|north|south|east|west|ave|avenue|st|street)( |$)',TRIM(pInput, LEFT, RIGHT), NOCASE) //most common addresses
			OR REGEXFIND('^[a-z]?[0-9]+[-]?[0-9]*[a-z]?[ ]*[-]*[ ]*[0-9a-z \\-\\./\'"]+[-]*[ ]+' + 
				          '(avenue|bay|bend|bldg|boulevard|circle|court|cove|creek|drive|forest|gardens|green|'+
									'habor|heights|hgts|highway|hill|hills|lake|lane|loop|meadows|oaks|' +
									'park|parkway|pass|path|pike|place|plaza|pointe|pond|ridge|river|road|run|'+
									'shores|square|stream|street|terrace|tower|twr|tr|trl|tr(ace|ail)|turnpike|turn|'+
									'valley|village|walk|way|wood)( |$)',
									TRIM(pInput, LEFT, RIGHT), NOCASE) //most common addresses
			OR REGEXFIND('^[a-z]?[0-9]+[-]?[0-9]*[a-z]?[ ]+[0-9a-z \\-\\./]+[ ]+(ave$|ave,|ave\\.|ave |blvd$|blvd,|blvd\\.|blvd |c[i]?r$|c[i]?r,|c[i]?r\\.|c[i]?r |c[r]?t$|c[r]?t,|c[r]?t\\.|c[r]?t |ctr$|ctr,|ctr\\.|ctr |dr$|dr,|dr\\.|dr |hwy$|hwy,|hwy\\.|hwy |ln$|ln,|ln\\.|ln |pkwy$|pkwy,|pkwy\\.|pkwy |pl$|pl,|pl\\.|pl |rd$|rd,|rd\\.|rd |sq$|sq,|sq\\.|sq |st$|st,|st\\.|st |ter[r]*$|ter[r]*,|ter[r]*\\.|ter[r]* |trce$|trce,|trce\\.|trce )',TRIM(pInput, LEFT, RIGHT), NOCASE)
			OR REGEXFIND('^[a-z]?[0-9]+[-]?[0-9]*[a-z]?[ ]+(E[\\.]?|W[\\.]?|N[\\.]?(E|W)?[\\.]?|S[\\.]?(E|W)?[\\.]?)( |$)',TRIM(pInput, LEFT, RIGHT), NOCASE)   //1234 NW name
			OR REGEXFIND('^[a-z]?[0-9]+[-]?[0-9]*[a-z]?[ ]+[a-z]+ [a-z]*[ ]?(E[\\.]?|W[\\.]?|N[\\.]?(E|W)?[\\.]?|S[\\.]?(E|W)?[\\.]?)( |$)',TRIM(pInput, LEFT, RIGHT), NOCASE)   //1234 name1 name2 NW 
			OR REGEXFIND('( |^)P[\\.]?[ ]*O[\\.]?[ ]*(BOX|BX|DRAWER)[ ]+[0-9]+',TRIM(pInput, LEFT, RIGHT), NOCASE)   //post office box
			OR REGEXFIND('( |^)POST[\\.]?[ ]+OFFICE[\\.]?[ ]+BOX[ ]+[0-9]+',TRIM(pInput, LEFT, RIGHT), NOCASE)   //post office box
			OR REGEXFIND('(^| )(BOX|BX|DRAWER) [0-9]+',TRIM(pInput, LEFT, RIGHT), NOCASE) //post office box
			OR REGEXFIND('[^| ]US( |-)[0-9]+( |$)',TRIM(pInput, LEFT, RIGHT), NOCASE) //US-digit or US digits
			OR REGEXFIND('^[0-9]+ [a-z]+$', TRIM(pInput, LEFT, RIGHT), NOCASE)  //This qualifies any address with street # + ' '+ textsting as address
			OR REGEXFIND('(#|APT |BLD |EXT |FLOOR |FL |LEVEL |LOT |NO |PMB |PO |POB |RFD |S[U]?[I]?TE |UNIT )[ ]*[a-z0-9\\-\\.]+( |$)',TRIM(pInput, LEFT, RIGHT), NOCASE) //line contains suite/unit #			
			OR REGEXFIND('^[0-9+[ ]?[a-z]*[ ]+(route|highway)[ ]+|(^|^state |^us )(pier|rr|route|rte|highway|hwy) [a-z0-9]*[-]?[a-z0-9]+$|[a-z ]+ route [0-9]+$',TRIM(pInput, LEFT, RIGHT), NOCASE)
			or regexfind('^[0-9]+ ([0-9]{1,3} mile|m( |-)[0-9]{1,3})( |$)',  TRIM(pInput, LEFT, RIGHT), NOCASE)  //1234 17 mile or 1234 m-17 or 1234 m 17
			OR REGEXFIND('^[0-9]+[-]?[0-9]*[a-z]?[ ]+(s\\.|south|w\\.|west|n\\.|north|e\\.|east|s[\\.]?w[\\.]?|s[\\.]?e[\\.]?|n[\\.]?w[\\.]?|n[\\.]?e[\\.]?) ',  TRIM(pInput, LEFT, RIGHT), NOCASE)  //matches 1234 South/north/... name
			//OR REGEXFIND('^[0-9]+[-]?[0-9]*[a-z]?[ ]+[0-9]{1,3}[ ]?(st|nd|rd|th)( |$)',  TRIM(pInput, LEFT, RIGHT), NOCASE)  //matches 1234 3333rd
			OR REGEXFIND('^[0-9]*$',TRIM(pInput, LEFT, RIGHT), NOCASE);   //allow for blank and digit only
	
	/*
export boolean func_is_address(string pInput) :=
regexfind('^[0-9]*$|(^\\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|'+ 
'^\\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|' + 
'^\\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}))|'+
'^(.*)(([0-9] +)|BOX |#| C(?:OURT|T)$| AVE$|SUITE |STE |SUTE | STREET| ST|P.O.B.|POB|P O |PO DRAWER |PO |POBOX|BLDG | BUILDING | BLVD|AVENUE| ROAD| RD| DRIVE| DR$| CENTER|'+
'RAOD| ROOM | FLOOR| LEVEL|POST OFFICE |UNIT |HWY |LANE| LN|LOT |APT|APARTMENT |PMB|MAIL CODE | PLAZA| SQUARE| TRAIL| TR$| WAY|CR\\.)(.*)|'+
'(^\\d{1,6}.?\\d{0,3}\\s[a-zA-Z]{2,30}\\s[a-zA-Z]{2,15})|'+
'(?:(?:A(?:PT|PARTMENT)|B(?:LDG|UILDING)|D(?:EPT|RAWER)|FL |H(?:IGHWAY|NGR|WY)| LOT|PIER| RM |RFD|R(?:OUTE|TE|ROOM)| S(?:LIP|PC|T(?:E |OP) |UITE)|TRLR|UNIT | FLOOR|\\x23)\\.?\\x20*(?:[a-zA-Z0-9\\-]+))|'+
'^(([0-9]\\d{1,6} [A-Za-z ]+)+)|^((RD|RR)\\x20*\\d+){1,6}$|'+
// '^(([0-9]\\d{1,6}[A-Za-z ]+)+)|((RD|RR|NO)\\x20*[0-9]\\d+){1,6}(.*)|'+
'^(\\d{1,})\\s|([ \\w]*\\#\\d+)?(\r\n| )$',StringLib.StringToUpperCase(pInput));
*/