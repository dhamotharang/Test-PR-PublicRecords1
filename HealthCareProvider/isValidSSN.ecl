IMPORT UT;
EXPORT isValidSSN (STRING9 pField):= FUNCTION
	cln_pField := regexreplace('[A-Za-z]|'+'\\s|'+'!|`|~|@|#|\\$|%|\\^|\\&|\\*|\\(|\\)|<|>|\\{|\'|\\[|\\}|\\|@|\\Â¦|_|-|\\+|\\=|/|]|\\\\|:|;|\\.|,|\\?|"',pField, '');
 
	boolean is_invalid_length			:= length(cln_pField)<>9;
	boolean is_partial             := ut.partial_ssn(pField);
	 boolean is_itin                := pField[1]='9' and pField[4] in ['7','8'];
	 boolean is_9xx									:= pField[1]='9' and is_itin=false;
	 boolean is_666                 := pField[1..3]='666';
	 boolean is_eae                 := pField[1..3] between '729' and '733';
	 boolean is_advertising         := pField between '987654320' and '987654329';
	 boolean is_woolworth           := pField='078051120';
	 // boolean is_invalid_area        := pField[1]= '0' and is_itin=false;
	 boolean is_invalid_group       := pField[4..5]=  '00' and is_partial=false and is_itin=false;
	 boolean is_invalid_serial      := pField[6..9]='0000'                      and is_itin=false;
	 boolean is_repeat_two					:= regexfind('([^ ]{2})\\1\\1\\1', pField);
	 // boolean is_repeat_three		:= regexfind('([^ ])\\1\\1',pField);
	 boolean is_repeat_three				:=	regexfind('([0-9])\\1{2}([0-9])\\2([0-9])\\3{3}',pField);
	 boolean is_invalid_serial_1_9  := pField='123456789';
	 boolean is_123                 := pField[1..3]='123';
		
	 string concat_flags := 
							if(is_partial,          'P',' ')
							+ if(is_invalid_length, 'L',' ')
							+ if(is_itin   ,        'I',' ')
							+ if(is_9xx		,		'9', ' ')
									+ if(is_666    ,        '6',' ')
								+ if(is_eae    ,        'E',' ')
									+ if(is_advertising,    'V',' ')
									+ if(is_woolworth  ,    'W',' ')
									// + if(is_invalid_area,   'A',' ')
									+ if(is_invalid_group,  'G',' ')
								+ if(is_invalid_serial, 'S',' ')
							+ if(is_repeat_two, 	'2',' ')
							+ if(is_repeat_three, 	'3',' ')
							+ if(is_invalid_serial_1_9 ,'B',' ')
							+ if(is_123 ,'1',' ')
							;
		
 RETURN if (concat_flags = '',TRUE,FALSE);
END;