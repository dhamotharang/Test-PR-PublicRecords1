// export boolean func_is_address(string pInput) := regexfind('(^\\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|'+ 
												// '^\\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})$|' + 
												// '^\\d{1,6}\040([A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,}\040[A-Z]{1}[a-z]{1,})|'+
												// '^(.*)(([0-9] +)|BOX |#|SUITE |STE|STREET|P.O.B.|POB |BLDG |LANE|CR\\.)(.*)|'+
												// '([ \\w]*\\#\\d+)?(\r\n| )$)',StringLib.StringToUpperCase(pInput));
												



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



