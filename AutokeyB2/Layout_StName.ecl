import doxie,autokeyb2;
export Layout_StName :=
RECORD
  STRING2 st;
  AutokeyB2.Layout_Cname;
  doxie.Layout_ref_bdid;
	unsigned4 lookups;
END;