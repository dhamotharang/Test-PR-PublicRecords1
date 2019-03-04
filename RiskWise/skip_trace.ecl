 
import AutoStandardI, risk_indicators, didville, ut, address, doxie_files, 
census_data, header_slimsort, did_add, suppress, Bankruptcyv2, BankruptcyV3, mdr, Death_Master;

export skip_trace(DATASET(risk_indicators.Layout_Input) indata, unsigned1 dppa, unsigned1 glb,
		string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,string32 appType,
		string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) := function

glb_ok := glb > 0 and glb < 8 or glb=11 or glb=12;
dppa_ok := dppa > 0 and dppa < 8;
fz := '4GZ';
dedup_these := true;
allscores := false;
appends := 'BEST_ALL';
verify := 'BEST_ALL';
thresh_num := 0;

didville.Layout_Did_OutBatch fill_in_batch(indata le) := transform
	self := le;
	self := [];
end;
didprep := PROJECT(indata, fill_in_batch(left));

didville.MAC_DidAppend(didprep,did_results,dedup_these,fz,allscores);

industryClass := AutoStandardI.InterfaceTranslator.industry_class_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.industry_class_val.params));

didville.MAC_BestAppend(did_results, 
											  appends, 
												verify, 
												thresh_num, 
												glb_ok, 
												best_data, 
												false,
												DataRestriction,
												,
												,
												,
												,
												appType,
												,
												industryClass);

// replace layout input address fields with best address data
Layout_SkipTrace add_best_address(indata le, best_data rt) := transform
	clean_best := Risk_Indicators.MOD_AddressClean.clean_addr(rt.best_Addr1, rt.best_city, rt.best_state, rt.best_zip+rt.best_zip4);

	addrtype := map(clean_best='' => 'X',
				 clean_best[1..10]=le.prim_range and clean_best[13..40]=le.prim_name and clean_best[117..121]=le.z5 => 'C',
				 'U');
				 
	self.addr_type_a := addrtype;
	
	SELF.in_streetAddress := if(addrtype='X', le.in_streetAddress, rt.best_Addr1);
	SELF.in_city := if(addrtype='X', le.in_city, rt.best_city);
	SELF.in_state := if(addrtype='X', le.in_state, rt.best_state);
	SELF.in_zipCode := if(addrtype='X', le.in_zipcode, rt.best_zip);
	self.prim_range := if(addrtype='X', le.prim_range, clean_best[1..10]);
	self.predir := if(addrtype='X', le.predir, clean_best[11..12]);
	self.prim_name := if(addrtype='X', le.prim_name, clean_best[13..40]);
	self.addr_suffix := if(addrtype='X', le.addr_suffix, clean_best[41..44]);
	self.postdir := if(addrtype='X', le.postdir, clean_best[45..46]);
	self.unit_desig := if(addrtype='X', le.unit_desig, clean_best[47..56]);
	self.sec_range := if(addrtype='X', le.sec_range, clean_best[57..64]);
	self.p_city_name := if(addrtype='X', le.p_city_name, clean_best[90..114]);
	self.st := if(addrtype='X', le.st, clean_best[115..116]);
	self.z5 := if(addrtype='X', le.z5, clean_best[117..121]);
	self.zip4 := if(addrtype='X', le.zip4, clean_best[122..125]);
	self.lat := if(addrtype='X', le.lat, clean_best[146..155]);
	self.long := if(addrtype='X', le.long, clean_best[156..166]);
	self.addr_type := if(addrtype='X', le.addr_type, clean_best[139]);
	self.addr_status := if(addrtype='X', le.addr_status, clean_best[179..182]);
	self.county := if(addrtype='X', le.county, clean_best[143..145]);
	self.geo_blk := if(addrtype='X', le.geo_blk, clean_best[171..177]);	
	self := le;
	self := [];
end;

best_input := join(indata, best_data, left.seq=right.seq, add_best_address(left,right));

