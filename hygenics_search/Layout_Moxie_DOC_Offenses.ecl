import crim_common, hygenics_crim;

export Layout_Moxie_DOC_Offenses := record
	string60 offender_key;
	hygenics_crim.Layout_Moxie_DOC_Offenses AND NOT offender_key;
	//string50 parole;
	//string50 probation;
	//string40 offensetown;
	//string8  convict_dt;
end;