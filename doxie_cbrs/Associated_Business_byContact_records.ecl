import ut,watchdog;
doxie_cbrs.mac_Selection_Declare()

export Associated_Business_byContact_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

abc := doxie_cbrs.best_rest(bdids)(isByC, prim_range <> '' or prim_name <> '');

outrec := record
	abc;
	watchdog.Layout_best.fname;
	watchdog.Layout_best.mname;
	watchdog.Layout_best.lname;
	unsigned2 seq := 0;
	boolean hasBBB := false;
	boolean hasBBB_NM := false;
end;

doxie.mac_best_records(abc,
											 did,
											 outfile,
											 dppa_ok,
											 glb_ok, 
											 ,
											 doxie.DataRestriction.fixed_DRM);

//add name by key
outrec addname(abc l, outfile r) := transform
	self.fname := r.fname;
	self.mname := r.mname;
	self.lname := r.lname;
	self := l;
end;

abcfat_bykey_j := join(abc, outfile,
											left.did = right.did,
										addName(left, right), left outer);

abcfat_bykey := sort(abcfat_bykey_j, lname, fname, mname, company_name, bdid, did);

//add name by contacts (to limit to those shown)
con := doxie_cbrs.contact_records_prs_max(bdids);
outrec addname2(abc l, con r) := transform
	self.fname := r.fname;
	self.mname := r.mname;
	self.lname := r.lname;
	self.seq := r.seq;
	self := l;
end;

abcfat_bycon_j := join(abc, con, left.did = right.did, addname2(left,right), keep(1));
abcfat_bycon := sort(abcfat_bycon_j, seq, did, bdid);

//only use contact route if showing them 
abcfat := if(Include_AssociatedPeople_val,abcfat_bycon,abcfat_bykey);

doxie_cbrs.mac_hasBBB(abcfat, wb, bdids)

return wb;
END;