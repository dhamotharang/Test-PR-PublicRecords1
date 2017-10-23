import did_add,ut,census_data,suppress,DriversV2_Services,doxie_crs,
  PersonSearch_Services,header,Standard, Advo,Gateway,Royalty,AutoStandardI;

export rollup_presentation(DATASET(layout_presentation) presRecs,
                           boolean allow_wildcard = false,
													 boolean addressOnlySort = false,
													 boolean skipRelativePhoneAppend = false) := FUNCTION

	MAC_Header_Field_Declare()
	high_valid_ssn := 100; // default high value; lowest is best
	high_tnt := 100; // default high value; lowest is best
	high_penalt := 100; // default high value; lowest is best
	srchedAddrThold := 4;
	Gateways := Gateway.Configuration.Get();
  includeRTP := false;
	boolean include_hri := false : stored('IncludeHRI');
	boolean include_cds := false : stored('IncludeAddressCDSDetails');
	boolean include_dlinfo := false : stored('IncludeDLInfo');
	boolean	include_paw := false : stored('IncludePeopleAtWork');
	boolean include_relative_names_value := false : STORED('IncludeRelativeNames');
	unsigned1 maxHriPer_value := 10 : stored('MaxHriPer');

	boolean negate_true_defaults := false : STORED('ECL_NegateTrueDefaults'); // internal ECL use only
	boolean return_waf := true : STORED('ReturnAlsoFound');
	boolean include_wealsofound := return_waf AND ~negate_true_defaults;
	boolean includeBankruptcyCount := false : stored('IncludeBankruptcyCount');
	boolean includeExpandedPhonePlusSearch := false : stored('IncludeExpandedPhonePlusSearch');
	boolean includeLastResort := false : stored('IncludeLastResort');
	boolean household := false : stored('Household');
	boolean includeHouseHoldOnly := false : stored('IncludeHouseHoldOnly');
	boolean use_tg := includeExpandedPhonePlusSearch and doxie.DataPermission.use_targus;
	boolean use_LR := includeExpandedPhonePlusSearch and doxie.DataPermission.Use_LastResort and includeLastResort;

	// both default to and set the upper bound on addressLimit to 15
	unsigned al := 15 : stored('AddressLimit');
	unsigned addrLim := IF(al > 99, 99, al); //originally this was at 15 ..changed for IRB to 99

  // Added for the FDN project, 1 new input option & 3 required input fields
  boolean IncludeFraudDefenseNetwork := false : stored('IncludeFraudDefenseNetwork');
  unsigned6 in_FDN_gcid     := 0 : stored('GlobalCompanyId');
  unsigned2 in_FDN_indtype  := 0 : stored('IndustryType');
  unsigned6 in_FDN_prodcode := 0 : stored('ProductCode');

	// need search criteria to include at least a street/city/st/or zip to 
	// even look for a search addr match
	srchedAddrMatch(Layout_HeaderFileSearch l) := 
		IF(pname_value = '' and city_value = '' and state_value = '' and zip_value = [], false, 
			doxie.FN_Tra_Penalty_Addr(l.predir,l.prim_range,l.prim_name,l.suffix,l.postdir,l.sec_range,
									l.city_name,l.st,l.zip, allow_wildcard) < srchedAddrThold);

	srchedPhoneMatch(Layout_HeaderFileSearch l) :=
		phone_value <> '' and (l.listed_phone=phone_value or l.listed_phone[4..10]=phone_value);

	with_risk := doxie.base_presentation(presRecs);

	tasrtd := pull(sort(with_risk,did))((INTEGER)did<>0);
	tagrp := group(tasrtd,did);

	// ******************** Format those records that have no DID ********************** 
	doxie.Layout_Rollup.NameRec noDidNames(Layout_HeaderFileSearch le) := TRANSFORM
		// if no fname/mname/lname, use listed_name as last name to pick up business names
		SELF.fname := le.fname;
		SELF.mname := le.mname;
		SELF.lname := if (le.fname <> '' OR le.mname <> '' OR le.lname <> '', le.lname, le.listed_name);
		SELF := le;
	END;

	doxie.Layout_Rollup.AddrRec noDidAddress(Layout_HeaderFileSearch le) := TRANSFORM
		SELF.phoneRecs := PROJECT(le.phones,TRANSFORM(doxie.Layout_Rollup.PhoneRec,SELF := LEFT, SELF.phone := LEFT.phone10, SELF.hri_phone := []));
		SELF.address_cds := [];
		SELF := le;
	END;

	nondidHBR := doxie.header_base_rollup(with_risk((INTEGER)did=0));
	
	doxie.Layout_Rollup.KeyRec nondidFormat(nondidHBR le) := TRANSFORM
		SELF.nameRecs := PROJECT(le,noDidNames(LEFT));
		SELF.AddrRecs := PROJECT(le,noDidAddress(LEFT));											
		SELF.bestSrchedAddrTntScore := IF(srchedAddrMatch(le) or srchedPhoneMatch(le), tnt_score(le.tnt), high_tnt);
		SELF.bestSrchedAddrDate := IF(srchedAddrMatch(le) or srchedPhoneMatch(le), MAX(le.first_seen, le.last_seen),0);
		SELF.bestTntScore := tnt_score(le.tnt);
		SELF.ssnRecs := PROJECT(le,TRANSFORM(doxie.Layout_Rollup.SsnRec,SELF := LEFT));
		SELF.dobRecs := if(le.dob > 0,DATASET(PROJECT(le,TRANSFORM(doxie.Layout_Rollup.DobRec,SELF := LEFT))));
		SELF.dodRecs := if(le.dod > 0 or le.deceased ='Y',DATASET(PROJECT(le,TRANSFORM(doxie.Layout_Rollup.DodRec,SELF := LEFT))));
		SELF.rids := dataset([doxie.makeRidRec(le.rid, le.src, if(le.rid <> '', 1, 0))]);
		SELF.maxRid := HASH32(le.rid);
		SELF.maxDate := 0;
		SELF.did := '';
		SELF.DLRecs := [];
		SELF.PAW := [];
		SELF.PAW_V2 := [];
		SELF := le;
		SELF.WorkPhones := [];
		SELF.RelativePhones := [];
		SELF.RelativeNames := [];
	END;
	nondidRecs := PROJECT(nondidHBR, nondidFormat(LEFT));

	//******************** Format those records that do have a DID ********************** 

	names := doxie.rollup_components(tagrp).name;
	addresses := doxie.rollup_components(tagrp).addresses(pname_value, city_value, state_value, phone_value, zip_value, include_cds);
	dobs := doxie.rollup_components(tagrp).dob;
	dods := doxie.rollup_components(tagrp).dod;
	ssns := doxie.rollup_components(tagrp).ssn(ssn_value);

	// keep the highest rid to provide deterministic result order
	dids_rids := GROUP(SORT(tasrtd, did, -(unsigned6)rid),did);
	maxrids := DEDUP(dids_rids, true, keep(1));

	// ******************** Pull components into the parent and keep first N ********************* 
	doxie.Layout_Rollup.KeyRec seedDids(maxrids l) := TRANSFORM
		SELF.did := l.did;
		SELF.penalt := high_penalt;
		SELF.num_compares := 0;
		SELF.bestSrchedAddrTntScore := high_tnt;
		SELF.bestSrchedAddrDate := 0;
		SELF.bestSrchedValidSSNScore := high_valid_ssn;
		SELF.bestTntScore := high_tnt;
		SELF.nameRecs := [];
		SELF.addrRecs := [];
		SELF.ssnRecs := [];
		SELF.dobRecs := [];
		SELF.dodRecs := [];
		SELF.rids := [];
		SELF.maxRid := (unsigned6) l.rid;
		SELF.maxDate := 0;
		SELF.DLRecs := [];
		SELF.PAW := [];
		SELF.PAW_V2 := [];
		SELF := l;
		SELF.WorkPhones := [];
		SELF.RelativePhones := [];
		SELF.RelativeNames := [];
	END;

	KeyRecs := PROJECT(ungroup(maxrids), seedDids(LEFT));

	KeyRecs_paw := if(include_paw,fn_PeopleAtWork(KeyRecs),KeyRecs);

	DriversV2_Services.layouts.did MyDidTransform(KeyRecs inrec) := Transform
		Self.did :=(integer)inrec.did;
	End;


	MyDLDids := Project(KeyRecs_paw,MyDidTransform(left));
	MyDLSeqs := DriversV2_Services.DLRaw.get_seq_from_dids(MyDLDids);
	MyDLRaw := DriversV2_Services.DLRaw.narrow_view.by_seq(MyDLSeqs);
	
	DriversV2_Services.layouts.result_narrow rollDLs(DriversV2_Services.layouts.result_narrow l,dataset(DriversV2_Services.layouts.result_narrow) allrows) := TRANSFORM
		self.lic_issue_date := min(allrows(dl_number=l.dl_number,orig_state=l.orig_state,lic_issue_date>0),lic_issue_date);
		self.expiration_date := max(allrows(dl_number=l.dl_number,orig_state=l.orig_state,expiration_date>0),expiration_date);
		SELF := l;
	END;
	MyDLResults := sort(rollup(group(sort(project(MyDLRaw,DriversV2_Services.layouts.result_narrow),dl_number,orig_state),dl_number,orig_state),group,rollDLs(left,rows(left))),history_name);
	PersonSearch_Services.Layouts.DlRecPlusDid slimDLs(DriversV2_Services.layouts.result_narrow l) := TRANSFORM
		self.did := (string)l.did;
		self.dl_num := l.dl_number;
		self.dl_st := l.orig_state;
		self.earliest_lic_issue_date := l.lic_issue_date;
		self.latest_expiration_date := l.expiration_date;
	END;
	MyDLResultsSlim := project(MyDLResults, slimDLs(left));
	PersonSearch_Services.Layouts.DlRecDataset makeChildDs(PersonSearch_Services.Layouts.DlRecPlusDid l, dataset(PersonSearch_Services.Layouts.DlRecPlusDid) r) := transform
		self.did := (string)intformat ((integer) l.did, 12, 1);
		self.dls := project(r(did=l.did),PersonSearch_Services.layouts.DlRec);
	end;
	MyDLDataset := rollup(group(MyDLResultsSlim,did),group,makechildDs(left, rows(left)));
	rna_ok := ut.dppa_ok(dppa_purpose,header.constants.checkRNA);
	doxie.Layout_Rollup.KeyRec MyDLTransform(doxie.Layout_Rollup.KeyRec inRec, PersonSearch_Services.Layouts.DlRecDataset dlInfoDetail) := TRANSFORM
		SELF.dlrecs := if(~inRec.includedbyhhid or rna_ok,dlInfoDetail.dls);
		SELF := inRec;
	END;

	MyDLJoin := join(KeyRecs_paw,MyDLDataset,(integer)LEFT.did=(integer)RIGHT.did,MyDLTransform(left,right),Left outer, keep(1),limit(0));

	KeyRecs_Final := if(include_dlinfo,MyDLJoin,KeyRecs_paw);

	doxie.Layout_Rollup.KeyRec denormNames(doxie.Layout_Rollup.KeyRec L, doxie.Layout_Rollup.NameRecDid R) := TRANSFORM
		SELF.nameRecs := L.nameRecs + R.n;
		SELF.penalt := MIN(L.penalt, R.penalt);
		SELF.num_compares := 0;	
		SELF := L;
	END;

	doxie.Layout_Rollup.KeyRec denormAddrs(doxie.Layout_Rollup.KeyRec L, doxie.Layout_Rollup.AddrRecDid R, INTEGER i) := TRANSFORM
		SELF.addrs_suppressed := L.addrs_suppressed OR i > addrLim;
		SELF.addrRecs := L.addrRecs + IF(~SELF.addrs_suppressed,DATASET(R.a));
		SELF.penalt := MIN(L.penalt, R.penalt);
		SELF.num_compares := 0;	
		SELF.bestSrchedAddrTntScore := IF(L.bestSrchedAddrTntScore < R.bestSrchedAddrTntScore, L.bestSrchedAddrTntScore, R.bestSrchedAddrTntScore);
		SELF.bestSrchedAddrDate := MAX(L.bestSrchedAddrDate, R.bestSrchedAddrDate);
		SELF.bestTntScore := IF(L.bestTntScore < R.bestTntScore, L.bestTntScore, R.bestTntScore);
		SELF := L;
	END;

	doxie.Layout_Rollup.KeyRec denormSsns(doxie.Layout_Rollup.KeyRec L, doxie.Layout_Rollup.SsnRecDid R) := TRANSFORM
		SELF.bestSrchedValidSSNScore := IF(L.bestSrchedValidSSNScore < R.bestSrchedValidSSNScore, L.bestSrchedValidSSNScore, R.bestSrchedValidSSNScore);
		SELF.ssnRecs := L.ssnRecs + R.s;
		SELF.penalt := MIN(L.penalt, R.penalt);
		SELF.num_compares := 0;	
		SELF := L;
	END;

	doxie.Layout_Rollup.KeyRec denormDobs(doxie.Layout_Rollup.KeyRec L, doxie.Layout_Rollup.DobRecDid R) := TRANSFORM
		SELF.dobRecs := L.dobRecs + R.d;
		SELF.penalt := MIN(L.penalt, R.penalt);
		SELF.num_compares := 0;	
		SELF := L;
	END;

	doxie.Layout_Rollup.KeyRec denormDods(doxie.Layout_Rollup.KeyRec L, doxie.Layout_Rollup.DodRecDid R) := TRANSFORM
		SELF.dodRecs := L.dodRecs + R.d;
		SELF.penalt := MIN(L.penalt, R.penalt);
		SELF.num_compares := 0;	
		SELF := L;
	END;

	// generally, we have limited the number of records per did in the rollup_components module
	outRecs1 := DENORMALIZE(KeyRecs_Final, names, LEFT.did = RIGHT.did, denormNames(LEFT,RIGHT));
	// here, the counter keeps the datasets under the limit (see transforms above)
	outRecs2 := DENORMALIZE(outRecs1, addresses, LEFT.did = RIGHT.did, denormAddrs(LEFT,RIGHT,COUNTER));
	outRecs3_orig := DENORMALIZE(outRecs2, ssns, LEFT.did = RIGHT.did, denormSsns(LEFT,RIGHT));
	outRecs3 := if(reduced_data_value, outRecs2,outRecs3_orig);
	outRecs4 := DENORMALIZE(outRecs3, dobs, LEFT.did = RIGHT.did, denormDobs(LEFT,RIGHT));
	outRecs5_orig := DENORMALIZE(outRecs4, dods, LEFT.did = RIGHT.did, denormDods(LEFT,RIGHT));
	outRecs5 := if(reduced_data_value, outRecs4,outRecs5_orig);

	doxie.Layout_Rollup.KeyRec reSort(doxie.Layout_Rollup.KeyRec L) := TRANSFORM
		// get the latest of all dates
		maxFirst := MAX(L.addrRecs,first_seen);
		maxLast := MAX(L.addrRecs,last_seen);
		SELF.maxDate := MAX(maxFirst,maxLast);
		SELF := L;
	END;

	outRecs6 := (PROJECT(outRecs5, reSort(LEFT))+nondidRecs)(penalt<score_threshold_value or all_dids);
	//outRecs6 := (PROJECT(outRecs5, reSort(LEFT)))(penalt<score_threshold_value or all_dids);

	// for addr only queries (like neighbors), the sort should be by prim_range ascending first
	ta1_addr_srtd := sort(outRecs6, addrRecs[1].prim_range, -addrRecs[1].last_seen, maxRid);

	// sort entries with DID before those without (after searched SSN and searched address TNT)
	ta1_srtd := sort(outRecs6, includedByHHID, penalt,bestSrchedValidSSNScore, bestSrchedAddrTntScore, -((unsigned6)did <> 0),
            -bestSrchedAddrDate, bestTntScore,-maxDate,-head_cnt,maxRid);

	ta1_pre := if (addressOnlySort, ta1_addr_srtd, ta1_srtd);

	ta1 := GLOBAL(IF(reduced_data_value, doxie.us_search(penalt<score_threshold_value or all_dids), ta1_pre));

	tempmod := module(project(AutoStandardI.GlobalModule(),doxie.expandedPhones.searchParams, OPT))
		EXPORT STRING14  DID := '';
		EXPORT STRING11  SSN := '';
		EXPORT BOOLEAN	 IncludeDeadContacts := true; //We wanted Deceased Subjects when returning additional data from the PhonesPlus database
	  EXPORT STRING  DataPermissionMask := AutoStandardI.Constants.DataPermissionMask_default : STORED('DataPermissionMask'); // Chgd for FDN Project
		EXPORT BOOLEAN   IncludeLastResort := false : STORED('IncludeLastResort');		
		EXPORT STRING    _TransactionId := '' : STORED('_TransactionId');
	end;

	expPhonesPlusMod := doxie.mod_expandedPhoneRecords(tempmod, Gateways);
	phonePlusRawRecs := expPhonesPlusMod.getPhonesRemote();
	expandedPhoneCombinedRecs := expPhonesPlusMod.getPhoneCombinedRecs(ta1 , phonePlusRawRecs);
	ta1_temp1 := if(includeExpandedPhonePlusSearch, expandedPhoneCombinedRecs, ta1);
	ta2_temp := if(household and includeHouseHoldOnly, ta1_temp1(includedbyhhid), ta1_temp1);	
	
	rta2_temp_seq_layout:= {unsigned8 seq,doxie.Layout_Rollup.KeyRec};
	ut.MAC_Sequence_Records_NewRec(ta2_temp,rta2_temp_seq_layout,seq,ta2_temp_seq);
	
	household_count := count(ta1_temp1(includedbyhhid));
	
	AddrDid := record
	  unsigned seq;
		string12 did;
		doxie.Layout_Rollup.AddrRec;
	end;
	addrRecs := normalize(ta2_temp_seq, left.addrrecs, transform(AddrDid, self.seq := left.seq,self.did:=left.did, self := right, self := []));

	doxie.Layout_Phones_Telcordia flattenphones(AddrDid l, doxie.Layout_Rollup.PhoneRec r) := transform
		self.telcordia_only := 'N'; 
		self.did := (unsigned)l.did;		
		self := r;
		self := l;
		self := [];
	end;
	dsphones := normalize(addrRecs, left.phoneRecs, flattenphones(left,right));

	telcordia_phones := Doxie.phone_metadata(dsphones,phone_value);
	
	doxie.Layout_Phones_Telcordia initialMap(telcordia_phones l) := transform
		self.did               := (unsigned6)l.did;
		self.type_flag         := map(l.gong_score = 0	  						  => Phones.Constants.TypeFlag.NonDirectoryAssistance, 
																	l.gong_score > 0 and l.tnt  = 'H' => Phones.Constants.TypeFlag.DirectoryAssistance_Disconnected, 
																	l.gong_score > 0 and l.tnt != 'H' => Phones.Constants.TypeFlag.DirectoryAssistance,
																	'');
		self.dial_indicator    := map(l.dial_ind = '1' => 'Y',
																	l.dial_ind = '0' => 'N',
																	'');		
		self.telcordia_only    := l.telcordia_only;
		self.carrier			     := l.ocn;
		self.carrier_city			 := l.city;
		self.carrier_state		 := l.st;
		self.phonetype 				 := map(l.listing_type_cell <> ''  => 'Mobile',
																	l.listing_type_res  <> ''  => 'Residential',
																	l.listing_type_bus  <> ''  => 'Business',
																	'');
		//multiple of 2 - from ppls, 3 - checked with neustar, 5 - checked with telcordia
		self.cell_type         := if(l.listing_type_cell <> '',
																 2*if(l.cellphone<>'',3,1),if(l.cellphone<>'',3,1));
		self.coc_type					 := l.coctype;
		self.coc_description	 := if(l.listing_type_cell <> '', 'Cellular','');
		self.ssc_type					 := l.ssc;
		self.ssc_description	 := '';
		self                   := l;
		self                   := [];
	end;
	TelcordiaMap := project(telcordia_phones, initialMap(left)); 

	//  Create child records for COC description 
	doxie.Layout_Phones_Telcordia addChildren(TelcordiaMap l) := transform
		cell_test1 := l.coc_type = Phones.Constants.COCType.EndofOfficeCode and 
									(l.ssc_type = Phones.Constants.SSC.Cellular or 
									 l.ssc_type = Phones.Constants.SSC.Radio);
									
		cell_test2 := (l.coc_type != Phones.Constants.COCType.EndofOfficeCode)and 
									 (l.ssc_type = Phones.Constants.SSC.Cellular or
										l.ssc_type = Phones.Constants.SSC.Radio or
										l.ssc_type = Phones.Constants.SSC.MiscServices);
									 
		cell_test3 := l.ssc_type = Phones.Constants.SSC.Cellular;							 

		page_test1 := l.coc_type = Phones.Constants.COCType.EndofOfficeCode and 
									l.ssc_type = Phones.Constants.SSC.Paging;
									
		page_test2 := l.coc_type != Phones.Constants.COCType.EndofOfficeCode and
									l.ssc_type = Phones.Constants.SSC.Paging;

		// types are mutually exclusive
		string type_description := map (
			l.coc_type = Phones.Constants.COCType.EndofOfficeCode   => 'LandLine',
			cell_test1 or cell_test2 or cell_test3									=> 'Cellular', 
			page_test1 or page_test2  															=> 'Paging', 
																																 '');
		
		self.coc_description := if(l.coc_description = '', type_description,l.coc_description);
		self.listing_type_cell := IF(cell_test1 OR cell_test2 OR cell_test3,'C',l.listing_type_cell);
		self.cell_type := if(cell_test1 or cell_test2 or cell_test3, l.cell_type*5, l.cell_type);
		
		self.new_type := map(l.type_flag = Phones.Constants.TypeFlag.DataSource_PV or l.type_flag = Phones.Constants.TypeFlag.DataSource_iQ411   => 'Real Time Phones' 
												,l.type_flag = Phones.Constants.TypeFlag.DirectoryAssistance or 
												 l.telcordia_only = 'Y' and l.gong_score = 0 											 => if(includeRTP,'Directory Assistance','Current DA')
												,~(self.cell_type%3=0 or self.cell_type%5=0) and l.confirmed_flag  => if(includeRTP,'Combined Phones Source','Confirmed non-DA')
												,~(self.cell_type%3=0 or self.cell_type%5=0) and ~l.confirmed_flag => if(includeRTP,'Combined Phones Source','Possible non-DA')
												,self.cell_type%5=0 and l.confirmed_flag 													 => if(includeRTP,'Possible Wireless','Confirmed Cell Phone')
												,self.cell_type%5=0 and ~l.confirmed_flag                          => if(includeRTP,'Possible Wireless','Possible Cell Phone')
												,self.cell_type%3=0 and ~l.confirmed_flag                          => if(includeRTP,'Possible Wireless','Possible Ported Cell Phone')
												,self.cell_type%3=0 and l.confirmed_flag                           => if(includeRTP,'Possible Wireless','Confirmed Ported Cell Phone')
												,'');

	//  Create child records for SSC description
		string ssc_description := Phones.Functions.getSSCDescription(l.ssc_type);
																		

		self.ssc_description := if (l.ssc_description = '',ssc_description, l.ssc_description);
		self                 := l;
	end;
	
	withTelcordiaData:= project(TelcordiaMap, addChildren(left));
	
	AddrDid denormTelcordia (AddrDid l, dataset(recordof(withTelcordiaData)) r) := transform
			self.did := (string12)l.did;
			self.phonerecs := choosen(project(r,transform(doxie.Layout_Rollup.PhoneRec,self := left, self := [])),doxie.rollup_limits.phones);
			self := l;
	end;
	
	denorm_phones := denormalize(addrRecs, withTelcordiaData,
															left.seq = right.seq and
															left.prim_name = right.prim_name and
															left.prim_range = right.prim_range and
															left.predir = right.predir and
															left.postdir = right.postdir and
															left.suffix = right.suffix and
															left.sec_range = right.sec_range and
															left.city_name = right.city_name and
															left.st = right.st and
															left.zip = right.zip and
															left.tnt = right.tnt,
															group,
															denormTelcordia(left,rows(right)),left outer);
														
	sort_phones := sort(denorm_phones, -last_seen,-first_seen);														
			
	doxie.Layout_Rollup.KeyRec denormAddr(rta2_temp_seq_layout l, dataset(AddrDid) r) := Transform
		self.did := (string12)l.did;
		self.addrRecs := project(r, Transform(doxie.Layout_Rollup.AddrRec,self := left, self := []));
		self := l;
		self :=[];
	End;
	
	denorm_addr := denormalize(ta2_temp_seq, sort_phones, 
														left.seq = right.seq,
														group,
														denormAddr(left, rows(right)),right outer);
										
  // This section of coding immediately below was added for the FDN project.
  // Set shorter alias names for the new FDN DPM & DRM positions to be passed into the new function.
  boolean FDNContDataPermitted := doxie.DataPermission.use_FDNContributoryData;
  boolean FDNInqDataPermitted  := ~doxie.DataRestriction.FDNInquiry;
	
  // If FDN was asked for, call the new function to set the new fdn indicators.
  ds_denorm_addr_with_fdninds := if(IncludeFraudDefenseNetwork,
													          doxie.Func_FdnCheckRollupRecs(
																		   denorm_addr,
		                                   in_FDN_gcid, in_FDN_indtype, in_FDN_prodcode,
																       FDNContDataPermitted, FDNInqDataPermitted),
                                    //Otherwise just pass along the original dataset
                                    denorm_addr);

	doxie.MAC_Marshall_Results(ds_denorm_addr_with_fdninds,ta2);
	
	// ******************** After choosing records, append more info ********************* 

	// SSN HRI's
	f_ssn(string12 did, DATASET(doxie.Layout_Rollup.SsnRec)sr) := FUNCTION
		tmpRec := RECORD
			string12 did;
			doxie.Layout_Rollup.SsnRec;
		END;
		tmp := PROJECT(sr, TRANSFORM(tmpRec, SELF.did := did, SELF := LEFT));
	
		// Note the limit inside the macro
		doxie.mac_AddHRISSN(tmp,so,~include_hri,doxie.rollup_limits.ssn_hris)

		slim_so := PROJECT(so, TRANSFORM(doxie.Layout_Rollup.SsnRec, SELF := LEFT));
		RETURN slim_so;
	END;

	ta2 doSSNs(ta2 L) := TRANSFORM
		outssnRecs := f_ssn(L.did, L.ssnRecs);
	
		// ssn records already limited by denormalize above
		SELF.ssnRecs := sort(outssnRecs, valid_ssn_score(valid_ssn),ssn);
		SELF := L;
	END;


	// Phone HRI's
	f_phone(DATASET(doxie.Layout_Rollup.AddrRec) pr) := FUNCTION
		layout_HFSListed := RECORD
		  // be forewarned if adding field to doxie.Layout_Rollup.* best to
			// put them into layout_headerFilesearch and reference the new field from 
			// layout_headerFileSearch so that that 'new' field gets included in this
			// the results of this function.
			Layout_HeaderFileSearch; 			
			boolean listed;
			unsigned1 match_type;
			integer gong_score;
			Advo.Layouts.Layout_CDS address_cds;
		END;
	
		idAddrx := RECORD
			doxie.Layout_Rollup.AddrRec;
			STRING30 rid;
		END;
	
		idAddrx idAddr(doxie.Layout_Rollup.AddrRec le, INTEGER c) := 	TRANSFORM
			SELF.rid := (STRING)c;
			SELF := le;
		END;
	
		// TODO: get RID's right
		layout_HFSListed newChildren(idAddrx le, doxie.Layout_Rollup.PhoneRec ri) := TRANSFORM
			SELF.listed := ri.listed;
			SELF.did := INTFORMAT(ri.did,12,1);
			SELF.phone := ri.phone;
			SELF := le;
			SELF := ri;
			SELF := [];
		END;	
		
		n := NORMALIZE(PROJECT(pr,idAddr(LEFT, COUNTER)),LEFT.phoneRecs,newChildren(LEFT,RIGHT));
	
		// TODO: limit
		doxie.mac_AddHRIPhone(n,nout)

		doxie.Layout_Rollup.PhoneRec fixPhones(layout_HFSListed le) := TRANSFORM
			SELF.phone := le.phone;
			SELF.did := (unsigned6)le.did;
			// listing_type_cell='C' means probable cell phone here, but we want to exclude HRIs for all P+
			SELF.hri_phone := if (le.match_type != 3, le.hri_phone);
			SELF := le;
		END;

		doxie.Layout_Rollup.AddrRec fixAddress(layout_HFSListed le) := TRANSFORM
			SELF.phoneRecs := PROJECT(le, fixPhones(LEFT));
			SELF := le;
		END;
	
		p := PROJECT(GROUP(SORT(nout,rid),rid),fixAddress(LEFT));
	
		doxie.Layout_Rollup.AddrRec recombine(doxie.Layout_Rollup.AddrRec le, doxie.Layout_Rollup.AddrRec ri) := TRANSFORM
			SELF.PhoneRecs := le.PhoneRecs+ri.PhoneRecs; // already did the limiting
			SELF := le;
		END;
	
		RETURN GROUP(ROLLUP(p, recombine(LEFT,RIGHT), true));
	END;	

	// Address HRI's
	f_addr(DATASET(doxie.Layout_Rollup.AddrRec) ar) :=	FUNCTION
		// TODO: limit
		doxie.mac_AddHRIAddress(ar,ao)
		RETURN f_phone(ao(exists(phonerecs)))+ ao(~exists(phonerecs));
	END;

	boolean hasListing(DATASET(doxie.Layout_Rollup.PhoneRec) phones) := EXISTS(phones(listed = true));
	
	doxie.Layout_Rollup.AddrRec resortPhones(doxie.Layout_Rollup.AddrRec le) := TRANSFORM
		SELF.PhoneRecs := SORT(le.PhoneRecs,IF(match_type=0,100,match_type),gong_score,-phone,listed_name);
		SELF := le;
	END;

	doxie.Layout_Rollup.AddrRec appendCensus(doxie.Layout_Rollup.AddrRec le, census_data.Key_Smart_Jury ri) := TRANSFORM
		SELF.census_age := ri.age;
		SELF.census_income := ri.income;
		SELF.census_home_value := ri.home_value;
		SELF.census_education := ri.education;
		SELF := le;
	END;

	ta2 doAddrs(ta2 L) := TRANSFORM
		outaddrRecs := PROJECT(IF(include_hri, f_addr(L.addrRecs), L.addrRecs),resortPhones(LEFT));

		// Append census data
		j := join(outaddrRecs,census_data.Key_Smart_Jury,
												keyed(left.st = right.stusab) and 
												keyed(left.county = right.county) and
												keyed(left.geo_blk[1..6] = right.tract) and 
												keyed(left.geo_blk[7] =right.blkgrp), 
												appendCensus(LEFT,RIGHT), keep(1), LEFT OUTER);
																									 
		// use first_seen as a secondary sort key to differentiate addrs with same last_seen date
		addrNotCnsmr := sort(j, tnt_score(tnt),-MAX(first_seen,last_seen),
												-first_seen, -hasListing(phoneRecs), prim_range);
		addCnsmr := sort(j, tnt_score(tnt),-last_seen, -dt_vendor_last_reported, 
												-dt_vendor_first_reported, -hasListing(phoneRecs), prim_range);
		SELF.addrRecs := IF(ut.IndustryClass.is_knowx, addCnsmr, addrNotCnsmr);
							
		SELF := L;
	END;


	doxie.Layout_Rollup.RidRecDid getRids(tagrp L) := TRANSFORM
		SELF.r.rid := L.rid;
		SELF.r.src := L.src;
		self.listed_phone := if(skipRelativePhoneAppend and exists(l.phones(phone10=l.listed_phone and match_type = 4)),'',l.listed_phone);
		SELF := L;
	END;

	whichRids := join(tagrp, ta2, LEFT.did = RIGHT.did, getRids(LEFT));
	srcRids := doxie.lookup_rid_src(dedup(sort(whichRids,record),record));

	best_recs := doxie.best_records(PROJECT(ta2,TRANSFORM(doxie.layout_references,SELF.did:=(unsigned)LEFT.did)),false,1,1,includeDOD:=true);

   

	ta2 doRest(ta2 le, best_recs ri) := TRANSFORM
		// Sort the names/dob/dod in order according to how well they're matching the best data
		SELF.nameRecs := sort(le.nameRecs, IF(lname=ri.lname,0,1), 
													 IF(fname=ri.fname,0,1), -LENGTH(TRIM(fname)), 
													 IF(mname=ri.mname,0,1), -LENGTH(TRIM(mname)), 
															lname,fname,mname,name_suffix);
		SELF.dobRecs := sort(le.dobRecs, -did_add.DOB_Match_Score(dob,ri.dob), dob);
		SELF.dodRecs := sort(le.dodRecs, -did_add.DOB_Match_Score(dod,(integer)ri.dod), dod);
		//Added to sort ssnRecs to how well they're matching the best data:Bug:158338
    SELF.ssnRecs := sort(le.ssnRecs,doxie.valid_ssn_score(valid_ssn),
		                     IF(le.ssnRecs.ssn=ri.ssn,0,1),ssn
												 ); 
		SELF := le;
	END;

	proj1 := PROJECT(ta2, doAddrs(LEFT));
	proj2_orig := PROJECT(nofold(proj1), doSSNs(LEFT));
	proj2 := if(reduced_data_value, proj1, proj2_orig);
	proj3 := JOIN(nofold(proj2), best_recs, 
						(unsigned6)LEFT.did=RIGHT.did, 
						doRest(LEFT,RIGHT), LEFT OUTER, PARALLEL, LOOKUP);


	proj3 denormRids(proj3 L, doxie.Layout_Rollup.RidRecDid R) := TRANSFORM
		SELF.rids := L.rids + R.r;
		SELF := L;
	END;

	proj4_unsorted := DENORMALIZE(nofold(proj3), srcRids, LEFT.did = RIGHT.did, denormRids(LEFT,RIGHT));

	// Unfortunately, need to resort after the DENORMALIZE 

	// for addr only queries (like neighbors), the sort should be by prim_range ascending first
	proj4_addr_srtd := sort(proj4_unsorted, addrRecs[1].prim_range, -addrRecs[1].last_seen, maxRid);
	// sort entries with DID before those without (after searched SSN and searched address TNT)
	proj4_srtd := sort(proj4_unsorted, includedByHHID, expandedPhonePlusRecord, penalt,bestSrchedValidSSNScore, bestSrchedAddrTntScore, -((unsigned6)did <> 0),
            -bestSrchedAddrDate, bestTntScore,-maxDate,-head_cnt,maxRid);

	proj4_orig := if (addressOnlySort, proj4_addr_srtd, proj4_srtd);

	proj4 := if(reduced_data_value, proj3, proj4_orig);

	l_dids := get_dids(noFail := true);
	morePhones := IF(count(l_dids)<100,doxie.Add_Phones(l_dids,doxie.relative_dids(l_dids),dial_bouncedistance_value));

	ta2 addBounce(ta2 le, morePhones ri) := TRANSFORM
		SELF.WorkPhones := CHOOSEN(ri.WorkPhones, doxie.rollup_limits.phones);
		SELF.RelativePhones := CHOOSEN(ri.RelativePhones, doxie.rollup_limits.phones);
		SELF := le;
	END;


	bounce_orig := JOIN(proj4, morePhones,
												(unsigned6)LEFT.did=RIGHT.did, 
												addBounce(LEFT,RIGHT), PARALLEL, LOOKUP, LEFT OUTER);

	ta2_grouped := GROUP(ta2,did);

	get_rel := doxie.relative_names(PROJECT(ta2_grouped,
																		TRANSFORM(doxie.layout_references, 
																				SELF.did := (unsigned)LEFT.did)),
																			false,industry_class_value='CNSMR');
 
	bounce_orig addRelat(ta2 le, get_rel ri) := TRANSFORM
		SELF.RelativeNames := project(ri.names,Standard.Name);
		SELF := le;
	END;
	bounce := IF(include_relative_names_value, 
			JOIN(bounce_orig, get_rel, 
					(unsigned6)LEFT.did=RIGHT.did, 
						addrelat(LEFT,RIGHT), LOOKUP, LEFT OUTER),
			bounce_orig);
			

	doxie.MAC_Add_WeAlsoFound(bounce,bounce_waf,glb_purpose,dppa_purpose)
	outt1 := IF (include_wealsofound, bounce_waf, bounce);
				
	doxie.Mac_Bk_Count(outt1, outt2, did, bk_count, doxie_crs.str_typeDebtor);			

	outt := IF(includeBankruptcyCount, outt2, outt1);

	// mask the ssns	g
	Suppress.MAC_Mask_dsSSN(outt, with_mask, ssnrecs, ssn);


	/* ******************** US SEARCH HACK ************************ */
	us_got_rel := IF(include_relative_names_value, 
				JOIN(ta2_grouped, get_rel, 
						(unsigned)LEFT.did=RIGHT.did, 
						addRelat(LEFT,RIGHT), LEFT OUTER, LOOKUP), ta2_grouped);

  final := if(reduced_data_value,GROUP(us_got_rel),with_mask);
	
	final fixAddrDates(final le) := TRANSFORM
		// this is the consumer data that needs the dates to be inveted because the source
		// first_seen and last_seen are actually stored in te vendor dates.		
		self.addrRecs := project(le.addrRecs, transform(doxie.Layout_Rollup.AddrRec, 					
			self.first_seen := left.dt_vendor_first_reported,
			self.last_seen := left.dt_vendor_last_reported,
			self.dt_vendor_last_reported := left.last_seen;
			self.dt_vendor_first_reported := left.first_seen;
			self := left));		
		self := le;
	END;
	
	result := if(ut.IndustryClass.is_knowx, project(final, fixAddrDates(LEFT)), final);
	
	Royalty.MAC_RoyaltyLastResort(phonePlusRawRecs,lastresort_royalties);
	FDN_check     := ds_denorm_addr_with_fdninds(fdn_results_found = true);
  FDN_Royalties := Royalty.RoyaltyFDNCoRR.GetOnlineRoyalties(FDN_check);
  targus_royalties := Royalty.RoyaltyTargus.GetOnlineRoyalties(phonePlusRawRecs,,,,doxie.DataPermission.use_confirm);
	royalties := dataset([], Royalty.Layouts.Royalty) + if(IncludeFraudDefenseNetwork, FDN_Royalties) + if(use_tg , targus_royalties) + if (use_LR, lastresort_royalties);
  
  doxie.Layout_Rollup.header_rolled final_result() := TRANSFORM 
		self.Results := project(result, doxie.layout_rollup.KeyRec_Seq);  
		self.Royalty := royalties;
		self.householdRecordsAvailable := household_count;
	END;
  return DATASET([final_result()]);	
END;