// adapted from InsuranceHeader_PreProcess.mod_clean_suffix in Alpha
export string5 fn_normSuffix(string5 sname) := function
	
	snameSet		:= ['SR', 'JR', '1', '2', '3', '4', '5', '6', '7', '8'];
	optSnameSet	:= ['JR JR', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII'];
	
	return map(
		sname not in snameSet and sname not in optSnameSet => '', 
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
end;
