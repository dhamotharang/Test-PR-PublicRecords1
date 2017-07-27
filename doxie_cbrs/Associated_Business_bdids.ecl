import doxie, business_header;
doxie_cbrs.MAC_Selection_Declare()

allem := 	doxie_cbrs.getRelatives(doxie_cbrs.subject_BDID)
		(Include_AssociatedBusinesses_val or Include_NameVariations_val); 	//filter
		
//for supergroup stuff, limit these
allem limitor(allem l) := transform
	self := l;
end;



lmtd := join(allem, supergroup_ds, left.bdid = right.bdid, limitor(left));


export Associated_Business_bdids(boolean only_Supergroup = false) := 
	if(only_Supergroup, lmtd, allem);