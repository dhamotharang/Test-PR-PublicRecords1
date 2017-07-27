import autokey,doxie,autokeyb2;
export Layout_CityStName :=
RECORD
  unsigned4 city_code;
  STRING2 st;
  AutokeyB2.Layout_Cname;
  doxie.Layout_ref_bdid;
	unsigned4 lookups;
END;