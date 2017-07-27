import Business_Header,doxie_cbrs_raw;
doxie_cbrs.mac_Selection_Declare()

export best_rest(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

srcrec := record
	boolean isRel := false;
	boolean isOAA := false;
	boolean isByC := false;
	boolean isNMV := false;  //name variations
	doxie_cbrs.Layout_BH_Best_String;
	unsigned6 did := 0;
	unsigned2 score := 0;
	//Business_Header.Layout_BH_Best
end;

//***** others at address
relbdids := doxie_cbrs.Associated_Business_bdids();
srcrec markem1(relbdids l) := transform
	self.isOAA := true;
	self.bdid := l.bdid;
	self := [];
end;

wsource1 := project(relbdids(doxie_Cbrs.is_InOAA(relbdids)), markem1(left));


//***** name variations
nmvbdids := doxie_cbrs_raw.name_variations(Include_NameVariations_val, Max_NameVariations_val).records;
srcrec marknmv(nmvbdids l) := transform
	self.isNMV := true;
	self.bdid := l.bdid;
	self := [];
end;

wsourcenmv := project(nmvbdids, marknmv(left));


//***** contact affiliation 
bycbdids := doxie_cbrs.Associated_Business_byContact_bdids(bdids);
srcrec markem2(bycbdids l) := transform
	self.isByC := true;
	self.bdid := l.bdid;
	self.did := l.did;
	self.score := l.score;
	self := [];
end;	

wsource2 := project(bycbdids, markem2(left));

wsource := dedup(sort(wsource1 & wsourcenmv & wsource2, bdid, isByC), bdid);	//this drops the ByC where already 
doxie_cbrs.mac_best_records(wsource, best_info, srcrec)

return best_info;
END;