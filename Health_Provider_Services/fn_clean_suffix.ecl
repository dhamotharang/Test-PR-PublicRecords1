EXPORT fn_clean_suffix (STRING5 I_SNAME) := FUNCTION

  snameSet := ['SR', 'JR', '1', '2', '3', '4', '5', '6', '7', '8'];
	optionalSnameSet := ['JR JR', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII'];
	
	sname := TRIM(I_SNAME);
	CLEAN_SNAME			 := map(sname not in snameSet and sname not in optionalSnameSet => '', 
														sname = 'JR JR' => 'JR',
														sname = 'I' => 		'1',
														sname = 'II' => 	'2',
														sname = 'III' => 	'3',
														sname = 'IV' => 	'4',
														sname = 'V' => 	  '5',
														sname = 'VI' => 	'6',
														sname = 'VII' => 	'7',
														sname = 'VIII' => '8',
														sname);
	
	RETURN CLEAN_SNAME;
end;
