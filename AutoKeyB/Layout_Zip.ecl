import doxie, autokeyb;
export Layout_Zip :=
RECORD
  integer4 zip;
  autokeyb.Layout_Cname;
  doxie.Layout_ref_bdid;
end;