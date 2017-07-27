import doxie, AutoKeyB2;

export Layout_Phone :=
RECORD
  string7 p7;
  string3 p3;
  AutokeyB2.Layout_Cname;
  STRING2 st;
  doxie.Layout_ref_bdid;
	unsigned4 lookups;
END;