export GenderTools := module

export set_gender_unks  := ['U','N'];
export set_gender_known := ['M','F'];

//****** ADD AGE AND GENDER

export diff(string1 l,string1 r) := 
	MAP ( l in set_gender_unks or r in set_gender_unks => 'P',
		  l<>r => 'Y',
		  'N' );
																					

export gender(string fname, string mname) := 
		IF( datalib.gender(fname) in set_gender_unks and datalib.gender(mname) IN set_gender_known,
			datalib.gender(mname),
			datalib.gender(fname));

END;