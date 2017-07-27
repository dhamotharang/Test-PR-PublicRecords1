import doxie,autokeyb2;
export Layout_Zip :=
RECORD
  integer4 zip;
  AutokeyB2.Layout_Cname;
  doxie.Layout_ref_bdid;
	unsigned4 lookups;
end;