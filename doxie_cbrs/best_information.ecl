import business_header, Census_Data, doxie, doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

export best_information(dataset(doxie_cbrs.layout_references) bdids,
                        doxie.IDataAccess mod_access
                       ) := FUNCTION

thebest := doxie_cbrs.fn_getBaseRecs(bdids,false);  // filters empty addresses
allr := dedup(sort(thebest,-dt_last_seen,bdid,company_name,fein,phone,prim_name,zip),company_name,ALL);
best_allr := choosen(sort(allr,-dt_last_seen,bdid,company_name,fein,phone,prim_name,zip),1);  //resort just in case

best_rec := RECORD
	string	bdid; // i know, not a string.
	string8 	dt_last_seen := '';
	qstring120 	company_name := '';
	qstring10 	prim_range := '';
	string2   	predir := '';
	qstring28 	prim_name := '';
	qstring4  	addr_suffix := '';
	string2   	postdir := '';
	qstring5  	unit_desig := '';
	qstring8  	sec_range := '';
	qstring25 	city := '';
	string2   	state := '';
	string5	 	zip := '';
	string4		zip4 := '';
	string15	phone := '';  // International numbers
	string10	fein := '';        
	unsigned1 	best_flags := 0;   // also ok not a string
	boolean 	isCurrent := false;
	boolean 	hasBBB := false;
	unsigned1 	level := 0;
	string60 	msaDesc := '';
	string18 	county_name := '';
	string4  	msa := '';
END;


best_rec trim_best(best_allr L) := TRANSFORM
	//SELF.blue_check := false;
	SELF.best_flags := 0;
	SELF.dt_last_seen := (string)L.dt_last_seen;
	SELF.bdid := if(multiBDID,business_header.stored_bdid_val,(string)doxie_cbrs.subject_BDID);	 // FIX
	SELF := L;
END;

best_rec_trimmed := project(best_allr,trim_best(LEFT));

besr := choosen(sort(doxie_cbrs.best_records_prs(bdids,mod_access)(prim_name <> '' and zip <> ''),-best_flags,-dt_last_seen,level,bdid,company_name,fein,phone,prim_name,zip),1);

best_rec trans_best(besr L) := TRANSFORM
	//SELF.blue_check := false;
	SELF.best_flags := 0;
	SELF.dt_last_seen := (string)L.dt_last_seen;
	SELF.bdid := if(multiBDID,business_header.stored_bdid_val,(string)doxie_cbrs.subject_BDID);	 // FIX
	SELF := L;
END;

besr_msa := project(besr,trans_best(LEFT));


best_dca := doxie_cbrs.DCA_records_dayton(if(multiBDID,0,1),bdids);

best_dca_tbl := table(sort(best_dca,root),{root,cnt := count(group)},root);

{best_dca, unsigned cnt} xf_add_cnt(best_dca l, best_dca_tbl r) := transform
	self.cnt := r.cnt;
	self := l;
end;

best_dca_cnt := join(best_dca,best_dca_tbl,left.root = right.root,xf_add_cnt(left,right));

best_dca_rec := choosen(sort(best_dca_cnt,-cnt,level,sub),1);

best_rec add_msa_county(best_dca_rec L, Census_Data.Key_Fips2County R) := TRANSFORM
	SELF.level := (unsigned1)L.level;
	SELF.company_name := L.name;
	SELF.msaDesc := if(L.msa <> '' and L.msa <> '0000', ziplib.MSAToCityState(L.msa), '');
	SELF.county_name := if (L.county <> '', R.county_name, '');
	SELF.msa := if(L.msa <> '0000', L.msa, '');	
	SELF.prim_name := if(L.prim_range = '' and L.predir = '' and 
						 L.prim_name = '' and L.addr_suffix = '' and 
						 L.postdir = '' and L.sec_range = '' and L.unit_desig = '',
						 L.street, L.prim_name);	
	SELF.bdid := if(multiBDID,business_header.stored_bdid_val,(string)doxie_cbrs.subject_BDID);
	SELF := L;
END;

best_dca_rec_trans := JOIN(best_dca_rec,Census_Data.Key_Fips2County,
												  KEYED(LEFT.state = RIGHT.state_code) and
													KEYED(LEFT.county[3..5] = RIGHT.county_fips),
													add_msa_county(LEFT,RIGHT), LEFT OUTER, KEEP (1));
				
// Waterfall
// - highest parent bdid from DCA
// - most complete and recent header record
// - most complete and recent best_records
temp_best_information := MAP(count(best_dca_rec_trans) > 0 => best_dca_rec_trans,
							   count(best_rec_trimmed) > 0 => best_rec_trimmed,
							   besr_msa);
								 
return temp_best_information;
END;