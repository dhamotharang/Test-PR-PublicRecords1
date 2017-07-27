import autokey,doxie,autokeyb;
export Layout_Address :=
RECORD
	autokey.Layout_Address_bare;
	autokeyb.Layout_Cname;
	doxie.Layout_ref_bdid;
END;