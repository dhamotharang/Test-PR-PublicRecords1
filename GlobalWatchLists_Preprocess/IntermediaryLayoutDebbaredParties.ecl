EXPORT IntermediaryLayoutDebbaredParties := MODULE;

EXPORT tempLayout := record
		Layouts.rDebarredParties;
		string aka;
		string orig_raw_name;
END;

EXPORT tempLayout2 := RECORD
	string8 	ent_key;
	string45 	source;
	string8 	lst_vend_upd;
	string70 	lstd_firm;
	string75 	lstd_entity;
	string150 aka;
	string22 	dob;
	string32 	fr_citation_1;
	string22 	eff_dt_1;
	string 		orig_raw_name;		
END;

EXPORT tempLayout3 := RECORD
  string8 ent_key;
  string45 source;
  string8 lst_vend_upd;
  string150 lstd_entity;
  string22 dob;
  string10 aka_flag;
  string32 fr_citation_1;
  string9 eff_dt_1;
	string 	orig_raw_name;	
	integer3 num := 0;
END;

END;