// get the phone listing information with the best_address as input
	dirsaddr := Riskwise.getDirsByAddr(project(best_input, transform(risk_indicators.Layouts.layout_input_plus_overrides, self := left)));

	Layout_SkipTrace phoneByAddress(best_input le, dirsaddr rt) := transform
		self.phone10 := if(le.addr_type_a='X', le.phone10, rt.phone10);
		self.phone_type_a := map(le.addr_type_a='X' => '',
							rt.phone10='' => '',
							(risk_indicators.LnameScore(le.lname, rt.name_last) BETWEEN 80 AND 100) and rt.current_flag=true => 'A',
							rt.current_flag=true => 'B',
							rt.current_flag=false => 'C',
							'');
		self := le;
	end;

	phones := join(best_input, dirsaddr,
					  left.prim_name<>'' AND left.z5<>'' AND
					  left.prim_name=right.prim_name and left.st=right.st and 
					  left.z5=right.z5 and left.prim_range=right.prim_range and left.sec_range=right.sec_range,
					  phoneByAddress(left,right),left outer, many lookup,
					  ATMOST(left.prim_name=right.prim_name and left.st=right.st and 
					  left.z5=right.z5 and left.prim_range=right.prim_range and left.sec_range=right.sec_range,RiskWise.max_atmost),
					  keep(100));

	Layout_SkipTrace roll_phones(phones le, phones rt) := transform
		self := if(le.phone_type_a='', rt, if(le.phone_type_a < rt.phone_type_a, le, rt));
	end;

	s_phone := group(sort(phones, seq, phone_type_a), seq);
	best_phone := rollup(s_phone, true, roll_phones(left,right));


// append any bankruptcy information to the best_phone recordset
	bans_layout := record
		unsigned4 seq := 0;
		string50   TMSID := '';
		string10 seq_number := '';
		string5 court_code := '';
		string7 case_number := '';
		string20 debtor_fname := '';
		string20 debtor_mname := '';
		string20 debtor_lname := '';
		string150  debtor_company := '';
		string2 st := '';
		string30 county_name := '';
		string5 county := '';
		string2 debtor_type := '';
		string2 chapter := '';
		string8 date_filed := '';
		string8 disposed_date := '';
		string8 converted_date := '';
		string8 case_closing_date := '';
		string35 disposition := '';
		string1 filing_type := '';
		string1 filer_type := '';	
		string1 match_flag := '';
	end;

