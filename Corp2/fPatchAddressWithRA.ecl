import business_header,ut;

export fPatchAddressWithRA(dataset(Layout_Corporate_Direct_Corp_AID) crecs) :=
FUNCTION

addrcount := 20;
//*** corp ra addresses to avoid
cslim := table(crecs(corp_ra_zip5 <> ''), {cn := (datalib.companyclean(stringlib.stringfilterout(corp_legal_name, '\r')))[1..40], corp_ra_prim_range, corp_ra_prim_name, corp_ra_sec_range, corp_ra_zip5});
cddpd := dedup(cslim, whole record, all);


crec := record
	cddpd.corp_ra_prim_range;
	cddpd.corp_ra_prim_name;
	cddpd.corp_ra_sec_range;
	cddpd.corp_ra_zip5;
	counted := count(group)
end;

ct := table(cddpd, crec, corp_ra_prim_range, corp_ra_prim_name, corp_ra_sec_range, corp_ra_zip5);
caddr := ct(counted >= addrcount);

//*** bh addresses to avoid
bhin := business_header.File_Business_Header(prim_name <> '' and (string5)zip <> '' and company_name <> '');
bhslim := table(bhin, {bdid, prim_range, prim_name, sec_range, zip});
bhddp := dedup(bhslim, whole record, all);

bhrec := record
	bhddp.prim_range;
	bhddp.prim_name;
	bhddp.sec_range;
	bhddp.zip;
	counted := count(group)
end;

bht := table(bhddp, bhrec, prim_range, prim_name, sec_Range, zip);
bhaddr := bht(counted >= addrcount);

//*** pull those addresses out of the bh file
addrec := record
	bhin.prim_range;
	bhin.prim_name;
	bhin.sec_range;
	bhin.zip;
end;

addrec makec(caddr l) := transform
	self.prim_range := l.corp_ra_prim_range;
	self.prim_name := l.corp_ra_prim_name;
	self.sec_range := l.corp_ra_sec_range;
	self.zip := (integer)l.corp_ra_zip5;
end;

cready := project(caddr, makec(left));

addrec makeb(bhaddr l) := transform
	self := l;
end;

bhready := project(bhaddr, makeb(left));

bhin keepbh(bhin l) := transform
	self := l;
end;

bhsafe := join(bhin, bhready + cready,
							 left.prim_range = right.prim_range and
							 left.prim_name = right.prim_name and
							 left.sec_range = right.sec_range and
							 left.zip = right.zip,
							 keepbh(left), left only);
							 
//*** identify corp recs that need checking
try := crecs.corp_addr1_zip5 = '' and crecs.corp_addr2_zip5 = '' and  //has no reg address
	  crecs.corp_ra_zip5 <> '';								//has an ra address
	  
c := crecs(try);	  	 
	 
//*** try to find the existing name addr combination in the safe bh recs
bh := dedup(table(bhsafe, {ccn := ut.CleanCompany(company_name), prim_range, prim_name, sec_range, zip}) 
		  , all);

c chooseaddr(c l, bh r) := transform
	hit := r.ccn <> '';
	
	self.corp_addr1_prim_range := if(hit, l.corp_ra_prim_range, l.corp_addr1_prim_range);
	self.corp_addr1_predir := if(hit, l.corp_ra_predir, l.corp_addr1_predir);
	self.corp_addr1_prim_name := if(hit, l.corp_ra_prim_name, l.corp_addr1_prim_name);
	self.corp_addr1_addr_suffix := if(hit, l.corp_ra_addr_suffix, l.corp_addr1_addr_suffix);
	self.corp_addr1_postdir := if(hit, l.corp_ra_postdir, l.corp_addr1_postdir);
	self.corp_addr1_unit_desig := if(hit, l.corp_ra_unit_desig, l.corp_addr1_unit_desig);
	self.corp_addr1_sec_range := if(hit, l.corp_ra_sec_range, l.corp_addr1_sec_range);
	self.corp_addr1_p_city_name := if(hit, l.corp_ra_p_city_name, l.corp_addr1_p_city_name);
	self.corp_addr1_state := if(hit, l.corp_ra_state, l.corp_addr1_state);
	self.corp_addr1_zip5 := if(hit, l.corp_ra_zip5, l.corp_addr1_zip5);
	self.corp_addr1_zip4 := if(hit, l.corp_ra_zip4, l.corp_addr1_zip4);
	self.corp_addr1_county := if(hit, l.corp_ra_county, l.corp_addr1_county);
	self.corp_addr1_msa := if(hit, l.corp_ra_msa, l.corp_addr1_msa);
	self.corp_addr1_geo_lat := if(hit, l.corp_ra_geo_lat, l.corp_addr1_geo_lat);
	self.corp_addr1_geo_long := if(hit, l.corp_ra_geo_long, l.corp_addr1_geo_long);
	self := l;
end;
	


j := join(c, bh, 
		ut.CleanCompany(Stringlib.StringToUpperCase(left.corp_legal_name)) = right.ccn and
		left.corp_ra_prim_range = right.prim_range and
		left.corp_ra_prim_name = right.prim_name and
		left.corp_ra_sec_range = right.sec_range and
		left.corp_ra_zip5 = (string5)right.zip
		, chooseaddr(left, right), left outer, hash);
		
return j + crecs(not try);

END;