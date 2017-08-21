export Layout_common_Offense := record, maxlength(200000)
	string60 Seisint_Primary_Key;
	//string10 DATE_ADJUDICATED;
	//string84 ADJUDICATION_CHARGE_DESCRIPTION;
	//string25 QUALIFIER;
	string20	source_file := '';			//new field added for CROSS
	string80 	conviction_jurisdiction := '';
	string8  	conviction_date := '';
	string30 	court := '';
	string25 	court_case_number := '';
	string8  	offense_date := '';
	string20 	offense_code_or_statute := '';
	string320   offense_description := '';
	string180   offense_description_2 := '';
	string30	offense_category:= '';
	string10	offense_level := '';		//new field added for CROSS
	string1  	victim_minor := '';
	string3  	victim_age := '';
	string10 	victim_gender := '';
	string30 	victim_relationship := '';
	string180   sentence_description := '';
	string180   sentence_description_2 := '';
	string8		disposition_dt := '';		//new field added for CROSS
	string8		arrest_date := '';			
	string250	arrest_warrant := '';
	string40    offense_location := '';		//new field added for CROSS
end;