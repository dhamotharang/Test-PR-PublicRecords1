import autokey,doxie,AutokeyB2;
export Layout_Address :=
RECORD
	autokey.Layout_Address_bare;
	AutokeyB2.Layout_Cname;
	doxie.Layout_ref_bdid;
	unsigned4 lookups;
END;