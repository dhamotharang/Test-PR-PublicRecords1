export Layout_SOR_Offense_out := record
Layout_UNQ_PK_DID_Plus_Relatives.persistent_key;
//Layout_SexOffender_Offense;
	string60 Seisint_Primary_Key;
	string80 	conviction_jurisdiction := '';
	string8  	conviction_date := '';
	string30 	court := '';
	string25 	court_case_number := '';
	string8  	offense_date := '';
	string20 	offense_code_or_statute := '';
	string320 offense_description := '';
	string180 offense_description_2 := '';
	string1  	victim_minor := '';
	string3  	victim_age := '';
	string10 	victim_gender := '';
	string30 	victim_relationship := '';
	string180 sentence_description := '';
	string180 sentence_description_2 := '';
end;