// for now, BankruptcyV3.key_bankruptcyv3_ssn and DID keys aren't being built, use the V2 keys
// bans_ssn := BankruptcyV3.key_bankruptcyv3_ssn();
// bans_did := BankruptcyV3.key_bankruptcyv3_did();
bans_ssn := BankruptcyV3.key_bankruptcyV3_ssn();
bans_did := BankruptcyV3.key_bankruptcyV3_did();

	bans_layout get_bans_by_ssn(best_data le, recordof(bans_ssn) rt) := transform
		self.seq := le.seq;
		self.match_flag := '1';
		self.tmsid := rt.tmsid;
		// hang on to the best data fname and lname for scoring when matching to full search file
		self.debtor_fname := le.fname;
		self.debtor_lname := le.lname;
		self := [];		
	end;


	// search by ssn and did to get TMSID, add flag to tell which one hit
	// dedup by tmsid, making hit on ssn higher priority
	bk_by_ssn := join(best_data, bans_ssn, 
				left.ssn!='' and keyed(right.ssn=left.ssn),
				get_bans_by_ssn(left,right), atmost(riskwise.max_atmost), keep(50));
	
	bans_layout get_bans_by_did(best_data le, recordof(bans_did) rt) := transform
		self.seq := le.seq;
		self.match_flag := '2';
		self.tmsid := rt.tmsid;
		// hang on to the best data fname and lname for scoring when matching to full search file
		self.debtor_fname := le.fname;
		self.debtor_lname := le.lname;
		self := [];		
	end;	

	bk_by_did := join(best_data, bans_did,
				left.did!=0 and 
				keyed(left.did=right.did),
				get_bans_by_did(left,right), atmost(riskwise.max_atmost), keep(50));			
	
	bk_tmsids1  := ungroup(bk_by_ssn + bk_by_did);
	bk_tmsids := dedup(sort(bk_tmsids1, seq, tmsid, match_flag), seq, tmsid);

	
	bans_layout get_bans_by_tmsid(bk_tmsids le, recordof(BankruptcyV3.key_bankruptcyv3_search_full_bip()) rt) := transform
		fscore := risk_indicators.FnameScore(le.debtor_fname, rt.fname);
		lscore := risk_indicators.LnameScore(le.debtor_lname, rt.lname);
		good := (fscore between 80 and 100) and (lscore between 80 and 100);
		self.seq := le.seq;
		self.match_flag := if(good, le.match_flag, skip);
		self.county := rt.county[3..5];
		self.debtor_fname := rt.fname;
		self.debtor_mname := rt.mname;
		self.debtor_lname := rt.lname;
		
		self.chapter := rt.chapter;
		self.date_filed := rt.date_filed;
		self.disposition := rt.disposition;
		self.filing_type := rt.filing_type;
		
		self := rt;		
	end;	

	bk_search := join(bk_tmsids, BankruptcyV3.key_bankruptcyv3_search_full_bip(),
				left.tmsid!='' and 
				keyed(left.tmsid=right.tmsid) and
				right.name_type='D',  // only care about bankruptcy records which are the debtor
				get_bans_by_tmsid(left,right));
		
	
	//Populate county_name.
	census_data.MAC_Fips2County_Keyed(bk_search,st,county,county_name,bk_search_recs);
	// output(bk_by_ssn, named('bk_by_ssn'));
	// output(bk_by_did, named('bk_by_did'));

	bans_layout get_more_bankrupt(bans_layout le, recordof(BankruptcyV3.key_bankruptcyv3_main_full()) rt) := transform
		// self.chapter := rt.chapter;
		// self.date_filed := rt.date_filed;
		// self.disposition := rt.disposition;
		// self.filing_type := rt.orig_filing_type;
		self.filer_type := rt.filer_type;
		self := le;
	end;

	full_bankrupt := join(bk_search_recs, BankruptcyV3.key_bankruptcyv3_main_full(),
				left.tmsid<>'' and
				keyed(left.tmsid = right.tmsid),
				get_more_bankrupt(LEFT,RIGHT),
				ATMOST(RiskWise.max_atmost),keep(50));
				
	s_bankrupt := group(sort(full_bankrupt, seq, -date_filed, match_flag), seq);
				
	bans_layout roll_bankrupt(bans_layout le, bans_layout rt) := transform
		chooser1 := map(le.date_filed > rt.date_filed => true,
										le.date_filed = rt.date_filed and le.match_flag <= rt.match_flag => true,
										false);
		self := if(chooser1, le, rt);
	end;

	rolled_bankrupt := rollup(s_bankrupt, true, roll_bankrupt(left,right));
		
	Layout_SkipTrace add_bankrupt(Layout_SkipTrace le, bans_layout rt) := transform
		self.bansmatchflag := if(rt.match_flag='', '0', rt.match_flag);
		self.banscasenum := rt.case_number;
		self.bansprcode := map  (rt.chapter='7' => '52',
							rt.chapter='11'=> '53',
							rt.chapter='12'=> '54',
							rt.chapter='13'=> '06',
							'');
		
		self.bansdispcode := map(StringLib.StringToLowerCase(rt.disposition) in ['discharged', 'discharge granted'] => '20',
							StringLib.StringToLowerCase(rt.disposition) in ['case dismissed', 'dismissed'] => '15',
							rt.disposed_date='' and rt.converted_date!='' => '30',
							rt.disposed_date!='' => '99', 
							rt.disposed_date='' and rt.converted_date='' and rt.case_closing_date='' and rt.case_number!='' => '02',
							'');						
		self.bansdatefiled := rt.date_filed;
		self.bansfirst := rt.debtor_fname;
		self.bansmiddle := rt.debtor_mname;
		self.banslast := map(rt.debtor_lname!='' => rt.debtor_lname,
						 rt.debtor_lname='' and rt.debtor_company!='' => rt.debtor_company,
						 '');
		self.banscnty := rt.county_name;
		self.bansecoaflag := map(rt.filing_type='I' and rt.filer_type='I' => 'S',
							rt.filing_type='I' and rt.filer_type='J' => 'M',
							rt.filing_type='B' => 'B',
							'');
		self := le;
	end;

	bankrupt_added := join(best_phone, rolled_bankrupt, left.seq=right.seq, add_bankrupt(left, right), left outer);


