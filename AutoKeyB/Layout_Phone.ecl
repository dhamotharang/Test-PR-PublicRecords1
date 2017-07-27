import doxie, autokeyb;

export Layout_Phone :=
RECORD
  string7 p7;
  string3 p3;
  autokeyb.Layout_Cname;
  STRING2 st;
  doxie.Layout_ref_bdid;
END;