import autokey,doxie,autokeyb;
export Layout_CityStName :=
RECORD
  unsigned4 city_code;
  STRING2 st;
  autokeyb.Layout_Cname;
  doxie.Layout_ref_bdid;
END;