// append deceased information to the bankrupt_added recordset
	Layout_SkipTrace add_deceased(Layout_SkipTrace le, risk_indicators.key_ssn_table_v4_2 ri) := transform										
		iid_constants := risk_indicators.iid_constants;

		// determine which section of the table is permitted for use based on the data restriction mask
		header_version := map(DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse and
													DataRestriction[iid_constants.posEquifaxRestriction]=iid_constants.sFalse and
													DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse=> ri.combo,
													DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse => ri.en,
													DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse => ri.tn,
													ri.eq);  // default to the EQ version		
													
		// eq section is the SSA death records only. (what used to be known as Death v2)
		// EN and TN bureau records are additional in their respective sections, use the date restriction 
		bureau_deceased_records_permitted := DataRestriction[iid_constants.posBureauDeceasedRestriction]=iid_constants.sFalse;
		ri_isDeceased := if(bureau_deceased_records_permitted, header_version.isDeceased, ri.eq.isDeceased);
		ri_dt_first_deceased := if(bureau_deceased_records_permitted, header_version.dt_first_deceased , ri.eq.dt_first_deceased );
		ri_decs_dob := if(bureau_deceased_records_permitted, header_version.decs_dob , ri.eq.decs_dob );
		ri_decs_first := if(bureau_deceased_records_permitted, header_version.decs_first , ri.eq.decs_first );
		ri_decs_last := if(bureau_deceased_records_permitted, header_version.decs_last , ri.eq.decs_last );
		ri_decs_zip_lastres := if(bureau_deceased_records_permitted, header_version.decs_zip_lastres , ri.eq.decs_zip_lastres );
		ri_decs_zip_lastpayment := if(bureau_deceased_records_permitted, header_version.decs_zip_lastpayment , ri.eq.decs_zip_lastpayment );
	
		dead := ri_isDeceased AND NOT Suppress.dateCorrect.do(le.ssn).needed;
		self.decsflag := if(dead, '1', '0');				
		self.decsdob := if(dead, if(ri_decs_dob=0,'',(string)ri_decs_dob), '');
		self.decszip := if(dead, ri_decs_zip_lastres, '');
		self.decszip2 := if(dead, ri_decs_zip_lastpayment, '');
		self.decslast := if(dead, ri_decs_last, '');
		self.decsfirst := if(dead, ri_decs_first, '');
		self.decsdod := if(dead, if(ri_decs_dob=0, '',(string)ri_dt_first_deceased), '');
		self := le;
	end;
				
	deceased_added := join(bankrupt_added,risk_indicators.key_ssn_table_v4_2,
						keyed(left.ssn=right.ssn),
						add_deceased(left,right), left outer, keep(1));


deathSSNKey := Death_Master.key_ssn_ssa(false);

Layout_SkipTrace getDeathSSN (Layout_SkipTrace le, deathSSNKey ri) := transform
	ssnDeathHit := trim(ri.ssn)<>'';
	full_history_date := risk_indicators.iid_constants.full_history_date(le.historydate);
	pre_history := (string)ri.dod8 < full_history_date;

	dead := ssnDeathHit and pre_history;
	self.decsflag := if(dead, '1', le.decsflag);		
	self.decsdob := if(dead, ri.dob8, le.decsdob);
	self.decszip := if(dead, ri.zip_lastres, le.decszip);
	self.decszip2 := if(dead, ri.zip_lastpayment, le.decszip2);
	self.decslast := if(dead, ri.lname, le.decslast);
	self.decsfirst := if(dead, ri.fname, le.decsfirst);
	self.decsdod := if(dead, ri.dod8, le.decsdod);
		
	self := le;
END;		    

deceased_added2 := join (deceased_added, deathSSNKey,
                   left.ssn!='' and keyed(left.ssn=right.ssn) and
									 (right.src <> MDR.sourceTools.src_Death_Restricted or Risk_Indicators.iid_constants.deathSSA_ok(DataPermission)), 
                   getDeathSSN(left,right),left outer, ATMOST(keyed(left.ssn=right.ssn),500), keep(1));

// output(best_data, named('best_data'));
// output(best_input, named('best_input'));
// output(dirsaddr, named('dirsaddr'));
// output(phones, named('phones'));
// output(bk_search, named('bk_search'));
// output(full_bankrupt, named('full_bankrupt'));
// output(rolled_bankrupt, named('rolled_bankrupt'));
// output(bankrupt_added, named('bankrupt_added'));
// output(deceased_added, named('deceased_added'));
// output(deceased_added2, named('deceased_added2'));
return deceased_added2;

end;

