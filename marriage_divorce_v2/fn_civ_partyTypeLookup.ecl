
export fn_civ_partyTypeLookup(string field) := function

 string to_upper := stringlib.stringtouppercase(field);
 
 string v_coded := 	map(to_upper = 'DEFENDANT'        => 'D',
		                to_upper = 'DEFENDANTS'       => 'D',
		                to_upper = 'PRIMARY DEFENDANT'=> 'I',
		                to_upper = 'PLAINTIFF'        => 'P',
		                to_upper = 'PLAINTIFFS'       => 'P',
		                to_upper = 'PRIMARY PLAINTIFF'=> 'H',
		                to_upper = 'PETITIONER'       => 'M',			
		                to_upper = 'RESPONDENT'       => 'N',
		                to_upper = 'OTHER'            => 'O',
					   'U');

 return v_coded;

end;