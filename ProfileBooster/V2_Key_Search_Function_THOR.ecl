IMPORT 	ProfileBooster, _Control, address, Address_Attributes, avm_v2, dma, doxie, Gateway, LN_PropertyV2, LN_PropertyV2_Services, mdr,  
				Riskwise, Risk_Indicators, aid, std, dx_header, ut, one_click_data, advo, dx_ProfileBooster;
onThor := _Control.Environment.OnThor;

EXPORT V2_Key_Search_Function_THOR(DATASET(ProfileBooster.V2_Key_Layouts.Layout_PB2_In) PB_In, 
																						string50 DataRestrictionMask, 
																						string50 DataPermissionMask,
																						string8 AttributesVersion, 
                                            boolean domodel=false,
                                            string modelname = '',
																						string prt = '1'
                                            ) := FUNCTION

BOOLEAN DEBUG := FALSE;

	isFCRA 		:= false;
	GLBA 		:= 0;
	DPPA 		:= 0;
	BSOptions 	:= Risk_Indicators.iid_constants.BSOptions.RetainInputDID;
	bsversion 	:= 50;
	append_best := 0;	
	gateways    := dataset([],Gateway.Layouts.Config);
	todaysdate	:= (STRING8)Std.Date.Today();
	nines		:= 9999999;
  	maxmths	    := 960;

// ********************************************************************
// Transform PB input to Layout_Input so we can call iid_getDID_prepOutput
// ********************************************************************

Risk_Indicators.Layout_Input into(PB_In l) := TRANSFORM
		self.did 		:= (integer)l.LexId;
		self.score 		:= if((integer)l.lexid<>0, 100, 0);  // hard code the DID score if DID is passed in on input
		self.seq 		:= l.seq;
		self.HistoryDate 	:= if(l.historydate=0, risk_indicators.iid_constants.default_history_date, l.HistoryDate);
		self.ssn 		:= l.ssn;
		dob_val 		:= riskwise.cleandob(l.dob);
		dob 			:= dob_val;
		self.dob 		:= if((unsigned)dob=0, '', dob);

		fname  			:= l.Name_First ;
		mname  			:= l.Name_Middle;
		lname  			:= l.Name_Last ;
		suffix 			:= l.Name_Suffix ;
		self.fname  	:= stringlib.stringtouppercase(fname);
		self.mname  	:= stringlib.stringtouppercase(mname);
		self.lname  	:= stringlib.stringtouppercase(lname);
		self.suffix 	:= stringlib.stringtouppercase(suffix);
		
		addr_value 		:= trim(l.street_addr);
		clean_a2 		:= Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.City_name, l.st, l.z5);
		self.in_streetAddress:= addr_value;
		self.in_city    := l.City_name;
		self.in_state   := l.st;
		self.in_zipCode := l.z5;	
		self.prim_range := Address.CleanFields(clean_a2).prim_range;
		self.predir     := Address.CleanFields(clean_a2).predir;
		self.prim_name  := Address.CleanFields(clean_a2).prim_name;
		self.addr_suffix := Address.CleanFields(clean_a2).addr_suffix;
		self.postdir    := Address.CleanFields(clean_a2).postdir;
		self.unit_desig := Address.CleanFields(clean_a2).unit_desig;
		self.sec_range  := Address.CleanFields(clean_a2).sec_range;
		self.p_city_name := Address.CleanFields(clean_a2).p_city_name;
		self.st         := Address.CleanFields(clean_a2).st;
		self.z5         := Address.CleanFields(clean_a2).zip;
		self.zip4       := Address.CleanFields(clean_a2).zip4;
		self.lat        := Address.CleanFields(clean_a2).geo_lat;
		self.long       := Address.CleanFields(clean_a2).geo_long;
		self.addr_type 	:= risk_indicators.iid_constants.override_addr_type(l.street_addr, Address.CleanFields(clean_a2).rec_type[1],Address.CleanFields(clean_a2).cart);
		self.addr_status := Address.CleanFields(clean_a2).err_stat;
		county          := Address.CleanFields(clean_a2).county;
		self.county     := county[3..5]; //bytes 1-2 are state code, 3-5 are county number
		self.geo_blk    := Address.CleanFields(clean_a2).geo_blk;
		self.Phone10	:= StringLib.StringFilter(l.Phone10, '0123456789');
		self := [];
	END;

	iid_prep_roxie := PROJECT(PB_In, into(left));	

// NEW::  Calling the AID address cache macro now that Tony added the new feature for us:  https://bugzilla.seisint.com/show_bug.cgi?id=194258

	r_layout_input_PlusRaw	:= RECORD
		ProfileBooster.Layouts.Layout_PB_In;
		// add these 3 fields to existing layout anytime i want to use this macro
		string60	Line1;
		string60	LineLast;
		unsigned8	rawAID;
	end;

	r_layout_input_PlusRaw	prep_for_AID(PB_In le)	:=
	transform
		self.Line1		:=	trim(stringlib.stringtouppercase(le.street_addr));
		self.LineLast	:=	address.addr2fromcomponents(stringlib.stringtouppercase(le.City_name), stringlib.stringtouppercase(le.St),  le.Z5);  // );, uppercase and trim city and state, zip5 only
		self.rawAID			:=	0;
		self	:=	le;
	end;
	aid_prepped	:=	project(PB_In, prep_for_AID(left));


	// new parameter is the NoNewCacheFiles
	unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;

	AID.MacAppendFromRaw_2Line(	aid_prepped,
															Line1,
															LineLast,
															rawAID,
															my_dataset_with_address_cache,
															lAIDAppendFlags
														);

	Risk_Indicators.Layout_Input prep_for_thor(my_dataset_with_address_cache l) := TRANSFORM
		self.did 		:= (integer)l.LexId;
		self.score := if((integer)l.lexid<>0, 100, 0);  // hard code the DID score if DID is passed in on input
		self.seq 		:= l.seq;   
		self.HistoryDate 	:= if(l.historydate=0, risk_indicators.iid_constants.default_history_date, l.HistoryDate);

		self.ssn 		:= l.ssn;
		dob_val 		:= riskwise.cleandob(l.dob);
		dob 				:= dob_val;
		self.dob 		:= if((unsigned)dob=0, '', dob);

		fname  			:= l.Name_First ;
		mname  			:= l.Name_Middle;
		lname  			:= l.Name_Last ;
		suffix 			:= l.Name_Suffix ;
		self.fname  := stringlib.stringtouppercase(fname);
		self.mname  := stringlib.stringtouppercase(mname);
		self.lname  := stringlib.stringtouppercase(lname);
		self.suffix := stringlib.stringtouppercase(suffix);
		self.Phone10				 := StringLib.StringFilter(l.Phone10, '0123456789');		
		
		addr_value 	:= trim(l.street_addr);
		self.in_streetAddress:= addr_value;
		self.in_city         := l.City_name;
		self.in_state        := l.st;
		self.in_zipCode      := l.z5;	
		
		self.prim_range      := l.aidwork_acecache.prim_range;
		self.predir          := l.aidwork_acecache.predir;
		self.prim_name       := l.aidwork_acecache.prim_name;
		self.addr_suffix     := l.aidwork_acecache.addr_suffix;
		self.postdir         := l.aidwork_acecache.postdir;
		self.unit_desig      := l.aidwork_acecache.unit_desig;
		self.sec_range       := l.aidwork_acecache.sec_range;
		self.p_city_name     := l.aidwork_acecache.p_city_name;
		self.st              := l.aidwork_acecache.st;
		self.z5              := l.aidwork_acecache.zip5;
		self.zip4            := l.aidwork_acecache.zip4;
		self.lat             := l.aidwork_acecache.geo_lat;
		self.long            := l.aidwork_acecache.geo_long;
		self.addr_type 			 := risk_indicators.iid_constants.override_addr_type(l.street_addr, l.aidwork_acecache.rec_type[1],l.aidwork_acecache.cart);
		self.addr_status     := l.aidwork_acecache.err_stat;
		self.county          := l.aidwork_acecache.county[3..5]; //bytes 1-2 are state code, 3-5 are county number
		self.geo_blk         := l.aidwork_acecache.geo_blk;		
		
		self := [];
	END;

	iid_prep_thor := project(my_dataset_with_address_cache, prep_for_thor(left));									 
										 
#IF(onThor)
	iid_prep := iid_prep_thor;
  	did_prepped_output := ungroup(Risk_Indicators.iid_getDID_prepOutput_THOR(iid_prep, DPPA, GLBA, isFCRA, bsversion, DataRestrictionMask, append_best, gateways, BSOptions));
#ELSE
	iid_prep :=iid_prep_roxie;
  	did_prepped_output := ungroup(risk_indicators.iid_getDID_prepOutput(iid_prep, DPPA, GLBA, isFCRA, bsversion, DataRestrictionMask, append_best, gateways, BSOptions));
#END

 	// ********************************************************************
	// Get the DID and Append the Input Account Number
	// ********************************************************************
    //pick the DID with the highest score, 
    //in the event that multiple have the same score, choose the lowest value DID to make this deterministic
  	sortDIDs := SORT(UNGROUP(did_prepped_output), seq, -score, did);
  	highestDIDScore := DEDUP(sortDIDs, seq); 
  
 	with_DID := JOIN(distribute(PB_In, seq), distribute(highestDIDScore(DID<>0), seq), 
									LEFT.seq = RIGHT.seq, TRANSFORM(Risk_Indicators.Layout_Output, SELF.Account := LEFT.AcctNo; SELF := RIGHT), local);
									
  	donotmail_key := dma.key_DNM_Name_Address;

//join to DoNotMail to set the DNM attribute
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell setDNMFlag(with_DID le, donotmail_key ri ) := TRANSFORM
		self.DoNotMail 		:= if(ri.l_zip='', '0', '1');
		self.DID2 				:= le.DID; 	//propogate the prospect's DID to DID2 at this point
		self.rec_type 		:= ProfileBooster.Constants.recType.Prospect; //all records are "Prospect" type at this point.  Household and Relatives will be added later.
		self.AcctNo				:= le.Account;
		self 							:= le;
		self 							:= [];
	END;
	
	withDoNotMail_roxie := join(with_DID, donotmail_key,
		left.z5 != ''
		and keyed(left.prim_name = right.l_prim_name) //
		and keyed(left.prim_range = right.l_prim_range)
		and keyed(left.st = right.l_st)
		and keyed(right.l_city_code in doxie.Make_CityCodes(left.p_city_name).rox)
		and keyed(left.z5= right.l_zip)
		and keyed(left.sec_range = right.l_sec_range)
		and keyed(left.lname = right.l_lname)
		and keyed(left.fname = right.l_fname),
		setDNMFlag(left,right), left outer, keep(1), atmost(riskwise.max_atmost)
	);

	withDoNotMail_thor := join(distribute(with_DID, hash64(z5, prim_name, prim_range, st)), 
															distribute(pull(donotmail_key), hash64(l_zip, l_prim_name, l_prim_range, l_st)),
		left.z5 != ''
		and left.prim_name = right.l_prim_name
		and left.prim_range = right.l_prim_range
		and left.st = right.l_st
		and right.l_city_code in doxie.Make_CityCodes(left.p_city_name).rox
		and left.z5= right.l_zip
		and left.sec_range = right.l_sec_range
		and left.lname = right.l_lname
		and left.fname = right.l_fname,
		setDNMFlag(left,right), left outer, keep(1), local
	);
	
	#IF(onThor)
		withDoNotMail := withDoNotMail_thor;
	#ELSE
		withDoNotMail := withDoNotMail_roxie;
	#END
	
  withVerification := ProfileBooster.V2_Key_getVerification_THOR(withDoNotMail);

//Search Death Master by DID. Set 2 dates (1 with SSA permission and 1 not) and choose appropriately 
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getDeceasedDID(withVerification le, Doxie.key_Death_masterV2_ssa_DID ri) := transform
		SELF.dod 		:= if(ri.src <> MDR.sourceTools.src_Death_Restricted, (UNSIGNED)ri.dod8, 0);  //excludes SSA 
		SELF.dodSSA := (UNSIGNED)ri.dod8;  //unrestricted so includes SSA
		self 	:= le;
	end;

	withDeceasedDID_roxie := join(withVerification, Doxie.key_Death_masterV2_ssa_DID,
									left.DID <> 0 and
									(UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate AND									
									keyed(left.DID = right.l_did),
									getDeceasedDID(left, right), left outer, keep(200), ATMOST(RiskWise.max_atmost));

	withDeceasedDID_thor := join(distribute(withVerification, did), 
														 distribute(pull(Doxie.key_Death_masterV2_ssa_DID), l_did),
									left.DID <> 0 and
									(UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate AND									
									left.DID = right.l_did,
									getDeceasedDID(left, right), left outer, keep(200), local);

	#IF(onThor)
		withDeceasedDID := withDeceasedDID_thor;
	#ELSE
		withDeceasedDID := withDeceasedDID_roxie;
	#END
	
	sortedDeceased := sort(withDeceasedDID, seq);

//rollup by Deceased matches and keep whichever record has a DOD
  ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell rollDeceased(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell ri) := transform
		self.dod		:= max(le.dod, ri.dod);
		self.dodSSA	:= max(le.dodSSA, ri.dodSSA);
		self				:= le;
	end;
	
  rolledDeceased := rollup(sortedDeceased, rollDeceased(left,right), seq);

//join to the Infutor key to get marital status and gender
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getInfutor(rolledDeceased le, ProfileBooster.V2_Key_Infutor_DID ri ) := TRANSFORM
		// OlderErmgRecord := (UNSIGNED6)(((STRING)ri.dt_first_seen)[1..6]) < (UNSIGNED6)(((STRING)le.EmrgDt_first_seen)[1..6]); 
		// EmrgDt_first_seen := IF(OlderErmgRecord,(UNSIGNED6)ri.dt_first_seen,(UNSIGNED6)le.EmrgDt_first_seen);
		// self.EmrgDt_first_seen	:= EmrgDt_first_seen;
		// self.EmrgSrc            := IF(OlderErmgRecord,MDR.sourceTools.src_InfutorNarc,le.EmrgSrc);
		// EmrgDob	:= MAP(~OlderErmgRecord                       => le.EmrgDob, 
		// 													     (STRING)ri.dob);
		// self.EmrgDob			:= EmrgDob;
    	// fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		// self.EmrgAge   			:= risk_indicators.years_apart((unsigned)EmrgDt_first_seen, (unsigned)EmrgDob);
		self.marital_status	    := ri.marital_status;
		self.gender				:= ri.gender;
		self.DOB				:= if(le.DOB = '', ri.DOB, le.DOB);
        historydate := risk_indicators.iid_constants.myGetDate(le.historydate)[1..6]; 
		self.ProspectAge		:= if(le.ProspectAge <> 0, le.ProspectAge, risk_indicators.years_apart((unsigned)HistoryDate, (unsigned)ri.DOB));
		self 					:= le;
	END;
	
	withInfutor_thor := join(distribute(rolledDeceased, did), 
													 distribute(pull(ProfileBooster.V2_Key_Infutor_DID), did),
		left.DID = right.DID, 
		getInfutor(left,right), left outer, keep(1), local)
	;	
	// : PERSIST('~PROFILEBOOSTER::with_infutor_thor_full::' + prt); // remove persists because low on disk space and it's rebuilding persist file each time anyway
	
	withInfutor := withInfutor_thor;
	
//get business count for the input address
ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getInputBus(withInfutor le, Address_Attributes.key_AML_addr ri)  := TRANSFORM
		self.InpAddrBusRegCnt 	:= ri.biz_cnt;
		// self.CurrAddrBusRegCnt 	:= if(le.curr_equals_input, ri.biz_cnt, 0);
		self 											:= le;
END;

withInputBus_roxie := join(withInfutor, Address_Attributes.key_AML_addr, 
		KEYED(trim(LEFT.z5) 					= RIGHT.zip) AND
		KEYED(trim(LEFT.prim_range) 	= RIGHT.prim_range) AND
		KEYED(trim(LEFT.prim_name) 		= RIGHT.prim_name) AND
		KEYED(trim(LEFT.addr_suffix) 	= RIGHT.addr_suffix) AND
		KEYED(trim(LEFT.predir) 			= RIGHT.predir) AND
		KEYED(trim(LEFT.postdir)			= RIGHT.postdir) and
		trim(left.sec_range)=right.sec_range,
	getInputBus(LEFT, RIGHT),left outer, keep(1),  //only need to keep 1 because biz_cnt is the same on all records for the address
		atmost(10000));

with_infutor_inputaddrpopulated := withInfutor(z5<>'' and prim_name<>'');
with_infutor_inputaddr_notpopulated := withInfutor(z5='' or prim_name='');

withInputBus_thor_hits := join(distribute(with_infutor_inputaddrpopulated, hash64(z5, prim_range, prim_name, addr_suffix, predir, postdir)), 
													distribute(pull(Address_Attributes.key_AML_addr), hash64(zip, prim_range, prim_name, addr_suffix, predir, postdir)), 
		trim(LEFT.z5) 					= RIGHT.zip AND
		trim(LEFT.prim_range) 	= RIGHT.prim_range AND
		trim(LEFT.prim_name) 		= RIGHT.prim_name AND
		trim(LEFT.addr_suffix) 	= RIGHT.addr_suffix AND
		trim(LEFT.predir) 			= RIGHT.predir AND
		trim(LEFT.postdir)			= RIGHT.postdir and 
		trim(left.sec_range)=right.sec_range,
	getInputBus(LEFT, RIGHT),left outer, keep(1),  //only need to keep 1 because biz_cnt is the same on all records for the address
		atmost(10000), local);
withInputBus_thor := withInputBus_thor_hits + with_infutor_inputaddr_notpopulated;	// add back the records that didn't have input address populated
	
#IF(onThor)
	withInputBus := withInputBus_thor;
#ELSE
	withInputBus := withInputBus_roxie;
#END

//get business count for prospect's current address
ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell  getCurrBus(withInputBus le, Address_Attributes.key_AML_addr ri)  := TRANSFORM
		self.CurrAddrBusRegCnt := if(ri.biz_cnt > 0, ri.biz_cnt, le.CurrAddrBusRegCnt); 
		self 										:= le;
END;

with_InputBus_curraddrpopulated := withInputBus(curr_z5<>'' and curr_prim_name<>'');
with_InputBus_curraddr_notpopulated := withInputBus(curr_z5='' or curr_prim_name='');

withCurrBus_roxie := join(withInputBus, Address_Attributes.key_AML_addr,
		// ~LEFT.curr_equals_input AND	//if current address is same as input address, we already picked up business count in join above
		KEYED(trim(LEFT.curr_z5) 					= RIGHT.zip) AND
		KEYED(trim(LEFT.curr_prim_range) 	= RIGHT.prim_range) AND
		KEYED(trim(LEFT.curr_prim_name) 	= RIGHT.prim_name) AND
		KEYED(trim(LEFT.curr_addr_suffix) = RIGHT.addr_suffix) AND
		KEYED(trim(LEFT.curr_predir) 			= RIGHT.predir) AND
		KEYED(trim(LEFT.curr_postdir)			= RIGHT.postdir) and
		trim(left.curr_sec_range) = right.sec_range,
	getCurrBus(LEFT, RIGHT),left outer, keep(1),
		atmost(RiskWise.max_atmost));


withCurrBus_thor_hits := join(
	distribute(with_InputBus_curraddrpopulated, hash64(curr_z5, curr_prim_range, curr_prim_name, curr_addr_suffix, curr_predir, curr_postdir)), 
	distribute(Address_Attributes.key_AML_addr, hash64(zip, prim_range, prim_name, addr_suffix, predir, postdir)),
		// ~LEFT.curr_equals_input AND	//if current address is same as input address, we already picked up business count in join above
		trim(LEFT.curr_z5) 					= RIGHT.zip AND
		trim(LEFT.curr_prim_range) 	= RIGHT.prim_range AND
		trim(LEFT.curr_prim_name) 	= RIGHT.prim_name AND
		trim(LEFT.curr_addr_suffix) = RIGHT.addr_suffix AND
		trim(LEFT.curr_predir) 			= RIGHT.predir AND
		trim(LEFT.curr_postdir)			= RIGHT.postdir and
		trim(left.curr_sec_range) 	= right.sec_range,
	getCurrBus(LEFT, RIGHT),left outer, keep(1),
		atmost(RiskWise.max_atmost), local);
withCurrBus_thor := withCurrBus_thor_hits + with_InputBus_curraddr_notpopulated;// add back the records that didn't have current address populated

#IF(onThor)
	withCurrBus := withCurrBus_thor;
#ELSE
	withCurrBus := withCurrBus_roxie;
#END
		
//get household members (DIDs) by doing inner join of the HHID to the HHID_Did key
//merge Prospect rec, Household recs, Relatives recs into one file
	allDIDs := withCurrBus;// + hhDIDs + relativeDIDs;
	
//if a DID is both a household member and a relative, keep only the household record so relatives attributes are exclusive
	unique_DIDs_roxie := dedup(sort(allDIDs, seq, DID2, rec_type), seq, DID2);
	
	distributed_allDIDs := distribute(allDIDs, hash(seq, did2));
	unique_DIDs_thor := dedup(sort(distributed_allDIDs, seq, DID2, rec_type, local), seq, DID2, local);//   : PERSIST('~PROFILEBOOSTER::unique_DIDs_thor');  // remove persists because low on disk space and it's rebuilding persist file each time anyway
	
	#IF(onThor)
		uniqueDIDs := unique_DIDs_thor;
	#ELSE
		uniqueDIDs := unique_DIDs_roxie;
	#END
  
//slim down the uniqueDIDs records to create a smaller layout to pass into all of the following searches
	slimShell := project(uniqueDIDs,  
												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Slim,
                        //prim range 	predir 	prim name 	addr suffix 	postdir 	unit desig 	sec range 	p city name 	st 	z5
																	self 							:= left));

//--------- Get age of household members and relatives -------------//

	ageRecs 		:= ProfileBooster.V2_Key_getAge(slimShell(DID <> DID2)); //we already have age of prospect so exclude them here
		
	// dedupHH 	 	:= dedup(sort(ageRecs(rec_type=ProfileBooster.Constants.recType.Relative), seq, HHID), seq, HHID); 

	// tRelaHHcnt 	:= table(dedupHH, {seq, RelaHHcnt := count(group)}, seq); //count number of unique HHIDs within relative recs
	// tRelaIncome := table(ageRecs(rec_type=ProfileBooster.Constants.recType.Relative and med_hhinc <> 0), {seq, RelaIncome := ave(group, med_hhinc)}, seq);
	
	withAge := join(uniqueDIDs, ageRecs,  
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	// self.HHTeenagerMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age between 13 and 19, 1, 0);  
																	// self.HHYoungAdultMmbrCnt 	:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age between 20 and 39, 1, 0);  
																	// self.HHMiddleAgemmbrCnt 	:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age between 40 and 64, 1, 0);  
																	// self.HHSeniorMmbrCnt 			:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age between 65 and 79, 1, 0);  
																	// self.HHElderlyMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age > 79, 1, 0);  
																	// self.HHCnt 								:= if(left.rec_type = ProfileBooster.Constants.recType.Household, 1, 0);  
																	// self.RaATeenageMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age between 13 and 19, 1, 0);  
																	// self.RaAYoungAdultMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age between 20 and 39, 1, 0);  
																	// self.RaAMiddleAgeMmbrCnt 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age between 40 and 64, 1, 0);  
																	// self.RaASeniorMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age between 65 and 79, 1, 0);  
																	// self.RaAElderlyMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age > 79, 1, 0);  
																	// self.RaAMmbrCnt 					:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, 1, 0);  
                                  // ASSIGN MIN/MAX CALCULATION FIELDS DEFAULTS
                                  self.LifeAstPurchOldMsnc := dx_ProfileBooster.Constants.NO_DATA_FOUND_INT;//defaults to dx_ProfileBooster.Constants.MISSING_INPUT_DATA_INT;
                                  self.LifeAstPurchNewMsnc := ABS(dx_ProfileBooster.Constants.NO_DATA_FOUND_INT);
																	self := left), left outer);

//--------- Student-------------//
	dk := choosen(dx_header.key_max_dt_last_seen(), 1);
	hdrBuildDate01 := dk[1].max_date_last_seen[1..6]+'01';

	studentRecs := ProfileBooster.V2_Key_getStudent(slimShell);
	
	// withStudent := join(slimShell, studentRecs,
	withStudent := join(withAge, studentRecs,
												left.did = right.did,
												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	// within4Years											:= right.student_college_code = '4' and ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.student_date_first_seen,true) < 49;
																	// within2Years											:= right.student_college_code = '2' and ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.student_date_first_seen,true) < 25;
																	// self.ProspectCollegeAttending			:= if( (within4Years or within2Years), '1', '0');
																	// self.ProspectCollegeAttended			:= if( right.student_date_first_seen <> '', '1', '0');
																	// self.ProspectCollegeProgramType		:= right.student_college_code;
                                                                        // map(right.student_college_code = '1'	=> '3', 
																																							// right.student_college_code = '4'	=> '2',
																																							// right.student_college_code = '2'	=> '1',
																																																									 // '0');
																	// self.ProspectCollegePrivate				:= if( right.student_college_type in ['P','R'], '1', '0'); 
																	// self.ProspectCollegeTier					  := if( right.student_college_tier <> '', right.student_college_tier, '0');
                                  self.DemEduCollCurrFlag               := right.DemEduCollCurrFlag;
                                  self.DemEduCollFlagEv                 := right.DemEduCollFlagEv;
                                  self.DemEduCollNewLevelEv             := right.DemEduCollNewLevelEv;
                                  self.DemEduCollNewPvtFlag             := right.DemEduCollNewPvtFlag;
                                  self.DemEduCollNewTierIndx            := right.DemEduCollNewTierIndx;
                                  self.DemEduCollLevelHighEv            := right.DemEduCollLevelHighEv;
                                  self.DemEduCollRecNewInstTypeEv       := right.DemEduCollRecNewInstTypeEv;
                                  self.DemEduCollTierHighEv             := right.DemEduCollTierHighEv;
                                  self.DemEduCollRecNewMajorTypeEv      := right.DemEduCollRecNewMajorTypeEv;
                                  self.DemEduCollEvidFlagEv             := right.DemEduCollEvidFlagEv;
                                  self.DemEduCollSrcNewRecOldMsncEv     := right.DemEduCollSrcNewRecOldMsncEv;//ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((INTEGER)history_date[1..6]),(string)right.student_date_first_seen,true);
                                  self.DemEduCollSrcNewRecNewMsncEv     := right.DemEduCollSrcNewRecNewMsncEv;//ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((INTEGER)history_date[1..6]),(string)right.student_date_last_seen,true);
                                  self.DemEduCollRecSpanEv              := right.DemEduCollRecSpanEv;//ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((INTEGER)history_date[1..6]),(string)right.student_date_last_seen,true)-ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate((INTEGER)history_date[1..6]),(string)right.student_date_first_seen,true);
                                  self.DemEduCollRecNewClassEv          := right.DemEduCollRecNewClassEv;//student_college_class;
                                  self.DemEduCollSrcNewExpGradYr        := right.DemEduCollSrcNewExpGradYr;
                                  self.DemEduCollInstPvtFlagEv          := right.DemEduCollInstPvtFlagEv;
                                  self.DemEduCollMajorMedicalFlagEv     := right.DemEduCollMajorMedicalFlagEv;
                                  self.DemEduCollMajorPhysSciFlagEv     := right.DemEduCollMajorPhysSciFlagEv;
                                  self.DemEduCollMajorSocSciFlagEv      := right.DemEduCollMajorSocSciFlagEv;
                                  self.DemEduCollMajorLibArtsFlagEv     := right.DemEduCollMajorLibArtsFlagEv;
                                  self.DemEduCollMajorTechnicalFlagEv   := right.DemEduCollMajorTechnicalFlagEv;
                                  self.DemEduCollMajorBusFlagEv         := right.DemEduCollMajorBusFlagEv;
                                  self.DemEduCollMajorEduFlagEv         := right.DemEduCollMajorEduFlagEv;
                                  self.DemEduCollMajorLawFlagEv         := right.DemEduCollMajorLawFlagEv;

																	// self.HHCollegeAttendedMmbrCnt 	 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_date_first_seen <> '', 1, 0);
																	// self.HHCollege2yrAttendedMmbrCnt 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_code = '2', 1, 0); 
																	// self.HHCollege4yrAttendedMmbrCnt 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_code = '4', 1, 0); 
																	// self.HHCollegeGradAttendedMmbrCnt := if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_code = '1', 1, 0);  
																	// self.HHCollegePrivateMmbrCnt		 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_type = 'P', 1, 0);
																	// self.HHCollegeTierMmbrHighest		 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_tier <> '', (integer)right.student_college_tier, 0);
																	//do not include prospect information in with relatives attributes
																	// self.RaACollegeAttendedMmbrCnt 	 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_date_first_seen <> '', 1, 0);
																	// self.RaACollege2yrAttendedMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_code = '2', 1, 0); 
																	// self.RaACollege4yrAttendedMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_code = '4', 1, 0); 
																	// self.RaACollegeGradAttendedMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_code = '1', 1, 0);  
																	// self.RaACollegePrivateMmbrCnt		 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_type = 'P', 1, 0);
																	// self.RaACollegeTopTierMmbrCnt		 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_tier in ['1','2'], 1, 0);
																	// self.RaACollegeMidTierMmbrCnt		 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_tier in ['3','4'], 1, 0);
																	// self.RaACollegeLowTierMmbrCnt		 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_tier in ['5','6'], 1, 0);
																	self := left;
                                  self := []), left outer, parallel);

//--------- Watercraft-------------//

  	watercraftRecs := ProfileBooster.V2_Key_getWatercraft(slimShell);
   	
   	withWatercraft := join(withStudent, watercraftRecs,
   												left.seq = right.seq and
   												left.did2 = right.did2,
   												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
 																	self.AstPropWtrcrftCntEv  	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.watercraftCount, 0);
																	self.PPCurrOwner 						:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, if(right.watercraftCount > 0, 1, left.PPCurrOwner), left.PPCurrOwner);
																	self.PPCurrOwnedCnt 				:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, left.PPCurrOwnedCnt + right.watercraftCount, left.PPCurrOwnedCnt);
																	self.LifeAstPurchOldMsnc	  := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, max(left.LifeAstPurchOldMsnc, right.months_first_reg), left.LifeAstPurchOldMsnc);
																	//we want most recent purchase here so keep smallest number of months back but disregard 0
																	self.LifeAstPurchNewMsnc		:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, map(right.months_first_reg <= 0	=> left.LifeAstPurchNewMsnc,
																																																 left.LifeAstPurchNewMsnc <= 0	=> right.months_last_reg,
																																																 min(left.LifeAstPurchNewMsnc,right.months_last_reg)),
																																						left.LifeAstPurchNewMsnc);
/*                                     self.AstPropWtrcrftCntEv 	:= right.watercraftCount;
      																	self.PPCurrOwner 					:= if(right.watercraftCount > 0, 1, left.PPCurrOwner);
      																	self.PPCurrOwnedCnt 			:= left.PPCurrOwnedCnt + right.watercraftCount;
      																	self.LifeAstPurchOldMsnc	:= max(left.LifeAstPurchOldMsnc, right.months_first_reg);
      																	// we want most recent purchase here so keep smallest number of months back but disregard 0
      																	self.LifeAstPurchNewMsnc		:= map(right.months_first_reg <= 0	  => left.LifeAstPurchNewMsnc,
      																																		 left.LifeAstPurchNewMsnc <= 0	=> right.months_last_reg,
      																																																     min(left.LifeAstPurchNewMsnc,right.months_last_reg));
*/
   																	// self.HHPPCurrOwnedCnt 				:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], left.HHPPCurrOwnedCnt + right.watercraftCount, left.HHPPCurrOwnedCnt);  //sum all personal prop for household member
   																	// self.HHAstPropWtrcrftCntEv	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.watercraftCount, 0);
   																	// self.RaAPPCurrOwnerMmbrCnt				:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.watercraftCount > 0, 1, left.RaAPPCurrOwnerMmbrCnt); //flag if relative owns any personal prop
   																	// self.RaAPPCurrOwnerWtrcrftMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.watercraftCount > 0, 1, 0);
   																	self := left), left outer, parallel);

																	
//--------- Aircraft -------------//

   	aircraftRecs := ProfileBooster.V2_Key_getAircraft(slimShell);
   	
   	withAircraft := join(withWatercraft, aircraftRecs,
   												left.seq = right.seq and
   												left.did2 = right.did2,
   												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	self.AstPropAirCrftCntEv	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.aircraftCount, 0);
																	self.PPCurrOwner 					:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, if(right.aircraftCount > 0, 1, left.PPCurrOwner), left.PPCurrOwner);
																	self.PPCurrOwnedCnt 			:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, left.PPCurrOwnedCnt + right.aircraftCount, left.PPCurrOwnedCnt);
																	self.LifeAstPurchOldMsnc	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, max(left.LifeAstPurchOldMsnc, right.months_first_reg), left.LifeAstPurchOldMsnc);
																	//we want most recent purchase here so keep smallest number of months back but disregard 0
																	self.LifeAstPurchNewMsnc	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, 
																																						map(right.months_first_reg <= 0	  => left.LifeAstPurchNewMsnc,
																																								left.LifeAstPurchNewMsnc <= 0	=> right.months_last_reg,
																																																								 min(left.LifeAstPurchNewMsnc,right.months_last_reg)),
																																						    left.LifeAstPurchNewMsnc);
																	// self.HHPPCurrOwnedCnt 				:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], left.HHPPCurrOwnedCnt + right.aircraftCount, left.HHPPCurrOwnedCnt);	//sum all personal prop for household member
																	// self.HHPPCurrOwnedAircrftCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.aircraftCount, 0);
																	// self.RaAPPCurrOwnerMmbrCnt				 := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.aircraftCount > 0, 1, left.RaAPPCurrOwnerMmbrCnt);	//flag if relative owns any personal prop
																	// self.RaAPPCurrOwnerAircrftMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.aircraftCount > 0, 1, 0);


/*    																	self.AstPropAirCrftCntEv	  := right.aircraftCount;
      																	self.PPCurrOwner 						:= if(right.aircraftCount > 0, 1, left.PPCurrOwner);
      																	self.PPCurrOwnedCnt 				:= left.PPCurrOwnedCnt + right.aircraftCount;
      																	self.LifeAstPurchOldMsnc	  := max(left.LifeAstPurchOldMsnc, right.months_first_reg);
      																	//we want most recent purchase here so keep smallest number of months back but disregard 0
      																	self.LifeAstPurchNewMsnc		:= map(right.months_first_reg <= 0	=> left.LifeAstPurchNewMsnc,
      																																		 left.LifeAstPurchNewMsnc <= 0	=> right.months_last_reg,
      																																		 min(left.LifeAstPurchNewMsnc,right.months_last_reg));
      																	// self.HHPPCurrOwnedCnt 				:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], left.HHPPCurrOwnedCnt + right.aircraftCount, left.HHPPCurrOwnedCnt);	//sum all personal prop for household member
      																	// self.HHAstPropAirCrftCntEv	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.aircraftCount, 0);
      																	// self.RaAPPCurrOwnerMmbrCnt				 := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.aircraftCount > 0, 1, left.RaAPPCurrOwnerMmbrCnt);	//flag if relative owns any personal prop
      																	// self.RaAPPCurrOwnerAircrftMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.aircraftCount > 0, 1, 0);
*/
   																	self := left), left outer, parallel);		
   

//--------- Vehicles -------------//

   	vehicleRecs := ProfileBooster.V2_Key_getVehicles(slimShell);
   	
   	withVehicles := join(withAircraft, vehicleRecs,
   												left.seq = right.seq and
   												left.did2 = right.did2,
   												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
 																	self.PPCurrOwnedAutoCnt					:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.vehicleCount, 0);
																	self.PPCurrOwnedMtrcycleCnt			:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.motorcycleCount, 0);
																	self.PPCurrOwner 								:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, if(right.vehicleCount + right.motorcycleCount > 0, 1, left.PPCurrOwner), left.PPCurrOwner);
																	self.PPCurrOwnedCnt 						:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, left.PPCurrOwnedCnt + right.vehicleCount + right.motorcycleCount, left.PPCurrOwnedCnt);
																	self.LifeAstPurchOldMsnc	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, max(left.LifeAstPurchOldMsnc, right.months_first_reg), left.LifeAstPurchOldMsnc);
																	//we want most recent purchase here so keep smallest number of months back but disregard 0
																	self.LifeAstPurchNewMsnc		:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, 
																																						map(right.months_first_reg <= 0						=> left.LifeAstPurchNewMsnc,
																																								left.LifeAstPurchNewMsnc <= 0	        => right.months_last_reg,
																																																												 min(left.LifeAstPurchNewMsnc,right.months_last_reg)),
																																						left.LifeAstPurchNewMsnc);
																	self.HHPPCurrOwnedCnt 					:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], left.HHPPCurrOwnedCnt + right.vehicleCount + right.motorcycleCount, left.HHPPCurrOwnedCnt);
																	self.HHPPCurrOwnedAutoCnt				:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.vehicleCount, 0);
																	self.HHPPCurrOwnedMtrcycleCnt		:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.motorcycleCount, 0);
																	self.RaAPPCurrOwnerMmbrCnt				 := if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.vehicleCount + right.motorcycleCount > 0, 1, left.RaAPPCurrOwnerMmbrCnt), left.RaAPPCurrOwnerMmbrCnt);
																	self.RaAPPCurrOwnerAutoMmbrCnt 		 := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.vehicleCount > 0, 1, 0);
																	self.RaAPPCurrOwnerMtrcycleMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.motorcycleCount > 0, 1, 0);
                          
                          
                          
                          
                          
/*    																	self.PPCurrOwnedAutoCnt					:= right.vehicleCount;
      																	self.PPCurrOwnedMtrcycleCnt			:= right.motorcycleCount;
      																	self.PPCurrOwner 								:= if(right.vehicleCount + right.motorcycleCount > 0, 1, left.PPCurrOwner);
      																	self.PPCurrOwnedCnt 						:= left.PPCurrOwnedCnt + right.vehicleCount + right.motorcycleCount;
      																	self.LifeAstPurchOldMsnc	      := max(left.LifeAstPurchOldMsnc, right.months_first_reg);
      																	//we want most recent purchase here so keep smallest number of months back but disregard 0
      																	self.LifeAstPurchNewMsnc		:= map(right.months_first_reg <= 0					    => left.LifeAstPurchNewMsnc,
      																																								left.LifeAstPurchNewMsnc <= 0	=> right.months_last_reg,
      																																																								 min(left.LifeAstPurchNewMsnc,right.months_last_reg));
      																	// self.HHPPCurrOwnedCnt 					:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], left.HHPPCurrOwnedCnt + right.vehicleCount + right.motorcycleCount, left.HHPPCurrOwnedCnt);
      																	// self.HHPPCurrOwnedAutoCnt				:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.vehicleCount, 0);
      																	// self.HHPPCurrOwnedMtrcycleCnt		:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.motorcycleCount, 0);
      																	// self.RaAPPCurrOwnerMmbrCnt				 := if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.vehicleCount + right.motorcycleCount > 0, 1, left.RaAPPCurrOwnerMmbrCnt), left.RaAPPCurrOwnerMmbrCnt);
      																	// self.RaAPPCurrOwnerAutoMmbrCnt 		 := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.vehicleCount > 0, 1, 0);
      																	// self.RaAPPCurrOwnerMtrcycleMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.motorcycleCount > 0, 1, 0);
      		
      																	// SELF.PPCurrOwnedAutoVIN := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoVIN, '');
      																	// self.PPCurrOwnedAutoYear  := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoYear, '');
      																	// self.PPCurrOwnedAutoMake := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoMake, '');
      																	// self.PPCurrOwnedAutoModel := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoModel, '');
      																	// self.PPCurrOwnedAutoSeries := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoSeries, '');
      																	// self.PPCurrOwnedAutoType := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoType, '');
*/
   	
   																	self := left																	
   																	), left outer, parallel);	
   

//--------- Derogs -------------//

 	  preDerogs := group(project(slimShell,  
   												transform(Risk_Indicators.layouts.layout_derogs_input,
   																	self.seq 					:= left.seq;
   																	self.did 					:= left.did2;
   																	self.historydate 	:= left.historydate;
   																	self 							:= [])), seq);
   	
   	derogRecs := ProfileBooster.V2_Key_getDerogs_Hist(preDerogs);
   
   	withDerogs := join(withVehicles, derogRecs,
   												left.seq = right.seq and
   												left.did2 = right.did,
   												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
   																	totalCourtRecs := sum(right.BJL.filing_count7y, right.BJL.eviction_count, right.BJL.felony_count, 
   																												right.BJL.liens_recent_unreleased_count, right.BJL.liens_historical_unreleased_count, 
   																												right.BJL.nonfelony_criminal_count); 
   																	
   																	self.DrgCnt7Y			:= totalCourtRecs;
                                    self.DrgSeverityIndx7Y	:= map(right.BJL.felony_count > 0																=> 5,
   																																 right.BJL.eviction_count > 0															=> 4,
   																																 right.BJL.liens_recent_unreleased_count 
                                                                     + right.BJL.liens_historical_unreleased_count > 0      => 3,
   																																 right.BJL.nonfelony_criminal_count > 0 									=> 2,
   																																 right.BJL.filing_count7y > 0 														=> 1,
   																																																														 0);
   																	
                                       																	
                                    totalCourtRecs12Mo	:= sum(right.BJL.bk_count12, right.BJL.eviction_count12, right.BJL.criminal_count12, 
   																													 right.BJL.liens_unreleased_count12, right.BJL.nonfelony_criminal_count12); 
   																	self.DrgCnt1Y	:= totalCourtRecs12Mo;
   																	lastFelony	  := if(right.BJL.last_felony_date <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.BJL.last_felony_date,true), nines);
   																	lastFelonyCnt := right.BJL.felony_count;
   																	lastCrime		  := if(right.BJL.last_nonfelony_criminal_date <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.BJL.last_nonfelony_criminal_date,true), nines);
   																	lastCrimeCnt  := right.BJL.criminal_count;
   																	lastLien		  := if((integer)right.BJL.last_liens_unreleased_date <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),right.BJL.last_liens_unreleased_date,true), nines);
   																	lastLienCnt   := right.BJL.liens_recent_released_count + right.BJL.liens_historical_released_count;
   																	lastBankrupt  := if(right.BJL.date_last_seen <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.BJL.date_last_seen,true), nines);
   																	lastBankrupt7y := if(right.BJL.date_last_seen <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.BJL.date_last_seen,true), nines);
   																	lastBankruptCnt := right.BJL.filing_count;
   																	lastBankrupt7yCnt := right.BJL.filing_count7y;
   																	lastEviction  := if(right.BJL.last_eviction_date <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.BJL.last_eviction_date,true), nines);
   																	lastEvictionCnt := right.BJL.eviction_count;
   																	lastCourtRec  := min(lastFelony,lastCrime,lastLien,lastBankrupt,lastEviction); 
   																	lastCourtRec7y  := min(lastFelony,lastCrime,lastLien,lastBankrupt7y,lastEviction); 
   																	lastCourtRecCnt := lastFelonyCnt+lastCrimeCnt+lastLienCnt+lastBankruptCnt+lastEvictionCnt;
   																	lastCourtRecCnt7y := lastFelonyCnt+lastCrimeCnt+lastLienCnt+lastBankrupt7yCnt+lastEvictionCnt;
   																	
   																	self.DrgNewMsnc7Y	:= map(totalCourtRecs>0 and lastCourtRec7y<=0 => -99997,
                                                             lastCourtRecCnt7y=0  => -99998,
                                                             lastCourtRec7y=nines => -99997,
                                                             lastCourtRec7y >= 0  => lastCourtRec7y,
                                                                                   -99998);
   																	
   																	self.DrgCrimFelCnt7Y 	  := lastFelonyCnt;
   																	self.DrgCrimFelCnt1Y	  := right.BJL.criminal_Count12;
   																	self.DrgCrimFelNewMsnc7Y	:= map(lastFelonyCnt>0 and lastFelony<=0 => -99997,
                                                                     lastFelonyCnt=0  => -99998,
                                                                     lastFelony=nines => -99997,
                                                                     lastFelony >= 0  => lastFelony,
                                                                                         -99998);
   																	
   																	self.DrgCrimNFelCnt7Y 	:= right.BJL.nonfelony_criminal_count; 
   																	self.DrgCrimNFelCnt1Y	  := right.BJL.nonfelony_criminal_count12; //populates only for FCRA
   																	self.DrgCrimNFelNewMsnc7Y	:= map(right.BJL.nonfelony_criminal_count>0 and lastCrime<=0 => -99997,
                                                                     lastCrimeCnt=0  => -99998,
                                                                     lastCrime=nines => -99997,
                                                                     lastCrime >=0   => lastCrime,
                                                                                        -99998);
   
   																	self.DrgEvictCnt7Y 	    := right.BJL.eviction_count;
   																	self.DrgEvictCnt1Y	    := right.BJL.eviction_count12;
   																	self.DrgEvictNewMsnc7Y	:= map(right.BJL.eviction_count>0 and lastEviction<=0 => -99997,
                                                                     lastEvictionCnt=0  => -99998,
                                                                     lastEviction=nines => -99997,
                                                                     lastEviction >= 0  => lastEviction,
                                                                                           -99998);
   
   																	self.DrgLnJCnt7Y 	      := right.BJL.liens_recent_unreleased_count + right.BJL.liens_historical_unreleased_count;
   																	self.DrgLnJCnt1Y	      := right.BJL.liens_unreleased_count12;
   																	DrgLnJNewMsnc7Y	        := map(right.BJL.liens_recent_unreleased_count + right.BJL.liens_historical_unreleased_count > 0 AND lastLien<=0 => -99997,
                                                                   lastLienCnt=0  => -99998,
                                                                   lastLien=nines => -99997,
                                                                   lastLien >=0   => lastLien,
                                                                                     -99998);
   																	self.DrgLnJNewMsnc7Y	  := DrgLnJNewMsnc7Y;
   																	totalLienAmount	:= sum(right.Liens.liens_unreleased_civil_judgment.total_amount,
   																												 right.Liens.liens_unreleased_federal_tax.total_amount,
   																												 right.Liens.liens_unreleased_foreclosure.total_amount,
   																												 right.Liens.liens_unreleased_landlord_tenant.total_amount,
   																												 right.Liens.liens_unreleased_lispendens.total_amount,
   																												 right.Liens.liens_unreleased_other_lj.total_amount,
   																												 right.Liens.liens_unreleased_other_tax.total_amount,
   																												 right.Liens.liens_unreleased_small_claims.total_amount,
   																												 right.Liens.liens_unreleased_suits.total_amount);
   																	self.DrgLnJAmtTot7Y	:= map((right.BJL.liens_recent_unreleased_count + right.BJL.liens_historical_unreleased_count) > 0 AND lastLien<=0 => -99997,
                                                               totalLienAmount=0 and DrgLnJNewMsnc7Y=-99997 => -99997,
                                                                                                               totalLienAmount);
   																
   																	self.DrgBkCnt10Y 	:= right.BJL.filing_count;
   																	self.DrgBkCnt1Y	  := right.BJL.BK_count12;
   																	self.DrgBkNewMsnc10Y	:= map((INTEGER4)right.BJL.filing_count>0 AND lastBankrupt<=0 => -99997, 
                                                                 (INTEGER4)lastBankruptCnt=0  => -99998,
                                                                 (INTEGER4)lastBankrupt=nines => -99997,
                                                                 lastBankrupt >= 0            => lastBankrupt,
                                                                                                 -99998);
   																	// self.DrgFrClCnt7Y := -99996;                                    
                                    // self.DrgFrClCnt1Y := -99996;                                    
                                    // self.DrgFrClNewMsnc := -99996;                                    
                                    
                                    // self.HHCrtRecMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(totalCourtRecs > 0, 1, 0), 0);
   																	// self.HHCrtRecMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(totalCourtRecs12Mo > 0, 1, 0), 0);
   																	// self.HHCrtRecFelonyMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.felony_Count > 0, 1, 0), 0);
   																	// self.HHCrtRecFelonyMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.criminal_Count12 > 0, 1, 0), 0);
   																	// self.HHCrtRecMsdmeanMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.nonfelony_criminal_count > 0, 1, 0), 0);
   																	// self.HHCrtRecMsdmeanMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.nonfelony_criminal_count12 > 0, 1, 0), 0);
   																	// self.HHCrtRecEvictionMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.eviction_count > 0, 1, 0), 0);
   																	// self.HHCrtRecEvictionMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.eviction_count12 > 0, 1, 0), 0);
   																	// self.HHCrtRecLienJudgMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.liens_recent_unreleased_count + right.BJL.liens_historical_unreleased_count > 0, 1, 0), 0);
   																	// self.HHCrtRecLienJudgMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.liens_unreleased_count12 > 0, 1, 0), 0);
   																	// self.HHDrgLnJAmtTot	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], totalLienAmount, 0);
   																	// self.HHCrtRecBkrptMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.filing_count > 0, 1, 0), 0);
   																	// self.HHCrtRecBkrptMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.BK_count12 > 0, 1, 0), 0);
   																	// self.HHCrtRecBkrptMmbrCnt24Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.BK_count24 > 0, 1, 0), 0);
   
   																	// self.RaACrtRecMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(totalCourtRecs > 0, 1, 0), 0);
   																	// self.RaACrtRecMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(totalCourtRecs12Mo > 0, 1, 0), 0);
   																	// self.RaACrtRecFelonyMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.felony_Count > 0, 1, 0), 0);
   																	// self.RaACrtRecFelonyMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.criminal_Count12 > 0, 1, 0), 0);
   																	// self.RaACrtRecMsdmeanMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.nonfelony_criminal_count > 0, 1, 0), 0);
   																	// self.RaACrtRecMsdmeanMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.nonfelony_criminal_count12 > 0, 1, 0), 0);
   																	// self.RaACrtRecEvictionMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.eviction_count > 0, 1, 0), 0);
   																	// self.RaACrtRecEvictionMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.eviction_count12 > 0, 1, 0), 0);
   																	// self.RaACrtRecLienJudgMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.liens_recent_unreleased_count + right.BJL.liens_historical_unreleased_count > 0, 1, 0), 0);
   																	// self.RaACrtRecLienJudgMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.liens_unreleased_count12 > 0, 1, 0), 0);
   																	//take the highest of the lien amounts but cap at 9,999,999
   																	// RaACrtRecLienJudgAmtMax  := max(
   																																	 // right.Liens.liens_unreleased_federal_tax.total_amount,
   																																	 // right.Liens.liens_unreleased_foreclosure.total_amount,
   																																	 // right.Liens.liens_unreleased_landlord_tenant.total_amount,
   																																	 // right.Liens.liens_unreleased_lispendens.total_amount,
   																																	 // right.Liens.liens_unreleased_other_lj.total_amount,
   																																	 // right.Liens.liens_unreleased_other_tax.total_amount,
   																																	 // right.Liens.liens_unreleased_small_claims.total_amount,
   																																	 // right.Liens.liens_unreleased_suits.total_amount);
   																	// self.RaACrtRecLienJudgAmtMax  := if(left.rec_type = ProfileBooster.Constants.recType.Relative, min(RaACrtRecLienJudgAmtMax, nines), 0); 
   																	// self.RaACrtRecBkrptMmbrCnt36Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.BK_count36 > 0, 1, 0), 0);
																	   self.ProfLicActivNewIndx := -99998;
																	   self.ProfLicActvNewTitleType := '-99998';
																	   self := left), left outer, parallel);	

//--------- Professional License -------------//

	profLicRecs := ProfileBooster.V2_Key_getProfLic(slimShell);
      	
    withProfLic := join(withDerogs, profLicRecs,
      												left.seq = right.seq and
      												left.did2 = right.did,
      												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
      																	self.ProfLicFlagEv      	 := IF(right.professional_license_flag,1,0);
      																	self.ProfLicActivNewIndx     := map(right.did2 <= 0		    => -99998,
																			                                right.PLcategory IN ['1','2','3','4','5'] => (integer3)right.PLcategory, 
																		                                                               -99997);
                                                                        self.ProfLicActvNewTitleType := map(right.did2 <= 0		    => '-99998',
																			                                ((integer)right.ActiveNewTitleType) BETWEEN 0 and 183 AND right.ActiveNewTitleType <> '' => right.ActiveNewTitleType, 
																		                                                               '-99997');
																		self.BusAssocOldMSnc := -99998;
																		self.BusLeadershipTitleFlag := -99998;
                                       									// self.HHOccProfLicMmbrCnt 		:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.professional_license_flag=true, 1, 0);  
      																	// self.RaAOccProfLicMmbrCnt		:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.professional_license_flag=true, 1, 0); 
      																	self := left), left outer, parallel);

   
   //--------- People at Work -------------//
   
   	busnAssocRecs := ProfileBooster.V2_Key_getBusnAssoc(slimShell);
   	
   	withBusnAssoc := join(withProfLic, busnAssocRecs,
   	// withBusnAssoc := join(withProfLic, busnAssocRecs,
   												left.seq = right.seq and
   												left.did2 = right.did2,
   												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
   																	self.BusAssocFlagEv         	:= if(right.did2<>0, right.BusAssocFlagEv, 0);	
   																	self.BusAssocOldMSnc          	:= if(right.did2<>0, right.BusAssocOldMSnc, -99998);
   																	self.BusLeadershipTitleFlag    	:= if(right.did2<>0, right.BusLeadershipTitleFlag, -99998);
                                                                    self.BusAssocCntEv              := if(right.did2<>0, right.BusAssocCntEv, 0);
                                                                    // self.HHOccBusinessAssocMmbrCnt 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.OccBusinessAssociation = 1, 1, 0);  
   																	// self.RaAOccBusinessAssocMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.OccBusinessAssociation = 1, 1, 0); 
																	self.BusUCCFilingCntEv          := -99998;
																	self.BusUCCFilingActiveCnt	    := -99998;
   																	self := left), left outer, parallel);

   //--------------- UCC Filings -------------//
   uccFilings := ProfileBooster.V2_Key_getUCCFiling(slimShell);

   withUccFilings := join(withBusnAssoc, uccFilings,
   												left.seq = right.seq and
   												left.did2 = right.did2,
   												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
   																	self.BusUCCFilingCntEv          := if(right.did2<>0, right.BusUCCFilingCntEv, -99998);
                                                                    self.BusUCCFilingActiveCnt      := if(right.did2<>0, right.BusUCCFilingActiveCnt, -99998);
																	self := left), left outer, parallel);


//--------- Outdoor sports -------------//

	sportsRecs := ProfileBooster.V2_Key_getSports(slimShell);
	
	withSports_temp := join(withUccFilings, sportsRecs,
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	self.IntSportPersonFlagEv 						:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.IntSportPersonFlagEv, 0);	
																	self.IntSportPersonFlag1Y 						:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.IntSportPersonFlag1Y, 0);	
																	self.IntSportPersonFlag5Y 						:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.IntSportPersonFlag5Y, 0);	
																	self.IntSportPersonTravelerFlagEv			:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.IntSportPersonTravelerFlagEv, 0);	
																	// self.HHInterestSportPersonMmbrCnt 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.sportsInterest = 1, 1, 0);  
																	// self.RaAInterestSportPersonMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.sportsInterest = 1, 1, 0); 
																	self := left), left outer, parallel);
	with_Sports_thor := withSports_temp;// : PERSIST('~PROFILEBOOSTER::with_Sports_thor::' + prt) ;  // try adding another stopping point here to help out  // remove persists because low on disk space and it's rebuilding persist file each time anyway

	#IF(onThor)
		withSports := with_Sports_thor;
	#ELSE
		withSports := withSports_temp;
	#END

//--------- Property -------------//

	includeRelativeInfo := false;
	filter_out_fares		:= true;	//Fares data is restricted from use in any Marketing product

//for prospect pass input address, current address and previous address into property common function as we need info for all
  Risk_Indicators.Layout_PropertyRecord get_addresses(withCurrBus le, integer c) := TRANSFORM
    self.fname 				:= le.fname;
    self.lname 				:= le.lname;
    self.prim_range 	:= choose(c,le.prim_range,
													    		le.curr_prim_range,
													    		le.prev_prim_range);
    self.prim_name 		:= choose(c,le.prim_name,
																	le.curr_prim_name,
																	le.prev_prim_name);
    self.st 					:= choose(c,le.st,
																	le.curr_st,
																	le.prev_st);
		self.city_name 		:= choose(c,le.p_city_name,
																	le.curr_city_name,
																	le.prev_city_name);
	  self.zip5 				:= choose(c,le.z5,
																	le.curr_z5,
																	le.prev_z5);
  	self.predir 			:= choose(c,le.predir,
																	le.curr_predir,
																	le.prev_predir);
	  self.postdir 			:= choose(c,le.postdir,
																	le.curr_postdir,
																	le.prev_postdir);
	  self.addr_suffix 	:= choose(c,le.addr_suffix,
																	le.curr_addr_suffix,
																	le.prev_addr_suffix);
	  self.sec_range 		:= choose(c,le.sec_range,
																	le.curr_sec_range,
																	le.prev_sec_range);
	  self.county 			:= choose(c,le.county,
																	le.curr_county,
																	le.prev_county);
	  self.geo_blk 			:= choose(c,le.geo_blk,
																	le.curr_geo_blk,
																	le.prev_geo_blk);
    self.did 					:= le.did2;
    self.seq 					:= le.seq;
		self.historydate 	:= le.historydate;
    self 							:= [];
  end;
	
  p_address := group(normalize(withCurrBus, 3, get_addresses (LEFT,COUNTER))(prim_name != '', zip5 != ''), seq);
	
	ids_only := group(project(slimShell,  
												transform(Risk_Indicators.Layout_Boca_Shell_ids,
																	self.seq 					:= left.seq;
																	self.did 					:= left.did2;
																	self.historydate 	:= left.historydate;
																	self.isrelat     	:= false;
																	// don't populate the name fields unless the rec_type is the applicant
																	self.fname       	:= if(left.rec_type=1, left.fname, '');
																	self.lname       	:= if(left.rec_type=1, left.lname, '');
																	self.relation    	:= '',																	
																	self              := left;
																	self 							:= [])), seq);

	in_mod_property := MODULE(LN_PropertyV2_Services.interfaces.Iinput_report)		
			SHARED LN_PropertyV2_Services.interfaces.layout_entity buildEntity1() :=
				TRANSFORM
					// SELF.firstname        := with_DID[1].fname;
					// SELF.middlename       := with_DID[1].mname;
					// SELF.lastname         := with_DID[1].lname;	
					SELF.firstname        := '';
					SELF.middlename       := '';
					SELF.lastname         := '';
					SELF.unparsedfullname := '';
					SELF.allownicknames   := FALSE;
					SELF.phoneticmatch    := FALSE;
					SELF.companyname      := '';
					SELF.addr             := ''; 
					SELF.sec_range        := ''; 
					SELF.city             := ''; 
					SELF.state            := ''; 
					SELF.zip              := ''; 
					SELF.zipradius        := 0;
					SELF.county           := '';
					SELF.phone            := ''; 
					SELF.fein             := '';
					SELF.bdid             := '';
					SELF.did              := ''; 
					SELF.ssn              := ''; 
				END;

			// Option fields: set each to its default value unless present here in getAllBocaShellData.
			EXPORT faresID                 := '';
			// Data restrictions
			EXPORT data_restriction_mask   := DataRestrictionMask;
			EXPORT srcRestrict             := []; 
			EXPORT currentVend             := FALSE;
			EXPORT currentOnly             := FALSE;
			EXPORT robustnessScoreSorting  := FALSE;
			EXPORT ssn_mask_value          := 'NONE';
			EXPORT application_type_value  := '';
			EXPORT set_AddressFilters      := ALL;
			EXPORT paSearch                := FALSE;
			// Tuning
			EXPORT DisplayMatchedParty_val := FALSE;
			EXPORT pThresh                 := 10;
			EXPORT lookupVal               := '';
			EXPORT partyType               := '';
			EXPORT incDetails              := FALSE;
			EXPORT TwoPartySearch          := FALSE;
			EXPORT xadl2_weight_threshold_value	:= 0;
			// For penalization
			// EXPORT entity1 := ROW(buildEntity1());
			EXPORT entity1 := ROW([],LN_PropertyV2_Services.interfaces.layout_entity); //just send in blanks
			EXPORT entity2 := ROW([],LN_PropertyV2_Services.interfaces.layout_entity);
	END;
	
	

	from_PB     := true; 
	ViewDebugs := false;
	
	prop_common := Risk_Indicators.Boca_Shell_Property_Common(p_address, ids_only(did<>0), includeRelativeInfo, filter_out_fares, IsFCRA, in_mod_property, ViewDebugs, from_PB);
	
ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_property(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell le, prop_common rt) := transform
		//see if the input address or current address came back as an owned address
		isInputAddr												:= le.z5=rt.zip5 and le.prim_range=rt.prim_range and le.prim_name=rt.prim_name;                              
		isCurrAddr												:= le.curr_z5=rt.zip5 and le.curr_prim_range=rt.prim_range and le.curr_prim_name=rt.prim_name;
		isPrevAddr												:= le.prev_z5=rt.zip5 and le.prev_prim_range=rt.prim_range and le.prev_prim_name=rt.prim_name;
		self.sale_date_by_did							:= rt.sale_date_by_did;
		AstPropCurrCntFlag                := rt.property_status_applicant = 'O';		
    validpurchasedate := Doxie.DOBTools(rt.purchase_date_by_did).IsValidDOB;
		monthsSincePurchased							:= if(~validpurchasedate, 0, min(ProfileBooster.Common.MonthsApart_YYYYMMDD((string)rt.purchase_date_by_did,risk_indicators.iid_constants.myGetDate(le.historydate),true),960));
    LifeAstPurchOldMsnc	        := max(le.LifeAstPurchOldMsnc, monthsSincePurchased);
		LifeAstPurchNewMsnc	        := map(monthsSincePurchased <= 0	 => le.LifeAstPurchNewMsnc,
																			 le.LifeAstPurchNewMsnc <= 0 => monthsSincePurchased,
																																			min(le.LifeAstPurchNewMsnc,monthsSincePurchased));
    self.AstCurrFlag    							:= if(le.AstCurrFlag =1 OR AstPropCurrCntFlag or LifeAstPurchOldMsnc>0 or (LifeAstPurchNewMsnc>0 and LifeAstPurchNewMsnc<>99998), 1, 0);
    self.AstPropCurrFlag							:= if(AstPropCurrCntFlag, 1, 0);
    self.AstPropCurrCntEv							:= if(AstPropCurrCntFlag, 1, 0);
		self.AstPropCurrValTot			      := if(rt.property_status_applicant = 'O', rt.assessed_amount, 0);
		validsaledate := Doxie.DOBTools(rt.sale_date_by_did).IsValidDOB;
		monthsSinceSold 									:= if(~validsaledate, nines, min(ProfileBooster.Common.MonthsApart_YYYYMMDD((string)rt.sale_date_by_did,risk_indicators.iid_constants.myGetDate(le.historydate),true),960));
		self.AstPropSaleNewMsnc						:= map(// ~AstPropCntEvFlag => -99998,
                                             // ~AstPropCurrCntFlag => -99998,
                                             monthsSinceSold=nines => -99997,
                                             /*le.rec_type=ProfileBooster.Constants.recType.Prospect and */
                                             validsaledate => monthsSinceSold, 
                                             -99997);
    AstPropCntEvFlag                  := rt.property_status_applicant in ['O','S'];	
    self.AstPropCntEv							    := if(AstPropCntEvFlag, 1, 0);
		self.AstPropSoldCntEv							:= if(rt.property_status_applicant = 'S', 1, 0);
		self.AstPropSoldCnt1Y							:= if(validsaledate and monthsSinceSold <= 12, 1, 0);
		salePrice													:= if(rt.sale_price1<>0, rt.sale_price1, rt.sale_price2);
		self.AstPropSoldNewRatio := map(rt.purchase_amount = 0 or salePrice = 0 => '-99997',
                                    ~AstPropCntEvFlag => '-99998',
														        trim((string)(decimal4_2)min(salePrice / rt.purchase_amount, 99.0)));
		self.AstPropPurchCnt1Y					  := if(monthsSincePurchased <> 0 and monthsSincePurchased <= 12, 1, 0);
		self.LifeAstPurchOldMsnc	        := LifeAstPurchOldMsnc;
		self.LifeAstPurchNewMsnc	        := LifeAstPurchNewMsnc;	
		self.CurrAddrOwnershipIndx				:= map(isCurrAddr and rt.property_status_applicant = 'O' and rt.naprop = 4				  => 4,
																								isCurrAddr and rt.naprop = 3																							=> 3,
																								isCurrAddr and rt.occupant_owned																					=> 2,
																								isCurrAddr and rt.property_status_applicant <> 'O'												=> 1,
																																																													   0);
		self.ResCurrMortgageType					:= map(~isCurrAddr	=>	'-1', 
																						 rt.type_financing = 'ADJ'																							=>	'1',
																						 rt.type_financing = 'CNV'																							=>	'2',
																						 rt.type_financing <> ''																								=>	'0',
																																																													'-1');
		self.ResCurrMortgageAmount				:= if(isCurrAddr, rt.mortgage_amount, 0);
		self.InpAddrOwnershipIndx				  := map(isInputAddr and rt.property_status_applicant = 'O' and rt.naprop = 4			=> 4,
																								isInputAddr and rt.naprop = 3																							=> 3,
																								isInputAddr and rt.occupant_owned																					=> 2,
																								isInputAddr and rt.property_status_applicant <> 'O'												=> 1,
																																																														 0);
		self.ResInputMortgageType					:= map(~isInputAddr	=>	'-1', 
																						 rt.type_financing = 'ADJ'																							=>	'1',
																						 rt.type_financing = 'CNV'																							=>	'2',
																						 rt.type_financing <> ''																								=>	'0',
																																																													'-1');
		self.ResInputMortgageAmount				:= if(isInputAddr, rt.mortgage_amount, 0);																	
		// self.HHAstPropCurrFlagMmbrCnt			 	:= if(le.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and rt.property_status_applicant = 'O', 1, 0);  
		// self.HHAstPropCurrCntEv					 	:= if(le.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and rt.property_status_applicant = 'O', 1, 0); 
		// self.RaAAstPropCurrFlagMmbrCnt			:= if(le.rec_type = ProfileBooster.Constants.recType.Relative and rt.property_status_applicant = 'O', 1, 0);
		self.owned_prim_range							:= if(rt.property_status_applicant = 'O', rt.prim_range, '');
		self.owned_predir									:= if(rt.property_status_applicant = 'O', rt.predir, '');
		self.owned_prim_name							:= if(rt.property_status_applicant = 'O', rt.prim_name, '');
		self.owned_addr_suffix						:= if(rt.property_status_applicant = 'O', rt.addr_suffix, '');
		self.owned_postdir								:= if(rt.property_status_applicant = 'O', rt.postdir, '');
		self.owned_unit_desig							:= if(rt.property_status_applicant = 'O', rt.unit_desig, '');
		self.owned_sec_range							:= if(rt.property_status_applicant = 'O', rt.sec_range, '');
		self.owned_z5											:= if(rt.property_status_applicant = 'O', rt.zip5, '');
		self.owned_city_name							:= if(rt.property_status_applicant = 'O', rt.city_name, '');
		self.owned_st											:= if(rt.property_status_applicant = 'O', rt.st, '');
		
		self.sold_prim_range							:= if(rt.property_status_applicant = 'S', rt.prim_range, '');
		self.sold_predir									:= if(rt.property_status_applicant = 'S', rt.predir, '');
		self.sold_prim_name								:= if(rt.property_status_applicant = 'S', rt.prim_name, '');
		self.sold_addr_suffix							:= if(rt.property_status_applicant = 'S', rt.addr_suffix, '');
		self.sold_postdir									:= if(rt.property_status_applicant = 'S', rt.postdir, '');
		self.sold_unit_desig							:= if(rt.property_status_applicant = 'S', rt.unit_desig, '');
		self.sold_sec_range								:= if(rt.property_status_applicant = 'S', rt.sec_range, '');
		self.sold_z5											:= if(rt.property_status_applicant = 'S', rt.zip5, '');
		self.sold_city_name								:= if(rt.property_status_applicant = 'S', rt.city_name, '');
		self.sold_st											:= if(rt.property_status_applicant = 'S', rt.st, '');
		
		self.curr_AssessedAmount					:= if(isCurrAddr, rt.assessed_amount, 0);
		self.prev_AssessedAmount					:= if(isPrevAddr, rt.assessed_amount, 0);
		self := le;
	end;
	
	withProperty_roxie := join(withSports, prop_common,
												left.seq = right.seq and
												left.did2 = right.did,
												append_property(left, right), left outer, parallel);

	
withSports_distr := distribute(withSports, did2);
prop_common_distr := distribute(prop_common, did);
	
	withProperty_thor := join(withSports_distr, prop_common_distr,
												left.did2 = right.did,
												append_property(left, right), left outer, local)
												;
	// : PERSIST('~PROFILEBOOSTER::withProperty_thor');// remove persists because low on disk space and it's rebuilding persist file each time anyway
	
	#IF(onThor)
		withProperty := withProperty_thor;
	#ELSE
		withProperty := withProperty_roxie;
	#END
	
	withProperty_distributed := distribute(withProperty, seq);
	sortedProperty :=  sort(withProperty, seq, did2, -sale_date_by_did, -owned_prim_range, -owned_prim_name, local); //within DID, sort most recent sold property to top

	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell rollProperty(sortedProperty le, sortedProperty ri) := TRANSFORM
		same_prop := le.owned_prim_range=ri.owned_prim_range and le.owned_prim_name=ri.owned_prim_name;
		same_sold_prop := le.sold_prim_range = ri.sold_prim_range AND le.sold_prim_name = ri.sold_prim_name;
		
		self.AstCurrFlag								    := max(le.AstCurrFlag, ri.AstCurrFlag);
		self.AstPropCurrFlag								:= max(le.AstPropCurrFlag, ri.AstPropCurrFlag);
		self.AstPropCurrCntEv						  	:= le.AstPropCurrCntEv + if(same_prop, 0, ri.AstPropCurrCntEv);
		self.AstPropCurrValTot			        := le.AstPropCurrValTot + if(same_prop, 0, ri.AstPropCurrValTot);
		self.AstPropSaleNewMsnc							:= MAP(le.AstPropSaleNewMsnc >= 0 AND ri.AstPropSaleNewMsnc >= 0 => min(le.AstPropSaleNewMsnc, ri.AstPropSaleNewMsnc),
                                               le.AstPropSaleNewMsnc >= 0 AND ri.AstPropSaleNewMsnc < 0  => le.AstPropSaleNewMsnc,
                                               le.AstPropSaleNewMsnc < 0  AND ri.AstPropSaleNewMsnc >= 0 => ri.AstPropSaleNewMsnc,
                                               -99998);
		self.AstPropCntEv							      := le.AstPropCntEv + if(same_prop, 0, ri.AstPropCntEv);
		self.AstPropSoldCntEv							  := le.AstPropSoldCntEv + if(same_sold_prop, 0, ri.AstPropSoldCntEv);
		self.AstPropSoldCnt1Y							  := le.AstPropSoldCnt1Y + if(same_sold_prop, 0, ri.AstPropSoldCnt1Y);
		self.AstPropSoldNewRatio						:= le.AstPropSoldNewRatio; //most recent was sorted first so always just keep the left
		self.AstPropPurchCnt1Y					    := le.AstPropPurchCnt1Y + if(same_prop, 0, ri.AstPropPurchCnt1Y);
		self.LifeAstPurchOldMsnc	          := max(le.LifeAstPurchOldMsnc, ri.LifeAstPurchOldMsnc);
		self.LifeAstPurchNewMsnc	          := map(ri.LifeAstPurchNewMsnc <= 0	=> le.LifeAstPurchNewMsnc,
																						   le.LifeAstPurchNewMsnc <= 0	=> ri.LifeAstPurchNewMsnc,
																																									 min(le.LifeAstPurchNewMsnc, ri.LifeAstPurchNewMsnc));
		self.CurrAddrOwnershipIndx			 	  := max(le.CurrAddrOwnershipIndx, ri.CurrAddrOwnershipIndx);  
		self.ResCurrMortgageType					  := if(ri.ResCurrMortgageType <> '', ri.ResCurrMortgageType, le.ResCurrMortgageType);
		self.ResCurrMortgageAmount				  := max(le.ResCurrMortgageAmount, ri.ResCurrMortgageAmount);
		self.InpAddrOwnershipIndx			 	    := max(le.InpAddrOwnershipIndx, ri.InpAddrOwnershipIndx);  
		self.ResInputMortgageType					  := if(ri.ResInputMortgageType <> '', ri.ResInputMortgageType, le.ResInputMortgageType);
		self.ResInputMortgageAmount				  := max(le.ResInputMortgageAmount, ri.ResInputMortgageAmount);
		self.curr_AssessedAmount					  := max(le.curr_AssessedAmount, ri.curr_AssessedAmount);
		self.prev_AssessedAmount					  := max(le.prev_AssessedAmount, ri.prev_AssessedAmount);
		// self.HHAstPropCurrFlagMmbrCnt			 	:= max(le.HHAstPropCurrFlagMmbrCnt, ri.HHAstPropCurrFlagMmbrCnt);  
		// self.HHAstPropCurrCntEv					 	:= le.HHAstPropCurrCntEv + if(same_prop, 0, ri.HHAstPropCurrCntEv); 
		// self.RaAAstPropCurrFlagMmbrCnt			:= max(le.RaAAstPropCurrFlagMmbrCnt, ri.RaAAstPropCurrFlagMmbrCnt);
		self								 							  := le;
	END;

	rolledProperty :=  rollup(sortedProperty, left.seq = right.seq and left.did2 = right.did2,
											rollProperty(left, right));

//--------- AVM -------------//

	preAVM := group(project(withInfutor,  // withInfutor contains only Prospect records...we don't need HH or relatives info
												transform(Risk_Indicators.layout_bocashell_neutral,
																	self.seq 					:= left.seq;
																	self.did 					:= left.did;
																	self.historydate 	:= left.historydate;
																	self.isrelat     	:= false;
																	self.fname       	:= left.fname;
																	self.lname       	:= left.lname;
																	self.address_verification.input_address_information.prim_name   := left.prim_name;
																	self.address_verification.input_address_information.prim_range  := left.prim_range;
																	self.address_verification.input_address_information.zip5			  := left.z5;
																	self.address_verification.input_address_information.st				  := left.st;
																	self.address_verification.input_address_information.predir		  := left.predir;
																	self.address_verification.input_address_information.postdir	    := left.postdir;
																	self.address_verification.input_address_information.addr_suffix := left.addr_suffix;
																	self.address_verification.input_address_information.sec_range	  := left.sec_range;
																	self.address_verification.input_address_information.county	  	:= left.county;
																	self.address_verification.input_address_information.geo_blk	  	:= left.geo_blk;
																	self.address_verification.address_history_1.prim_name   				:= left.curr_prim_name;
																	self.address_verification.address_history_1.prim_range  				:= left.curr_prim_range;
																	self.address_verification.address_history_1.zip5			  				:= left.curr_z5;
																	self.address_verification.address_history_1.st				  				:= left.curr_st;
																	self.address_verification.address_history_1.predir		  				:= left.curr_predir;
																	self.address_verification.address_history_1.postdir	    				:= left.curr_postdir;
																	self.address_verification.address_history_1.addr_suffix 				:= left.curr_addr_suffix;
																	self.address_verification.address_history_1.sec_range	  				:= left.curr_sec_range;
																	self.address_verification.address_history_1.county	  					:= left.curr_county;
																	self.address_verification.address_history_1.geo_blk	  					:= left.curr_geo_blk;
																	self.address_verification.address_history_2.prim_name   				:= left.prev_prim_name;
																	self.address_verification.address_history_2.prim_range  				:= left.prev_prim_range;
																	self.address_verification.address_history_2.zip5			  				:= left.prev_z5;
																	self.address_verification.address_history_2.st				  				:= left.prev_st;
																	self.address_verification.address_history_2.predir		  				:= left.prev_predir;
																	self.address_verification.address_history_2.postdir	    				:= left.prev_postdir;
																	self.address_verification.address_history_2.addr_suffix 				:= left.prev_addr_suffix;
																	self.address_verification.address_history_2.sec_range	  				:= left.prev_sec_range;
																	self.address_verification.address_history_2.county	  					:= left.prev_county;
																	self.address_verification.address_history_2.geo_blk	  					:= left.prev_geo_blk;
																	
																	self 							:= [])), seq);				

	AVMrecs := Risk_Indicators.Boca_Shell_AVM(preAVM);

	withAVM := join(rolledProperty, AVMrecs,
												left.seq = right.seq,// and
												// left.rec_type=ProfileBooster.Constants.recType.Prospect, //we sent only Prospect recs to AVM search so only need to update Prospects here
												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	self.CurrAddrAVMVal 		:= right.address_history_1.avm_automated_valuation;
																	self.CurrAddrAVMValA1Y 	:= right.address_history_1.avm_automated_valuation2;
																	self.CurrAddrAVMRatio1Y := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_automated_valuation2 = 0, 
																																		 '0', 
																																		 trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_automated_valuation2, 99.0)));
																	self.CurrAddrAVMValA5Y 	:= right.address_history_1.avm_automated_valuation6;
																	self.CurrAddrAVMRatio5Y := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_automated_valuation6 = 0, 
																																		 '0', 
																																		 trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_automated_valuation6, 99.0)));
																	self.CurrAddrMedAVMCtyRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_fips_level = 0, 
																																  '0', 
																																	trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_fips_level, 99.0)));
																	self.CurrAddrMedAVMCenTractRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_geo11_level = 0, 
																																	'0', 
																																	trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_geo11_level, 99.0)));
																	self.CurrAddrMedAVMCenBlockRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_geo12_level = 0, 
																																	'0', 
																																	trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_geo12_level, 99.0)));
																	self.InpAddrAVMVal 			:= right.Input_Address_Information.avm_automated_valuation;
																	self.InpAddrAVMValA1Y 	:= right.Input_Address_Information.avm_automated_valuation2;
																	self.InpAddrAVMRatio1Y  := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_automated_valuation2 = 0, 
																																			'0', 
																																			trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_automated_valuation2, 99.0)));
																	self.InpAddrAVMValA5Y 	:= right.Input_Address_Information.avm_automated_valuation6;
																	self.InpAddrAVMRatio5Y  := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_automated_valuation6 = 0, 
																																			'0', 
																																			trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_automated_valuation6, 99.0)));
																	self.InpAddrMedAVMCtyRatio := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_median_fips_level = 0, 
																																	'0', 
																																	trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_median_fips_level, 99.0)));
																	self.InpAddrMedAVMCenTractRatio := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_median_geo11_level = 0, 
																																	 '0', 
																																	 trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_median_geo11_level, 99.0)));
																	self.InpAddrMedAVMCenBlockRatio := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_median_geo12_level = 0, 
																																	 '0', 
																																	 trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_median_geo12_level, 99.0)));
																	self := left), left outer, parallel);
	
	//We need the AVM value of any properties owned by the Prospect, HH members or Relatives...isolate those people/properties here
	propOwners	:= dedup(sort(withProperty(owned_prim_name<>'' and owned_z5<>''),   
														seq, did2, owned_prim_name, owned_prim_range, owned_z5), 
														seq, did2, owned_prim_name, owned_prim_range, owned_z5); 
														
	preAVMOwned := group(project(propOwners,  
												transform(Risk_Indicators.layout_bocashell_neutral,
																	self.seq 					:= left.seq;
																	self.did 					:= left.did2;
																	self.historydate 	:= left.historydate;
																	self.isrelat     	:= false;
																	self.address_verification.input_address_information.prim_name   := left.owned_prim_name;
																	self.address_verification.input_address_information.prim_range  := left.owned_prim_range;
																	self.address_verification.input_address_information.zip5			  := left.owned_z5;
																	self.address_verification.input_address_information.city_name	  := left.owned_city_name;
																	self.address_verification.input_address_information.st				  := left.owned_st;
																	self.address_verification.input_address_information.predir		  := left.owned_predir;
																	self.address_verification.input_address_information.postdir	    := left.owned_postdir;
																	self.address_verification.input_address_information.addr_suffix := left.owned_addr_suffix;
																	self.address_verification.input_address_information.sec_range	  := left.owned_sec_range;
																	self 							:= [])), seq);				

	Layout_AVM := RECORD
		unsigned4 seq;
		unsigned6 DID;
		unsigned3 historydate;
		string10 	prim_range;
		string2  	predir;
		string28  prim_name;
		string2   postdir;
		string8   sec_range;
		string2   st;
		string5   zip;			
		Riskwise.Layouts.Layout_AVM;
	END;

	Layout_AVM add_AVM(preAVMOwned le, avm_v2.Key_AVM_Address ri) := transform
		full_history_date := Risk_Indicators.iid_constants.full_history_date(le.historydate);
		AVM_V2.MOD_get_AVM_from_History.MAC_get_AVM(ri, full_history_date, avm_record);	// updated to get full history
		
		SELF.Input_Address_Information.avm_land_use_code := avm_record.land_use;
		SELF.Input_Address_Information.avm_recording_date := avm_record.recording_date;
		SELF.Input_Address_Information.avm_assessed_value_year := avm_record.assessed_value_year;
		SELF.Input_Address_Information.avm_sales_price := avm_record.sales_price;  
		SELF.Input_Address_Information.avm_assessed_total_value := avm_record.assessed_total_value;
		SELF.Input_Address_Information.avm_market_total_value := avm_record.market_total_value;
		SELF.Input_Address_Information.avm_tax_assessment_valuation := avm_record.tax_assessment_valuation;
		SELF.Input_Address_Information.avm_price_index_valuation := avm_record.price_index_valuation;
		SELF.Input_Address_Information.avm_hedonic_valuation := avm_record.hedonic_valuation;
		SELF.Input_Address_Information.avm_automated_valuation := avm_record.automated_valuation;
		SELF.Input_Address_Information.avm_confidence_score := avm_record.confidence_score;
		
		// new fields
		SELF.Input_Address_Information.avm_automated_valuation2 := avm_record.automated_valuation2;
		SELF.Input_Address_Information.avm_automated_valuation3 := avm_record.automated_valuation3;
		SELF.Input_Address_Information.avm_automated_valuation4 := avm_record.automated_valuation4;
		SELF.Input_Address_Information.avm_automated_valuation5 := avm_record.automated_valuation5;
		SELF.Input_Address_Information.avm_automated_valuation6 := avm_record.automated_valuation6;
		
		SELF.seq := le.seq;
		SELF.DID := le.DID;
		self.historydate := le.historydate;
		SELF.prim_range := ri.prim_range;
		SELF.predir := ri.predir;
		SELF.prim_name := ri.prim_name;
		SELF.postdir := ri.postdir;
		SELF.sec_range := ri.sec_range;
		SELF.st := ri.st;
		SELF.zip := ri.zip;	
	END;
	
	avm1Owned_roxie := join(preAVMOwned, avm_v2.Key_AVM_Address,  
								left.address_verification.input_address_information.prim_name!='' and left.address_verification.input_address_information.zip5!='' and
								keyed(left.address_verification.input_address_information.prim_name = right.prim_name) and
								keyed(left.address_verification.input_address_information.st = right.st) and
								keyed(left.address_verification.input_address_information.zip5 = right.zip) and
								keyed(left.address_verification.input_address_information.prim_range = right.prim_range) and
								keyed(left.address_verification.input_address_information.sec_range = right.sec_range) and	// NNEQ here?
								left.address_verification.input_address_information.predir=right.predir and 
								left.address_verification.input_address_information.postdir=right.postdir,
							add_AVM(left, right),  
									atmost(RiskWise.max_atmost), keep(100));

	avm1Owned_thor := join(
		distribute(preAVMOwned, hash64(address_verification.input_address_information.prim_name,
																address_verification.input_address_information.st,
																address_verification.input_address_information.zip5,
																address_verification.input_address_information.prim_range)), 
		distribute(pull(avm_v2.Key_AVM_Address), hash64(prim_name, st, zip, prim_range)),   
								left.address_verification.input_address_information.prim_name!='' and left.address_verification.input_address_information.zip5!='' and
								left.address_verification.input_address_information.prim_name = right.prim_name and
								left.address_verification.input_address_information.st = right.st and
								left.address_verification.input_address_information.zip5 = right.zip and
								left.address_verification.input_address_information.prim_range = right.prim_range and
								left.address_verification.input_address_information.sec_range = right.sec_range and	// NNEQ here?
								left.address_verification.input_address_information.predir=right.predir and 
								left.address_verification.input_address_information.postdir=right.postdir,
							add_AVM(left, right),  
									atmost(RiskWise.max_atmost), keep(100), 
			local);

	#IF(onThor)
		avm1Owned := group(avm1Owned_thor, seq);
	#ELSE
		avm1Owned := avm1Owned_roxie;
	#END
	
	// when choosing which AVM to output if the addr returns more than 1 result, 
	// always pick the record with the most recent recording date and secondarily the most recent assessed value year
	avms1Owned := dedup(sort(avm1Owned, seq, did, prim_range, prim_name, zip, -Input_Address_Information.avm_recording_date, -Input_Address_Information.avm_assessed_value_year),
																			seq, did, prim_range, prim_name, zip);
	
	withAVMOwned := join(withAVM, avms1Owned,
												left.seq = right.seq and
												left.DID2 = right.DID,
												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	self.AstPropCurrAVMTot 			:= right.Input_Address_Information.avm_automated_valuation;
																	// self.HHPropCurrAVMHighest 		:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.Input_Address_Information.avm_automated_valuation, 0);
																	// self.RaAPropOwnerAVMHighest 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, right.Input_Address_Information.avm_automated_valuation, 0);
																	// self.RaAPropOwnerAVMMed 			:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, right.Input_Address_Information.avm_automated_valuation, 0);
																	self := left), left outer, parallel);

	sortedAVMOwned :=  sort(withAVMOwned, seq, did2); 

	groupAVMOwned := group(sortedAVMOwned(RaAPropOwnerAVMMed<>0), seq);	

	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell rollAVMOwned(sortedAVMOwned le, sortedAVMOwned ri) := TRANSFORM
		self.AstPropCurrAVMTot					:= le.AstPropCurrAVMTot + ri.AstPropCurrAVMTot;
		// self.HHPropCurrAVMHighest					:= max(le.HHPropCurrAVMHighest, ri.HHPropCurrAVMHighest);
		// self.RaAPropOwnerAVMHighest				:= max(le.RaAPropOwnerAVMHighest, ri.RaAPropOwnerAVMHighest);
		self								 							:= le;
	END;

	rolledAVMOwned :=  rollup(sortedAVMOwned, left.seq = right.seq and left.did2 = right.did2,
											rollAVMOwned(left, right));

//--------- Economic Trajectory -------------//

//first project the AVM results for our prospect into BocaShell layout (the layout that the Economic Trajectory model accepts) 
	BSAVM := project(AVMrecs,  
												transform(Risk_Indicators.Layout_Boca_Shell,
																	self.historyDate 											:= left.historyDate;				
																	self.seq				 											:= left.seq;				
																	self.AVM.address_history_1						:= left.address_history_1;				
																	self.AVM.address_history_2						:= left.address_history_2;				
																	self 	:= left;
																	self	:= []));				

//now join to our BP shell to append additional fields needed by the model
	BSappended := join(BSAVM, rolledAVMOwned, //only need prospect (rec_type 1)
												left.seq = right.seq,
												transform(Risk_Indicators.Layout_Boca_Shell,
																	self.address_verification.addr_type2												:= right.curr_addr_type;
																	self.address_verification.address_history_1.assessed_amount	:= right.curr_assessedAmount;
																	self.address_verification.addr_type3												:= right.prev_addr_type;
																	self.address_verification.address_history_2.assessed_amount	:= right.prev_assessedAmount;
																	self.other_address_info.addrs_last_5years										:= if(right.LifeMoveNewMsnc > 60 , 0, 1);
																	self.reported_dob																						:= (integer)right.dob;
																	self.addrpop2																								:= right.curr_prim_name <> '' and right.curr_z5 <> '';
																	self.addrpop3																								:= right.prev_prim_name <> '' and right.prev_z5 <> '';
																	self := left), left outer, parallel);

	econTraj := risk_indicators.getEconomicTrajectory(Group(BSappended, seq));		

	withEconTraj := join(rolledAVMOwned, econTraj,
												left.seq = right.seq,// and
												// left.rec_type = ProfileBooster.Constants.recType.Prospect,  //update only the prospect record (not HH or relative)
												transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	self.LifeAddrEconTrajType 	:= right.economic_trajectory;
																	self.LifeAddrEconTrajIndx 	:= right.economic_trajectory_index;
																	self := left), left outer, parallel);
	
  OneClickKey := one_click_data.keys().did.qa;

  ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getOneClick(withEconTraj le, OneClickKey ri) := transform
    OneClickDataNotFound := ri.did <= 0;
    OneClickDataFound := ri.did > 0;
    OneClickDataDateValid := ri.rawfields.lastinquirydate<>'';
    dt_last_seen    := IF(
                          (unsigned4)((STRING8)ri.dt_first_seen)[1..6]>=
                          (unsigned4)((STRING8)le.historydate)[1..6],
                            (unsigned4)((STRING8)le.historydate),
                            (unsigned4)((STRING8)ri.dt_last_seen) 
                          );
    TimeOnRecord 		:= (INTEGER4)min(ut.MonthsApart((STRING6)risk_indicators.iid_constants.myGetDate((unsigned4)((STRING8)ri.dt_first_seen)[1..6]),(STRING6)risk_indicators.iid_constants.myGetDate((unsigned4)((STRING8)le.historydate)[1..6])),maxmths);
    TimeLastUpdate 	:= (INTEGER4)min(ut.MonthsApart((STRING6)risk_indicators.iid_constants.myGetDate((unsigned4)((STRING8)dt_last_seen)[1..6]),(STRING6)risk_indicators.iid_constants.myGetDate((unsigned4)((STRING8)le.historydate)[1..6])),maxmths);
    LastInquiryMsnc := (INTEGER4)min(ut.MonthsApart((STRING6)risk_indicators.iid_constants.myGetDate((unsigned4)((STRING8)ri.rawfields.lastinquirydate)[1..6]),(STRING6)risk_indicators.iid_constants.myGetDate((unsigned4)((STRING8)le.historydate)[1..6])),maxmths);
    SELF.ShortTermShopNewMsnc := map(OneClickDataNotFound => ABS(-99998),
                                     dt_last_seen<>0      =>(INTEGER4)TimeLastUpdate,
                                                             ABS(-99997)); 
    SELF.ShortTermShopOldMsnc := map(OneClickDataNotFound => -99998,
                                     ri.dt_first_seen<>0  => (INTEGER4)TimeOnRecord,
                                                            -99997); 
    SELF.ShortTermShopCntEv   := if(OneClickDataFound,1,0);
    SELF.ShortTermShopCnt6M   := map(OneClickDataDateValid AND LastInquiryMsnc<=6  => 1,
                                     dt_last_seen<>0 or OneClickDataNotFound       => 0,
                                                                                      -99997);
    SELF.ShortTermShopCnt5Y   := map(OneClickDataDateValid AND LastInquiryMsnc<=60 => 1,
                                     dt_last_seen<>0 or OneClickDataNotFound       => 0,
                                                                                      -99997);
    SELF.ShortTermShopCnt1Y   := map(OneClickDataDateValid AND LastInquiryMsnc<=12 => 1,
                                     dt_last_seen<>0 or OneClickDataNotFound       => 0,
                                                                                      -99997);
    SELF := le;
  END;
  
  withOneClickKey := JOIN(withEconTraj, OneClickKey,
                          LEFT.did2 = RIGHT.did
                          AND (UNSIGNED)((STRING8)RIGHT.dt_first_seen)[1..6] <= (UNSIGNED)((STRING8)LEFT.historydate)[1..6] ,
                          getOneClick(LEFT, RIGHT), LEFT OUTER);
  
	withOneClickSort 	:= sort(withOneClickKey, seq, rec_type, did2);  //sort prospect record to the top (rec_type = 1)
  
  ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell rollOneClick(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell ri) := transform
		ShortTermShopNewMsnc      := MIN(le.ShortTermShopNewMsnc,ri.ShortTermShopNewMsnc);
		self.ShortTermShopNewMsnc := IF(ShortTermShopNewMsnc IN [ABS(-99998),ABS(-99997)],ShortTermShopNewMsnc*-1,ShortTermShopNewMsnc); 
		self.ShortTermShopOldMsnc := MAX(le.ShortTermShopOldMsnc,ri.ShortTermShopOldMsnc);
		self.ShortTermShopCntEv   := le.ShortTermShopCntEv+ri.ShortTermShopCntEv;
		self.ShortTermShopCnt6M   := IF(le.ShortTermShopCnt6M>0,le.ShortTermShopCnt6M,0)+IF(ri.ShortTermShopCnt6M>0,ri.ShortTermShopCnt6M,0);
		self.ShortTermShopCnt5Y   := IF(le.ShortTermShopCnt5Y>0,le.ShortTermShopCnt5Y,0)+IF(ri.ShortTermShopCnt5Y>0,ri.ShortTermShopCnt5Y,0);
		self.ShortTermShopCnt1Y   := IF(le.ShortTermShopCnt1Y>0,le.ShortTermShopCnt1Y,0)+IF(ri.ShortTermShopCnt1Y>0,ri.ShortTermShopCnt1Y,0);
    self := le;
  END;
  
  withOneClickRollup := rollup(withOneClickSort, rollOneClick(left,right), seq);
  
  kaf := LN_PropertyV2.key_addr_fid(FALSE);

 // layout_ids_plus_fares append_fares_id_by_addr(p_addr le, kaf rt) := transform
 ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_fares_id_by_addr(withOneClickRollup le, kaf rt) := transform
	// SELF.historydate := le.historydate,
	// SELF.inp_did     := le.did,
	// SELF.inp_fname   := le.fname,
	// SELF.inp_lname   := le.lname,
	SELF.ln_fares_id := rt.ln_fares_id,
	// SELF.dataSrce    := SEARCHED_BY_ADDR,
	// hold onto the dates from each address to filter by later.  must make sure the address dates are within the dates that person lived there
	// self.p_address_dt_first_seen := le.date_first_seen;  
	// self.p_address_dt_last_seen := le.date_last_seen;
	SELF := le,			
	SELF := []
 end;
 STRING1   PROPERTY             := 'P';
 ids_plus_fares_by_address_thor := 
		JOIN(
			distribute(withOneClickRollup(prim_name<>''), hash64(curr_prim_name, curr_prim_range, curr_z5, curr_sec_range)), 
			distribute(pull(kaf)(source_code_2 = PROPERTY), hash64(prim_name, prim_range, zip, sec_range)),
			LEFT.curr_prim_name = RIGHT.prim_name AND
			LEFT.curr_prim_range = RIGHT.prim_range AND
			LEFT.curr_z5 = RIGHT.zip AND
			LEFT.curr_predir = RIGHT.predir AND
			LEFT.curr_postdir = RIGHT.postdir AND
			LEFT.curr_addr_suffix = RIGHT.suffix AND
			LEFT.curr_sec_range = RIGHT.sec_range,
			append_fares_id_by_addr(left, right),
			// INNER,
			LEFT OUTER,
			KEEP(1), 
			ATMOST(RiskWise.max_atmost),
			local
		);
OUTPUT(count(ids_plus_fares_by_address_thor),named('Check8'));

  Assessments := LN_PropertyV2.File_Assessment;
  
  ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_assessments(ids_plus_fares_by_address_thor l, Assessments r) := TRANSFORM
    SELF.CurrAddrHasPoolFlag := MAP(r.pool_code NOT IN ['0',''] => 1,0);
// Land use codes for Mobile Home:
// 0135	MOBILE HOME LOT
// 0136	MOBILE HOME PARK
// 0137	MOBILE HOME PP
// 0138	MOBILE HOME CO OP
// 0454	VACANT MOBILE HOME
// 0531	MOBILES HOMES CLASSED AS PERSONAL PROPERTY
// 1006	MOBILE HOME
// 1109	MOBILE HOME PARK
    MobileHomeLandUseCodeSet := ['0135','0136','0137','0138','0454','0531','1006','1109'];
    SELF.CurrAddrIsMobileHomeFlag := IF(r.ln_mobile_home_indicator='Y',1,0);
    SELF.CurrAddrBathCnt := (INTEGER4)r.no_of_baths;
    SELF.CurrAddrParkingCnt := (INTEGER4)r.parking_no_of_cars;
    SELF.CurrAddrBuildYr := (INTEGER4)r.year_built;
    SELF.CurrAddrBedCnt := (INTEGER4)r.no_of_bedrooms;
    SELF.CurrAddrBldgSize := (INTEGER4)r.building_area;
    SELF.CurrAddrLat := l.lat;
    SELF.CurrAddrLng := l.long;
    // SELF.AddrIsCollegeFlag := LEFT.rawaid; //address_verification.address_history_1.college_indicator
    // SELF.AddrIsVacantFlag := IF(r.VacancyIndicator = 'Y',1,0); //add_curr_advo_vacancy = Y
    // SELF.AddrForeclosure := LEFT.rawaid;
    // SELF.AddrAVMVal := r.pool_code;
    // SELF.AddrAVMValA1Y := r.pool_code;
    // SELF.AddrAVMRatio1Y := r.pool_code;
    // SELF.AddrAVMValA5Y := r.pool_code;
    // SELF.AddrAVMRatio5Y := r.pool_code;
    // SELF.AddrMedAVMCtyRatio := r.pool_code;
    // SELF.AddrMedAVMCenTractRatio := r.pool_code;
    // SELF.AddrMedAVMCenBlockRatio := r.pool_code;
    SELF.CurrAddrBusRegCnt := l.AddrBusRegCnt;
    // SELF.AddrIsAptFlag := LEFT.rawaid;
    SELF := l;
    SELF := []
  END;
  
  withAssessments := JOIN(DISTRIBUTE(ids_plus_fares_by_address_thor,hash(ln_fares_id)), 
                          DISTRIBUTE(Assessments,hash(ln_fares_id)),
                          LEFT.ln_fares_id = RIGHT.ln_fares_id,
                          append_assessments(LEFT,RIGHT), LEFT OUTER, KEEP(1), atmost(RiskWise.max_atmost), LOCAL);
OUTPUT(count(withAssessments),named('Check9'));
 
  ADVO_BASE_PRE := advo.key_addr1;
  
  ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_advo(withAssessments l, ADVO_BASE_PRE r) := TRANSFORM
    MissingInADVO := r.street_name='' AND r.zip_5='';  
    SELF.CurrAddrIsCollegeFlag := MAP(MissingInADVO => -99998,
                                  r.college_indicator='Y' => 1,
                                  r.college_indicator='N' => 0,
                                                             -99997);  
    BusinessIndicatorSet := ['B','D'];
    AddrIsAptFlag := NOT r.Residential_or_Business_Ind IN BusinessIndicatorSet; 
    SELF.CurrAddrIsAptFlag := MAP(MissingInADVO => -99998,
                              AddrIsAptFlag => 1,
                              r.Residential_or_Business_Ind = '' => -99997,
                                               0);
    SELF.CurrAddrIsVacantFlag := MAP(MissingInADVO => -99998,
                                 r.address_vacancy_indicator='Y' => 1,
                                 r.address_vacancy_indicator='N' => 0,
                                                                    -99997);
    // SELF.AddrForeclosure := r.
    SELF := l;
    SELF := []
  END;
  
  withADVO := JOIN(DISTRIBUTE(withAssessments,hash(curr_prim_name,curr_prim_range,curr_z5,curr_predir,curr_postdir,curr_addr_suffix,curr_sec_range)), 
                   DISTRIBUTE(ADVO_BASE_PRE,hash(street_name,street_num,zip_5,street_pre_directional,street_post_directional,street_suffix,secondary_unit_number)),
                   			LEFT.curr_prim_name = RIGHT.street_name AND
                        LEFT.curr_prim_range = RIGHT.street_num AND
                        LEFT.curr_z5 = RIGHT.zip_5 AND
                        LEFT.curr_predir = RIGHT.street_pre_directional AND
                        LEFT.curr_postdir = RIGHT.street_post_directional AND
                        LEFT.curr_addr_suffix = RIGHT.street_suffix AND
                        LEFT.curr_sec_range = RIGHT.secondary_unit_number,
                   append_advo(LEFT,RIGHT), LEFT OUTER, KEEP(1), atmost(RiskWise.max_atmost), LOCAL);
  // OUTPUT(count(withADVO),named('Check10'));  
  
// At this point we have one record for the prospect, one for each household member and one for each relative - roll them up 
// here to sum all of the household and relatives attributes for the prospect record  
  ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell rollFinal(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell ri) := transform
		self.HHTeenagerMmbrCnt							:= le.HHTeenagerMmbrCnt + ri.HHTeenagerMmbrCnt;
		self.HHYoungAdultMmbrCnt						:= le.HHYoungAdultMmbrCnt + ri.HHYoungAdultMmbrCnt;
		self.HHMiddleAgemmbrCnt							:= le.HHMiddleAgemmbrCnt + ri.HHMiddleAgemmbrCnt;
		self.HHSeniorMmbrCnt								:= le.HHSeniorMmbrCnt + ri.HHSeniorMmbrCnt;
		self.HHElderlyMmbrCnt								:= le.HHElderlyMmbrCnt + ri.HHElderlyMmbrCnt;
		self.HHCnt													:= le.HHCnt + ri.HHCnt;
		self.HHEstimatedIncomeRange					:= le.HHEstimatedIncomeRange;  //need to add code when model is complete
		self.HHCollegeAttendedMmbrCnt				:= le.HHCollegeAttendedMmbrCnt + ri.HHCollegeAttendedMmbrCnt;
		self.HHCollege2yrAttendedMmbrCnt		:= le.HHCollege2yrAttendedMmbrCnt + ri.HHCollege2yrAttendedMmbrCnt;
		self.HHCollege4yrAttendedMmbrCnt		:= le.HHCollege4yrAttendedMmbrCnt + ri.HHCollege4yrAttendedMmbrCnt;
		self.HHCollegeGradAttendedMmbrCnt		:= le.HHCollegeGradAttendedMmbrCnt + ri.HHCollegeGradAttendedMmbrCnt;
		self.HHCollegePrivateMmbrCnt				:= le.HHCollegePrivateMmbrCnt + ri.HHCollegePrivateMmbrCnt;
		//College tier is 1-6 where 1 indicates highest tier. Keep highest tier (lowest value) but excluding 0.  
		self.HHMmbrCollTierHighest				:= map(le.HHMmbrCollTierHighest = 0	=> ri.HHMmbrCollTierHighest,
																							 ri.HHMmbrCollTierHighest = 0	=> le.HHMmbrCollTierHighest,
																																									 min(le.HHMmbrCollTierHighest, ri.HHMmbrCollTierHighest)); 
		self.HHPropCurrOwnerMmbrCnt					:= le.HHPropCurrOwnerMmbrCnt + ri.HHPropCurrOwnerMmbrCnt;
		// self.HHAstPropCurrCntEv							:= le.HHAstPropCurrCntEv + ri.HHAstPropCurrCntEv;
		self.HHPropCurrAVMHighest						:= max(le.HHPropCurrAVMHighest, ri.HHPropCurrAVMHighest);
		self.HHPPCurrOwnedCnt								:= le.HHPPCurrOwnedCnt + ri.HHPPCurrOwnedCnt;
		self.HHPPCurrOwnedAutoCnt						:= le.HHPPCurrOwnedAutoCnt + ri.HHPPCurrOwnedAutoCnt;
		self.HHPPCurrOwnedMtrcycleCnt				:= le.HHPPCurrOwnedMtrcycleCnt + ri.HHPPCurrOwnedMtrcycleCnt;
		// self.HHAstPropAirCrftCntEv				:= le.HHAstPropAirCrftCntEv + ri.HHAstPropAirCrftCntEv;
		// self.HHAstPropWtrcrftCntEv				:= le.HHAstPropWtrcrftCntEv + ri.HHAstPropWtrcrftCntEv;
		self.HHCrtRecMmbrCnt								:= le.HHCrtRecMmbrCnt + ri.HHCrtRecMmbrCnt;
		self.HHCrtRecMmbrCnt12Mo						:= le.HHCrtRecMmbrCnt12Mo + ri.HHCrtRecMmbrCnt12Mo;
		self.HHCrtRecFelonyMmbrCnt					:= le.HHCrtRecFelonyMmbrCnt + ri.HHCrtRecFelonyMmbrCnt;
		self.HHCrtRecFelonyMmbrCnt12Mo			:= le.HHCrtRecFelonyMmbrCnt12Mo + ri.HHCrtRecFelonyMmbrCnt12Mo;
		self.HHCrtRecMsdmeanMmbrCnt					:= le.HHCrtRecMsdmeanMmbrCnt + ri.HHCrtRecMsdmeanMmbrCnt;
		self.HHCrtRecMsdmeanMmbrCnt12Mo			:= le.HHCrtRecMsdmeanMmbrCnt12Mo + ri.HHCrtRecMsdmeanMmbrCnt12Mo;
		self.HHCrtRecEvictionMmbrCnt				:= le.HHCrtRecEvictionMmbrCnt + ri.HHCrtRecEvictionMmbrCnt;
		self.HHCrtRecEvictionMmbrCnt12Mo		:= le.HHCrtRecEvictionMmbrCnt12Mo + ri.HHCrtRecEvictionMmbrCnt12Mo;
		self.HHCrtRecLienJudgMmbrCnt				:= le.HHCrtRecLienJudgMmbrCnt + ri.HHCrtRecLienJudgMmbrCnt;
		self.HHCrtRecLienJudgMmbrCnt12Mo		:= le.HHCrtRecLienJudgMmbrCnt12Mo + ri.HHCrtRecLienJudgMmbrCnt12Mo;
		self.HHDrgLnJAmtTot					        := le.HHDrgLnJAmtTot + ri.HHDrgLnJAmtTot;
		self.HHCrtRecBkrptMmbrCnt						:= le.HHCrtRecBkrptMmbrCnt + ri.HHCrtRecBkrptMmbrCnt;
		self.HHCrtRecBkrptMmbrCnt12Mo				:= le.HHCrtRecBkrptMmbrCnt12Mo + ri.HHCrtRecBkrptMmbrCnt12Mo;
		self.HHCrtRecBkrptMmbrCnt24Mo				:= le.HHCrtRecBkrptMmbrCnt24Mo + ri.HHCrtRecBkrptMmbrCnt24Mo;
		self.HHOccProfLicMmbrCnt						:= le.HHOccProfLicMmbrCnt + ri.HHOccProfLicMmbrCnt;
		self.HHOccBusinessAssocMmbrCnt			:= le.HHOccBusinessAssocMmbrCnt + ri.HHOccBusinessAssocMmbrCnt;
		self.HHInterestSportPersonMmbrCnt		:= le.HHInterestSportPersonMmbrCnt + ri.HHInterestSportPersonMmbrCnt;	
		self.RaATeenageMmbrCnt							:= le.RaATeenageMmbrCnt + ri.RaATeenageMmbrCnt;
		self.RaAYoungAdultMmbrCnt						:= le.RaAYoungAdultMmbrCnt + ri.RaAYoungAdultMmbrCnt;
		self.RaAMiddleAgeMmbrCnt						:= le.RaAMiddleAgeMmbrCnt + ri.RaAMiddleAgeMmbrCnt;
		self.RaASeniorMmbrCnt								:= le.RaASeniorMmbrCnt + ri.RaASeniorMmbrCnt;
		self.RaAElderlyMmbrCnt							:= le.RaAElderlyMmbrCnt + ri.RaAElderlyMmbrCnt;
		self.RaAHHCnt												:= if(le.RaAHHCnt <> 0, le.RaAHHCnt, ri.RaAHHCnt); //this count is summed already so just keep whichever is populated
		self.RaAMmbrCnt											:= le.RaAMmbrCnt + ri.RaAMmbrCnt;
		self.RaAMedIncomeRange							:= if(le.RaAMedIncomeRange <> 0, le.RaAMedIncomeRange, ri.RaAMedIncomeRange);	//Med income will be same for all relatives records at this point so just take whichever is populated
		self.RaACollegeAttendedMmbrCnt			:= le.RaACollegeAttendedMmbrCnt + ri.RaACollegeAttendedMmbrCnt;
		self.RaACollege2yrAttendedMmbrCnt		:= le.RaACollege2yrAttendedMmbrCnt + ri.RaACollege2yrAttendedMmbrCnt;
		self.RaACollege4yrAttendedMmbrCnt		:= le.RaACollege4yrAttendedMmbrCnt + ri.RaACollege4yrAttendedMmbrCnt;
		self.RaACollegeGradAttendedMmbrCnt	:= le.RaACollegeGradAttendedMmbrCnt + ri.RaACollegeGradAttendedMmbrCnt;
		self.RaACollegePrivateMmbrCnt				:= le.RaACollegePrivateMmbrCnt + ri.RaACollegePrivateMmbrCnt;
		self.RaACollegeTopTierMmbrCnt				:= le.RaACollegeTopTierMmbrCnt + ri.RaACollegeTopTierMmbrCnt;
		self.RaACollegeMidTierMmbrCnt				:= le.RaACollegeMidTierMmbrCnt + ri.RaACollegeMidTierMmbrCnt;
		self.RaACollegeLowTierMmbrCnt				:= le.RaACollegeLowTierMmbrCnt + ri.RaACollegeLowTierMmbrCnt;
		self.RaAPropCurrOwnerMmbrCnt				:= le.RaAPropCurrOwnerMmbrCnt + ri.RaAPropCurrOwnerMmbrCnt;
		self.RaAPropOwnerAVMHighest					:= max(le.RaAPropOwnerAVMHighest, ri.RaAPropOwnerAVMHighest);
		// self.RaAPropOwnerAVMMed							:= ave(groupAVMOwned, RaAPropOwnerAVMHighest);
		self.RaAPPCurrOwnerMmbrCnt					:= le.RaAPPCurrOwnerMmbrCnt + ri.RaAPPCurrOwnerMmbrCnt;
		self.RaAPPCurrOwnerAutoMmbrCnt 			:= le.RaAPPCurrOwnerAutoMmbrCnt + ri.RaAPPCurrOwnerAutoMmbrCnt;
		self.RaAPPCurrOwnerMtrcycleMmbrCnt 	:= le.RaAPPCurrOwnerMtrcycleMmbrCnt + ri.RaAPPCurrOwnerMtrcycleMmbrCnt;
		self.RaAPPCurrOwnerAircrftMmbrCnt 	:= le.RaAPPCurrOwnerAircrftMmbrCnt + ri.RaAPPCurrOwnerAircrftMmbrCnt;
		self.RaAPPCurrOwnerWtrcrftMmbrCnt		:= le.RaAPPCurrOwnerWtrcrftMmbrCnt + ri.RaAPPCurrOwnerWtrcrftMmbrCnt;
		self.RaACrtRecMmbrCnt								:= le.RaACrtRecMmbrCnt + ri.RaACrtRecMmbrCnt;
		self.RaACrtRecMmbrCnt12Mo						:= le.RaACrtRecMmbrCnt12Mo + ri.RaACrtRecMmbrCnt12Mo;
		self.RaACrtRecFelonyMmbrCnt					:= le.RaACrtRecFelonyMmbrCnt + ri.RaACrtRecFelonyMmbrCnt;
		self.RaACrtRecFelonyMmbrCnt12Mo			:= le.RaACrtRecFelonyMmbrCnt12Mo + ri.RaACrtRecFelonyMmbrCnt12Mo;
		self.RaACrtRecMsdmeanMmbrCnt				:= le.RaACrtRecMsdmeanMmbrCnt + ri.RaACrtRecMsdmeanMmbrCnt;
		self.RaACrtRecMsdmeanMmbrCnt12Mo		:= le.RaACrtRecMsdmeanMmbrCnt12Mo + ri.RaACrtRecMsdmeanMmbrCnt12Mo;
		self.RaACrtRecEvictionMmbrCnt				:= le.RaACrtRecEvictionMmbrCnt + ri.RaACrtRecEvictionMmbrCnt;
		self.RaACrtRecEvictionMmbrCnt12Mo		:= le.RaACrtRecEvictionMmbrCnt12Mo + ri.RaACrtRecEvictionMmbrCnt12Mo;
		self.RaACrtRecLienJudgMmbrCnt				:= le.RaACrtRecLienJudgMmbrCnt + ri.RaACrtRecLienJudgMmbrCnt;
		self.RaACrtRecLienJudgMmbrCnt12Mo		:= le.RaACrtRecLienJudgMmbrCnt12Mo + ri.RaACrtRecLienJudgMmbrCnt12Mo;
		self.RaACrtRecLienJudgAmtMax				:= max(le.RaACrtRecLienJudgAmtMax, ri.RaACrtRecLienJudgAmtMax);
		self.RaACrtRecBkrptMmbrCnt36Mo			:= le.RaACrtRecBkrptMmbrCnt36Mo + ri.RaACrtRecBkrptMmbrCnt36Mo;
		self.RaAOccProfLicMmbrCnt						:= le.RaAOccProfLicMmbrCnt + ri.RaAOccProfLicMmbrCnt;
		self.RaAOccBusinessAssocMmbrCnt			:= le.RaAOccBusinessAssocMmbrCnt + ri.RaAOccBusinessAssocMmbrCnt;
		self.RaAInterestSportPersonMmbrCnt	:= le.RaAInterestSportPersonMmbrCnt + ri.RaAInterestSportPersonMmbrCnt;		
		self := le;  //for all prospect attributes, keep all values from the left (first) record  
	end;
	
  finalSort 	:= sort(withADVO, seq, rec_type, did2);  //sort prospect record to the top (rec_type = 1)
  finalRollup := rollup(finalSort, rollFinal(left,right), seq);

//append relatives' average income
	// withRelaIncome := finalRollup;//join(finalRollup, tRelaIncome,  
												// left.seq = right.seq,
												// transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	// self.RaAMedIncomeRange	:= right.RelaIncome;  
																	// self := left), left outer);

//append count of households within relatives
	// withRelaHHcnt := withRelaIncome//join(withRelaIncome, tRelaHHcnt,  
												// left.seq = right.seq,
												// transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	// self.RaAHHCnt	:= right.RelaHHcnt;  
																	// self := left), left outer);

	// tRelaAVMMed := table(groupAVMOwned(rec_type=ProfileBooster.Constants.recType.Relative and RAAPropOwnerAVMMed <> 0), {seq, RelaAVMMed := ave(group, RAAPropOwnerAVMMed)}, seq);

//append median AVM value for relatives
	// withAVMMed := join(withRelaHHcnt, tRelaAVMMed,  
												// left.seq = right.seq,
												// transform(ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell,
																	// self.RAAPropOwnerAVMMed	:= right.RelaAVMMed;  
																	// self := left), left outer);
	
/* 	ProfileBooster.V2_Key_Layouts.Layout_PB2_BatchOut tfEmpty(PB_In le) := transform
   		self.seq			:= le.seq;
   		SELF.AcctNo		:= le.AcctNo;
   		self 					:= [];
   	end;
   
   	emptyAttr := project(PB_In, tfEmpty(left)); 
   			
   // *******************************************************************************************************************
   // Now that we have all necessary data in the PBShell, pass it to the attributes function to produce the attributes
   // *******************************************************************************************************************
     attributes := if(StringLib.StringToUpperCase(AttributesVersion) in ProfileBooster.Constants.setValidAttributeVersions OR domodel, //if valid attributes version requested, go get attributes
   									 ProfileBooster.V2_getAttributes(finalRollup, DataPermissionMask),
   									 emptyAttr);  
   									 
   	withIncome := ProfileBooster.estimatedIncome(attributes);
   	
   	withHHIncome := ProfileBooster.HHestimatedIncome(withIncome); //for production
   	
   	withBankingExperiance := ProfileBooster.getBankingExperiance (withHHIncome);
   #IF(DEBUG)
     //Model that is being tested goes here
     // with_mover_model := profilebooster.PB1708_1_0(withBankingExperiance);
    with_mover_model := profilebooster.PB1708_1_0(withBankingExperiance);
    
   #ELSE
     with_mover_model := if(domodel,
                           CASE(modelname,
                           //'PB1708_1' => profilebooster.PB1708_1_0(withBankingExperiance, iid_prep),
                           'PB1708_1' => profilebooster.PB1708_1_0(withBankingExperiance),
                           'PBM1803_0' => profilebooster.PBM1803_0_1_score(withBankingExperiance, iid_prep),
                           
                                         DATASET([],ProfileBooster.Layouts.Layout_PB_BatchOut)),
                           withBankingExperiance);
   #END                        
   
   //Blank out the fields calculated outside of getAttributes for any minors
   ProfileBooster.Layouts.Layout_PB_BatchOut Blank_minors(ProfileBooster.Layouts.Layout_PB_BatchOut le) := TRANSFORM
     isMinor := le.attributes.version1.ProspectAge = '0'; //is zero if is a minor
     self.attributes.version1.prospectestimatedincomerange := if(isMinor, '-1', le.attributes.version1.prospectestimatedincomerange);
     self.attributes.version1.prospectbankingexperience := if(isMinor, '-1', le.attributes.version1.prospectbankingexperience);
     self.attributes.version1.hhestimatedincomerange := if(isMinor, '-1', le.attributes.version1.hhestimatedincomerange);
     self := le;
   END;
   
   FinalWithDID := PROJECT(with_mover_model, Blank_minors(left));
*/

ProfileBooster.V2_Key_Layouts.Layout_PB2_BatchOut getAttr(withOneClickRollup le) := transform
	self.seq								:= le.seq;
	self.AcctNo								:= le.AcctNo;
	self.LexID								:= le.did;
	
  // self.attributes.version2.DemUpdtOldMsnc := le.DemUpdtOldMsnc;
	// self.attributes.version2.DemUpdtNewMsnc := le.DemUpdtNewMsnc;
	// self.attributes.version2.DemUpdtFlag1Y := le.DemUpdtFlag1Y;
	// self.attributes.version2.DemAge := le.DemAge;
	// self.attributes.version2.DemGender := le.DemGender;
	// self.attributes.version2.DemIsMarriedFlag := le.DemIsMarriedFlag;
	// self.attributes.version2.DemEstInc := le.DemEstInc;
	// self.attributes.version2.DemDeceasedFlag := le.DemDeceasedFlag;
		
	self.attributes.version2.DemEduCollCurrFlag := le.DemEduCollCurrFlag;
	self.attributes.version2.DemEduCollFlagEv := le.DemEduCollFlagEv;
	self.attributes.version2.DemEduCollNewLevelEv := le.DemEduCollNewLevelEv;
	self.attributes.version2.DemEduCollNewPvtFlag := le.DemEduCollNewPvtFlag;
	self.attributes.version2.DemEduCollNewTierIndx := le.DemEduCollNewTierIndx;
	self.attributes.version2.DemEduCollLevelHighEv := le.DemEduCollLevelHighEv;
	self.attributes.version2.DemEduCollRecNewInstTypeEv := le.DemEduCollRecNewInstTypeEv;
	self.attributes.version2.DemEduCollTierHighEv := le.DemEduCollTierHighEv;
	self.attributes.version2.DemEduCollRecNewMajorTypeEv := le.DemEduCollRecNewMajorTypeEv;
	
 	self.attributes.version2.DemEduCollEvidFlagEv := le.DemEduCollEvidFlagEv;

	self.attributes.version2.DemEduCollSrcNewRecOldMsncEv := le.DemEduCollSrcNewRecOldMsncEv;
	self.attributes.version2.DemEduCollSrcNewRecNewMsncEv := le.DemEduCollSrcNewRecNewMsncEv;
	self.attributes.version2.DemEduCollRecSpanEv := le.DemEduCollRecSpanEv;
	self.attributes.version2.DemEduCollRecNewClassEv := le.DemEduCollRecNewClassEv;
	self.attributes.version2.DemEduCollSrcNewExpGradYr := le.DemEduCollSrcNewExpGradYr;
	self.attributes.version2.DemEduCollInstPvtFlagEv := le.DemEduCollInstPvtFlagEv;
	self.attributes.version2.DemEduCollMajorMedicalFlagEv := le.DemEduCollMajorMedicalFlagEv;
	self.attributes.version2.DemEduCollMajorPhysSciFlagEv := le.DemEduCollMajorPhysSciFlagEv;
	self.attributes.version2.DemEduCollMajorSocSciFlagEv := le.DemEduCollMajorSocSciFlagEv;
	self.attributes.version2.DemEduCollMajorLibArtsFlagEv := le.DemEduCollMajorLibArtsFlagEv;
	self.attributes.version2.DemEduCollMajorTechnicalFlagEv := le.DemEduCollMajorTechnicalFlagEv;
	self.attributes.version2.DemEduCollMajorBusFlagEv := le.DemEduCollMajorBusFlagEv;
	self.attributes.version2.DemEduCollMajorEduFlagEv := le.DemEduCollMajorEduFlagEv;
	self.attributes.version2.DemEduCollMajorLawFlagEv := le.DemEduCollMajorLawFlagEv;

	self.attributes.version2.DemBankingIndx := le.DemBankingIndx;

	self.attributes.version2.IntSportPersonFlagEv := le.IntSportPersonFlagEv;
	self.attributes.version2.IntSportPersonFlag1Y := le.IntSportPersonFlag1Y;
	self.attributes.version2.IntSportPersonFlag5Y := le.IntSportPersonFlag5Y;
	self.attributes.version2.IntSportPersonTravelerFlagEv := le.IntSportPersonTravelerFlagEv;
  
  	self.attributes.version2.LifeMoveNewMsnc := IF(le.LifeMoveNewMsnc<-99997,-99998,le.LifeMoveNewMsnc);
	self.attributes.version2.LifeNameLastChngFlag := le.LifeNameLastChngFlag;
	self.attributes.version2.LifeNameLastChngFlag1Y := le.LifeNameLastChngFlag1Y;
	self.attributes.version2.LifeNameLastCntEv := le.LifeNameLastCntEv;
	self.attributes.version2.LifeNameLastChngNewMsnc := IF(le.LifeNameLastChngNewMsnc<-99997,-99998,le.LifeNameLastChngNewMsnc);
	self.attributes.version2.LifeAstPurchOldMsnc := IF(le.LifeAstPurchOldMsnc<-99997,-99998,le.LifeAstPurchOldMsnc);
	self.attributes.version2.LifeAstPurchNewMsnc := IF(le.LifeAstPurchNewMsnc<-99997,-99998,le.LifeAstPurchNewMsnc);
	self.attributes.version2.LifeAddrCnt := le.LifeAddrCnt;
	self.attributes.version2.LifeAddrCurrToPrevValRatio5Y := le.LifeAddrCurrToPrevValRatio5Y;
	self.attributes.version2.LifeAddrEconTrajType := le.LifeAddrEconTrajType;
	self.attributes.version2.LifeAddrEconTrajIndx := le.LifeAddrEconTrajIndx;
  
	self.attributes.version2.AstCurrFlag := le.AstCurrFlag;
	self.attributes.version2.AstPropCurrFlag := le.AstPropCurrFlag;
	self.attributes.version2.AstPropCurrCntEv := le.AstPropCurrCntEv;
	self.attributes.version2.AstPropCurrValTot := le.AstPropCurrValTot;
	self.attributes.version2.AstPropCurrAVMTot := le.AstPropCurrAVMTot;
	self.attributes.version2.AstPropSaleNewMsnc := IF(le.AstPropSaleNewMsnc<-99997,-99998,le.AstPropSaleNewMsnc);
	self.attributes.version2.AstPropCntEv := le.AstPropCntEv;
	self.attributes.version2.AstPropSoldCntEv := le.AstPropSoldCntEv;
	self.attributes.version2.AstPropSoldCnt1Y := le.AstPropSoldCnt1Y;
	self.attributes.version2.AstPropSoldNewRatio := le.AstPropSoldNewRatio;
	self.attributes.version2.AstPropPurchCnt1Y := le.AstPropPurchCnt1Y;
	self.attributes.version2.AstPropAirCrftCntEv := le.AstPropAirCrftCntEv;
	self.attributes.version2.AstPropWtrcrftCntEv := le.AstPropWtrcrftCntEv;

	self.attributes.version2.ShortTermShopNewMsnc := le.ShortTermShopNewMsnc;
	self.attributes.version2.ShortTermShopOldMsnc := le.ShortTermShopOldMsnc;
	self.attributes.version2.ShortTermShopCntEv := le.ShortTermShopCntEv;
	self.attributes.version2.ShortTermShopCnt6M := le.ShortTermShopCnt6M;
	self.attributes.version2.ShortTermShopCnt5Y := le.ShortTermShopCnt5Y;
	self.attributes.version2.ShortTermShopCnt1Y := le.ShortTermShopCnt1Y;
  
  	self.attributes.version2.CurrAddrOwnershipIndx := le.CurrAddrOwnershipIndx;
	self.attributes.version2.CurrAddrHasPoolFlag := le.CurrAddrHasPoolFlag;
	self.attributes.version2.CurrAddrIsMobileHomeFlag := le.CurrAddrIsMobileHomeFlag;
	self.attributes.version2.CurrAddrBathCnt := le.CurrAddrBathCnt;
	self.attributes.version2.CurrAddrParkingCnt := le.CurrAddrParkingCnt;
	self.attributes.version2.CurrAddrBuildYr := le.CurrAddrBuildYr;
	self.attributes.version2.CurrAddrBedCnt := le.CurrAddrBedCnt;
	self.attributes.version2.CurrAddrBldgSize := le.CurrAddrBldgSize;
	self.attributes.version2.CurrAddrLat := le.CurrAddrLat;
	self.attributes.version2.CurrAddrLng := le.CurrAddrLng;
	self.attributes.version2.CurrAddrIsCollegeFlag := le.CurrAddrIsCollegeFlag;
	self.attributes.version2.CurrAddrAVMVal := le.CurrAddrAVMVal;
	self.attributes.version2.CurrAddrAVMValA1Y := le.CurrAddrAVMValA1Y;
	self.attributes.version2.CurrAddrAVMRatio1Y := le.CurrAddrAVMRatio1Y;
	self.attributes.version2.CurrAddrAVMValA5Y := le.CurrAddrAVMValA5Y;
	self.attributes.version2.CurrAddrAVMRatio5Y := le.CurrAddrAVMRatio5Y;
	self.attributes.version2.CurrAddrMedAVMCtyRatio := le.CurrAddrMedAVMCtyRatio;
	self.attributes.version2.CurrAddrMedAVMCenTractRatio := le.CurrAddrMedAVMCenTractRatio;
	self.attributes.version2.CurrAddrMedAVMCenBlockRatio := le.CurrAddrMedAVMCenBlockRatio;
	self.attributes.version2.CurrAddrType := le.CurrAddrType;
	self.attributes.version2.CurrAddrTypeIndx := le.CurrAddrTypeIndx;
	self.attributes.version2.CurrAddrBusRegCnt := le.CurrAddrBusRegCnt;
	self.attributes.version2.CurrAddrIsVacantFlag := le.CurrAddrIsVacantFlag;
	self.attributes.version2.CurrAddrStatus := le.CurrAddrStatus;
	self.attributes.version2.CurrAddrIsAptFlag := le.CurrAddrIsAptFlag;

	self.attributes.version2.AddrCurrFull := le.AddrCurrFull;
	self.attributes.version2.curr_addr_rawaid := le.curr_addr_rawaid;
	self.attributes.version2.curr_prim_range := le.curr_prim_range;
	self.attributes.version2.curr_predir := le.curr_predir;
	self.attributes.version2.curr_prim_name := le.curr_prim_name;
	self.attributes.version2.curr_addr_suffix := le.curr_addr_suffix;
	self.attributes.version2.curr_postdir := le.curr_postdir;
	self.attributes.version2.curr_unit_desig := le.curr_unit_desig;
	self.attributes.version2.curr_sec_range := le.curr_sec_range;
	self.attributes.version2.curr_city_name := le.curr_city_name;
	self.attributes.version2.curr_st := le.curr_st;
	self.attributes.version2.curr_z5 := le.curr_z5;
	self.attributes.version2.curr_zip4 := le.curr_zip4;
	self.attributes.version2.curr_addr_type := le.curr_addr_type;
	self.attributes.version2.curr_addr_status := le.curr_addr_status;	
	self.attributes.version2.curr_county := le.curr_county;
	self.attributes.version2.curr_geo_blk := le.curr_geo_blk;	
	self.attributes.version2.curr_date_first_seen := le.curr_date_first_seen;	
	self.attributes.version2.curr_date_last_seen := le.curr_date_last_seen;

	self.attributes.version2.AddrPrevFull := le.AddrPrevFull;
	self.attributes.version2.prev_addr_rawaid := le.prev_addr_rawaid;
	self.attributes.version2.prev_prim_range := le.prev_prim_range;
	self.attributes.version2.prev_predir := le.prev_predir;
	self.attributes.version2.prev_prim_name := le.prev_prim_name;
	self.attributes.version2.prev_addr_suffix := le.prev_addr_suffix;
	self.attributes.version2.prev_postdir := le.prev_postdir;
	self.attributes.version2.prev_unit_desig := le.prev_unit_desig;
	self.attributes.version2.prev_sec_range := le.prev_sec_range;
	self.attributes.version2.prev_city_name := le.prev_city_name;
	self.attributes.version2.prev_st := le.prev_st;
	self.attributes.version2.prev_z5 := le.prev_z5;
	self.attributes.version2.prev_zip4 := le.prev_zip4;
	self.attributes.version2.prev_addr_type := le.prev_addr_type;
	self.attributes.version2.prev_addr_status := le.prev_addr_status;	
	self.attributes.version2.prev_county := le.prev_county;
	self.attributes.version2.prev_geo_blk := le.prev_geo_blk;	
	self.attributes.version2.prev_date_first_seen := le.prev_date_first_seen;	
	self.attributes.version2.prev_date_last_seen := le.prev_date_last_seen;
  
    self.attributes.version2.DrgCnt7Y := le.DrgCnt7Y;
    self.attributes.version2.DrgSeverityIndx7Y := le.DrgSeverityIndx7Y;
	self.attributes.version2.DrgCnt1Y := le.DrgCnt1Y;
	self.attributes.version2.DrgNewMsnc7Y := le.DrgNewMsnc7Y;
	self.attributes.version2.DrgCrimFelCnt7Y := le.DrgCrimFelCnt7Y;
	self.attributes.version2.DrgCrimFelCnt1Y := le.DrgCrimFelCnt1Y;
	self.attributes.version2.DrgCrimFelNewMsnc7Y := le.DrgCrimFelNewMsnc7Y;
	self.attributes.version2.DrgCrimNFelCnt7Y := le.DrgCrimNFelCnt7Y;
	self.attributes.version2.DrgCrimNFelCnt1Y := le.DrgCrimNFelCnt1Y;
	self.attributes.version2.DrgCrimNFelNewMsnc7Y := le.DrgCrimNFelNewMsnc7Y;
	self.attributes.version2.DrgEvictCnt7Y := le.DrgEvictCnt7Y;
	self.attributes.version2.DrgEvictCnt1Y := le.DrgEvictCnt1Y;
	self.attributes.version2.DrgEvictNewMsnc7Y := le.DrgEvictNewMsnc7Y;
	self.attributes.version2.DrgLnJCnt7Y := le.DrgLnJCnt7Y;
	self.attributes.version2.DrgLnJCnt1Y := le.DrgLnJCnt1Y;
	self.attributes.version2.DrgLnJNewMsnc7Y := le.DrgLnJNewMsnc7Y;
	self.attributes.version2.DrgLnJAmtTot7Y := le.DrgLnJAmtTot7Y;
	self.attributes.version2.DrgBkCnt10Y := le.DrgBkCnt10Y;
	self.attributes.version2.DrgBkCnt1Y := le.DrgBkCnt1Y;
	self.attributes.version2.DrgBkNewMsnc10Y := le.DrgBkNewMsnc10Y;
	// self.attributes.version2.DrgFrClCnt7Y := le.DrgFrClCnt7Y;
	// self.attributes.version2.DrgFrClCnt1Y := le.DrgFrClCnt1Y;
	// self.attributes.version2.DrgFrClNewMsnc := IF(le.DrgFrClNewMsnc<-99997,-99998,le.DrgFrClNewMsnc);
  
	self.attributes.version2.proflicflagev := le.proflicflagev;
	self.attributes.version2.proflicactivnewindx := le.proflicactivnewindx;
	self.attributes.version2.busassocflagev := le.busassocflagev;
	self.attributes.version2.busassocoldmsnc := le.busassocoldmsnc;
	self.attributes.version2.busleadershiptitleflag := le.busleadershiptitleflag;
	self.attributes.version2.busassoccntev := le.busassoccntev;
	// self.attributes.version2.busassocsmbusflag := le.busassocsmbusflag;
	self.attributes.version2.proflicactvnewtitletype := le.proflicactvnewtitletype;
	self.attributes.version2.busuccfilingcntev := le.busuccfilingcntev;
	self.attributes.version2.busuccfilingactivecnt := le.busuccfilingactivecnt;
    
	EmrgDt_first_seen := le.EmrgDt_first_seen;
	self.attributes.version2.emrgage                        := MAP(EmrgDt_first_seen<=0 => -99998,
	                                                               le.emrgage<=0         => -99998,
	                                                                                       le.emrgage);
	self.attributes.version2.emrgatorafter21flag            := MAP(le.emrgage > 21 => 1,
	                                                               le.emrgage > 0  => 0,
																                      -99998);
	self.attributes.version2.emrgage25to59flag              := MAP(le.emrgage >= 25 AND le.emrgage <= 60 => 1,
	                                                               le.emrgage <= 0                        => -99998,
																                                            0);
    propertySources  := MDR.SourceTools.set_Property;
	proflicSources   := MDR.SourceTools.set_Prolic;
	derogSources     := MDR.SourceTools.set_Bk + MDR.SourceTools.set_Liens + [MDR.SourceTools.src_Foreclosures] + MDR.sourceTools.set_Sex_Offender;
	busnAssocSources := MDR.sourceTools.set_Business_header;
	educationSources := [MDR.sourceTools.src_American_Students_List ] + [MDR.sourceTools.src_OKC_Student_List];
	sportingSources  := MDR.sourceTools.set_EMerge_CCW + MDR.sourceTools.set_EMerge_CCW_NY + MDR.sourceTools.set_EMerge_Cens + MDR.sourceTools.set_EMerge_Fish + MDR.sourceTools.set_EMerge_Hunt;
	self.attributes.version2.emrgrecordtype                 := MAP(le.EmrgSrc IN propertySources  => 'A',//property
	                                                               le.EmrgSrc IN proflicSources   => 'P',//prof lic
																   le.EmrgSrc IN derogSources     => 'D',//derog
																   le.EmrgSrc IN busnAssocSources => 'B',//busn assoc
																   le.EmrgSrc IN educationSources => 'E',//education
																   le.EmrgSrc IN sportingSources  => 'S',//sporting
																                                     'O');//other
	// self.attributes.version2.emrgaddresshrindex             := le.emrgaddresshrindex; //connect to address key on Roxie?
	// self.attributes.version2.emrglexidsatemrgaddrcnt1y      := le.emrglexidsatemrgaddrcnt1y; //connect to lexid key on Roxie?
	
	self.attributes.version2.EmrgDOB                        := IF(le.EmrgDOB='','-99997',le.EmrgDOB);
	self.attributes.version2.EmrgSrc                        := le.EmrgSrc;
	self.attributes.version2.EmrgDt_first_seen              := le.EmrgDt_first_seen;
	EmrgAddrFull := TRIM(Address.Addr1FromComponents(le.EmrgPrimaryRange,le.EmrgPredirectional,le.EmrgPrimaryName,
												     le.EmrgSuffix,le.EmrgPostdirectional,le.EmrgUnitDesignation, 
													 le.EmrgSecondaryRange))+' '+TRIM(le.EmrgCity_Name)+', '+le.EmrgSt
													  +' '+le.EmrgZIP5+'-'+le.EmrgZIP4;	
	self.attributes.version2.EmrgAddrFull                   := EmrgAddrFull;
	self.attributes.version2.EmrgPrimaryRange               := le.EmrgPrimaryRange;
	self.attributes.version2.EmrgPredirectional             := le.EmrgPredirectional;
	self.attributes.version2.EmrgPrimaryName                := le.EmrgPrimaryName;
	self.attributes.version2.EmrgSuffix                     := le.EmrgSuffix;
	self.attributes.version2.EmrgPostdirectional            := le.EmrgPostdirectional;
	self.attributes.version2.EmrgUnitDesignation            := le.EmrgUnitDesignation;
	self.attributes.version2.EmrgSecondaryRange             := le.EmrgSecondaryRange;
	self.attributes.version2.EmrgZIP5                       := le.EmrgZIP5;
	self.attributes.version2.EmrgZIP4                       := le.EmrgZIP4;
	self.attributes.version2.EmrgCity_Name                  := le.EmrgCity_Name;
	self.attributes.version2.EmrgSt                         := le.EmrgSt;
	
	self.attributes.version2.HHID                           := le.HHID;  
	self.attributes.version2.HHTeenagerMmbrCnt				:= le.HHTeenagerMmbrCnt;
	self.attributes.version2.HHYoungAdultMmbrCnt			:= le.HHYoungAdultMmbrCnt;
	self.attributes.version2.HHMiddleAgemmbrCnt				:= le.HHMiddleAgemmbrCnt;
	self.attributes.version2.HHSeniorMmbrCnt				:= le.HHSeniorMmbrCnt;
	self.attributes.version2.HHElderlyMmbrCnt				:= le.HHElderlyMmbrCnt;
	self.attributes.version2.HHMmbrAgeMed					:= le.HHMmbrAgeMed;
	self.attributes.version2.HHMmbrAgeAvg					:= le.HHMmbrAgeAvg;
	self.attributes.version2.HHComplexTotalCnt				:= le.HHComplexTotalCnt;
	self.attributes.version2.HHUnitsInComplexCnt			:= le.HHUnitsInComplexCnt;
	self.attributes.version2.HHMmbrCnt						:= le.HHMmbrCnt;
	self.attributes.version2.HHEstimatedIncomeTotal         := le.HHEstimatedIncomeTotal;
	self.attributes.version2.HHEstimatedIncomeAvg	        := le.HHEstimatedIncomeAvg;
	self.attributes.version2.HHMmbrWEduCollCnt	            := le.HHMmbrWEduCollCnt;
	self.attributes.version2.HHMmbrWEduCollEvidEvCnt	    := le.HHMmbrWEduCollEvidEvCnt;
	self.attributes.version2.HHMmbrWEduColl2YrCnt	        := le.HHMmbrWEduColl2YrCnt;
	self.attributes.version2.HHMmbrWEduColl4YrCnt	        := le.HHMmbrWEduColl4YrCnt;
	self.attributes.version2.HHMmbrWEduCollGradCnt	        := le.HHMmbrWEduCollGradCnt;
	self.attributes.version2.HHMmbrWCollPvtCnt	            := le.HHMmbrWCollPvtCnt;
	self.attributes.version2.HHMmbrCollTierHighest	        := le.HHMmbrCollTierHighest;
	self.attributes.version2.HHMmbrCollTierAvg	            := le.HHMmbrCollTierAvg;
	
	self.attributes.version2.HHMmbrWIntSportCnt	            := le.HHMmbrWIntSportCnt;
	
	self.attributes.version2.HHMmbrWDrgCnt7Y				:= le.HHMmbrWDrgCnt7Y;
	self.attributes.version2.HHMmbrWDrgCnt1Y				:= le.HHMmbrWDrgCnt1Y;
	self.attributes.version2.HHDrgNewMsnc7Y					:= le.HHDrgNewMsnc7Y;
	self.attributes.version2.HHMmbrWCrimFelCnt7Y			:= le.HHMmbrWCrimFelCnt7Y;
	self.attributes.version2.HHMmbrWCrimFelCnt1Y			:= le.HHMmbrWCrimFelCnt1Y;
	self.attributes.version2.HHMmbrWCrimFelNewMsnc7Y		:= le.HHMmbrWCrimFelNewMsnc7Y;
	self.attributes.version2.HHMmbrWCrimNFelCnt7Y			:= le.HHMmbrWCrimNFelCnt7Y;
	self.attributes.version2.HHMmbrWCrimNFelCnt1Y		    := le.HHMmbrWCrimNFelCnt1Y;
	self.attributes.version2.HHMmbrWCrimNFelNewMsnc7Y		:= le.HHMmbrWCrimNFelNewMsnc7Y;
	self.attributes.version2.HHMmbrWEvictCnt7Y		        := le.HHMmbrWEvictCnt7Y;
	self.attributes.version2.HHMmbrWEvictCnt1Y				:= le.HHMmbrWEvictCnt1Y;
	self.attributes.version2.HHMmbrWEvictNewMsnc7Y			:= le.HHMmbrWEvictNewMsnc7Y;
	self.attributes.version2.HHMmbrWLnJCnt7Y				:= le.HHMmbrWLnJCnt7Y;
	self.attributes.version2.HHMmbrWLnJCnt1Y				:= le.HHMmbrWLnJCnt1Y;
	self.attributes.version2.HHMmbrLnJAmtTot7Y				:= le.HHMmbrLnJAmtTot7Y;
	self.attributes.version2.HHMmbrWLnJNewMsnc7Y			:= le.HHMmbrWLnJNewMsnc7Y;
	self.attributes.version2.HHMmbrWBkCnt10Y		        := le.HHMmbrWBkCnt10Y;
	self.attributes.version2.HHMmbrWBkCnt1Y		            := le.HHMmbrWBkCnt1Y;
	self.attributes.version2.HHMmbrWBkCnt2Y		            := le.HHMmbrWBkCnt2Y;
	self.attributes.version2.HHMmbrWBkNewMsnc10Y		    := le.HHMmbrWBkNewMsnc10Y;
	self.attributes.version2.HHMmbrWFrClCnt7Y		        := le.HHMmbrWFrClCnt7Y;
	self.attributes.version2.HHMmbrWFrClNewMSnc7Y		    := le.HHMmbrWFrClNewMSnc7Y;
	
	self.attributes.version2.HHMmbrWithProfLicCnt		    := le.HHMmbrWithProfLicCnt;
	self.attributes.version2.HHMmbrWBusAssocCnt		        := le.HHMmbrWBusAssocCnt;
	self.attributes.version2.HHMmbrWProfLicCat1Cnt		    := le.HHMmbrWProfLicCat1Cnt;
	self.attributes.version2.HHMmbrWProfLicCat2Cnt		    := le.HHMmbrWProfLicCat2Cnt;
	self.attributes.version2.HHMmbrWProfLicCat3Cnt		    := le.HHMmbrWProfLicCat3Cnt;
	self.attributes.version2.HHMmbrWProfLicCat4Cnt		    := le.HHMmbrWProfLicCat4Cnt;
	self.attributes.version2.HHMmbrWProfLicCat5Cnt		    := le.HHMmbrWProfLicCat5Cnt;
	self.attributes.version2.HHMmbrWProfLicUncatCnt		    := le.HHMmbrWProfLicUncatCnt;
	
	self.attributes.version2.HHPurchNewAmt					:= le.HHPurchNewAmt;
	self.attributes.version2.HHPurchTotEv					:= le.HHPurchTotEv;
	self.attributes.version2.HHPurchCntEv					:= le.HHPurchCntEv;
	self.attributes.version2.HHPurchNewMsnc					:= le.HHPurchNewMsnc;
	self.attributes.version2.HHPurchOldMsnc					:= le.HHPurchOldMsnc;
	self.attributes.version2.HHPurchItemCntEv				:= le.HHPurchItemCntEv;
	self.attributes.version2.HHPurchAmtAvg					:= le.HHPurchAmtAvg;
	
	
	self.attributes.version2.RaATeenagerCnt					:= le.RaATeenagerCnt;
	self.attributes.version2.RaAYoungAdultCnt				:= le.RaAYoungAdultCnt;
	self.attributes.version2.RaAMiddleAgeCnt				:= le.RaAMiddleAgeCnt;
	self.attributes.version2.RaASeniorCnt					:= le.RaASeniorCnt;
	self.attributes.version2.RaAElderlyCnt					:= le.RaAElderlyCnt;
	self.attributes.version2.RaAUniqueHHCnt					:= le.RaAUniqueHHCnt;
	self.attributes.version2.RaACnt							:= le.RaACnt;
	self.attributes.version2.RaAMedianIncome				:= le.RaAMedianIncome;
	self.attributes.version2.RaAWEduCollCnt			        := le.RaAWEduCollCnt;
	self.attributes.version2.RaAWEduColl2YCnt		        := le.RaAWEduColl2YCnt;
	self.attributes.version2.RaAWEduColl4YCnt		        := le.RaAWEduColl4YCnt;
	self.attributes.version2.RaAWEduCollGradCnt	            := le.RaAWEduCollGradCnt;
	self.attributes.version2.RaAWCollPvtCnt				    := le.RaAWCollPvtCnt;
	self.attributes.version2.RaAWTopTierCollCnt			    := le.RaAWTopTierCollCnt;
	self.attributes.version2.RaAWMidTierCollCnt				:= le.RaAWMidTierCollCnt;
	self.attributes.version2.RaAWLowTierCollCnt				:= le.RaAWLowTierCollCnt;
	self.attributes.version2.RaACurrAddrCloseDist			:= le.RaACurrAddrCloseDist;
	self.attributes.version2.RaACurrAddrCloseNZDist			:= le.RaACurrAddrCloseNZDist;
	self.attributes.version2.RaACurrAddr25MiDistCnt1Y		:= le.RaACurrAddr25MiDistCnt1Y;
	self.attributes.version2.RaACurrAddr100MiDistCnt1Y		:= le.RaACurrAddr100MiDistCnt1Y;
	self.attributes.version2.RaACurrAddrGT500MiDistCnt1Y	:= le.RaACurrAddrGT500MiDistCnt1Y;
	self.attributes.version2.RelOver500MiCnt1Y				:= le.RelOver500MiCnt1Y;
	self.attributes.version2.RaACurrAddrDistAvg1Y			:= le.RaACurrAddrDistAvg1Y;
	self.attributes.version2.RaAWCrim25MiCnt7Y				:= le.RaAWCrim25MiCnt7Y;
	self.attributes.version2.RaAWCrimCurrAddrCloseDist7Y	:= le.RaAWCrimCurrAddrCloseDist7Y;
	self.attributes.version2.RaAEstIncomeAvg				:= le.RaAEstIncomeAvg;
	self.attributes.version2.RaAEstIncomeMax				:= le.RaAEstIncomeMax;
	self.attributes.version2.RaACurrHomeValAvg				:= le.RaACurrHomeValAvg;
	
	self.attributes.version2.RaAPropOwnCnt					:= le.RaAPropOwnCnt;
	self.attributes.version2.RaAPropCurrOwnTot 			    := le.RaAPropCurrOwnTot;
	self.attributes.version2.RaAPropCurrAVMValMax 	        := le.RaAPropCurrAVMValMax;
	self.attributes.version2.RaAPropCurrAVMValAvg 	        := le.RaAPropCurrAVMValAvg;
	self.attributes.version2.RaAPropCurrAVMValTot		    := le.RaAPropCurrAVMValTot;
	self.attributes.version2.RaAPropCurrAVMValTot1Y			:= le.RaAPropCurrAVMValTot1Y;
	self.attributes.version2.RaAPropCurrAVMValTot5Y			:= le.RaAPropCurrAVMValTot5Y;
	self.attributes.version2.RaAVehicleOwnedCnt				:= le.RaAVehicleOwnedCnt;
	self.attributes.version2.RaAAutoOwnedCnt				:= le.RaAAutoOwnedCnt;
	self.attributes.version2.RaAMotorcycleOwnedCnt			:= le.RaAMotorcycleOwnedCnt;
	self.attributes.version2.RaAAircraftOwnedCnt			:= le.RaAAircraftOwnedCnt;
	self.attributes.version2.RaAWatercraftOwnedCnt			:= le.RaAWatercraftOwnedCnt;
	
	self.attributes.version2.RaAWDrgCnt7Y					:= le.RaAWDrgCnt7Y;
	self.attributes.version2.RaAWDrgCnt1Y					:= le.RaAWDrgCnt1Y;
	self.attributes.version2.RaAWDrgNewMSnc7Y			    := le.RaAWDrgNewMSnc7Y;
	self.attributes.version2.RaAWCrimFelCnt7Y				:= le.RaAWCrimFelCnt7Y;
	self.attributes.version2.RaAWCrimFelCnt1Y		        := le.RaAWCrimFelCnt1Y;
	self.attributes.version2.RaAWCrimFelNewMSnc7Y			:= le.RaAWCrimFelNewMSnc7Y;
	self.attributes.version2.RaAWCrimNFelCnt7Y		        := le.RaAWCrimNFelCnt7Y;
	self.attributes.version2.RaAWCrmiNFelCnt1Y				:= le.RaAWCrmiNFelCnt1Y;
	self.attributes.version2.RaAWCrimNFelNewMSnc7Y		    := le.RaAWCrimNFelNewMSnc7Y;
	self.attributes.version2.RaAWEvictCnt7Y				    := le.RaAWEvictCnt7Y;
	self.attributes.version2.RaAWEvictCnt1Y			        := le.RaAWEvictCnt1Y;
	self.attributes.version2.RaAWEvictNewMSnc7Y				:= le.RaAWEvictNewMSnc7Y;
	self.attributes.version2.RaAWLnJCnt7Y			        := le.RaAWLnJCnt7Y;
	self.attributes.version2.RaAWLnJCnt1Y		            := le.RaAWLnJCnt1Y;
	self.attributes.version2.RaALnJAmtTot		            := le.RaALnJAmtTot;
	self.attributes.version2.RaAWLnJNewMSnc7Y		        := le.RaAWLnJNewMSnc7Y;
	self.attributes.version2.RaAWBkCnt10Y			        := le.RaAWBkCnt10Y;
	self.attributes.version2.RaAWBkCnt1Y			        := le.RaAWBkCnt1Y;
	self.attributes.version2.RaAWBkCnt2Y		            := le.RaAWBkCnt2Y;
	self.attributes.version2.RaAWBkNewMSnc10Y		        := le.RaAWBkNewMSnc10Y;
	self.attributes.version2.RaAFrClCnt7Y			        := le.RaAFrClCnt7Y;
	self.attributes.version2.RaAFrClNewMsnc7Y			    := le.RaAFrClNewMsnc7Y;
	
	self.attributes.version2.RaAWIntSportCnt	            := le.RaAWIntSportCnt;		  
    
	self	:= le;
	self	:= [];
end;

attr := project(withOneClickRollup, getAttr(left)); 


Final := SORT(attr, seq);

// output(p_address,,'~dvstemp::out::property_thor_testing_inputs::p_address_' + thorlib.wuid());
// output(ids_only,,'~dvstemp::out::property_thor_testing_inputs::ids_only_' + thorlib.wuid());
		
/* ********************
 *  Debugging Section *
 ********************* */
 
  // output(slimShell,,'~dvstemp::out::profilebooster::slimshell_' + thorlib.wuid());
  // output(with_mover_model, named('with_mover_model'));
  // output(iid_prep, named('iid_prep'));
  // output(with_DID, named('with_DID'));
  // output(withDoNotMail, named('withDoNotMail'));
  // output(withVerification, named('withVerification'));
  // output(withDeceasedDID, named('withDeceasedDID'));
  // output(rolledDeceased, named('rolledDeceased'));
  // output(withInfutor, named('withInfutor'));
  // output(withInputBus, named('withInputBus'));
  // output(withCurrBus, named('withCurrBus'));
  // output(hhDIDs, named('hhDIDs'));
  // output(relativeDIDs, named('relativeDIDs'));
  // output(allDIDs, named('allDIDs'));
  // output(uniqueDIDs, named('uniqueDIDs'));
  output(choosen(slimShell,100), named('slimShell'));
  // output(ageRecs, named('ageRecs'));
  // output(withAge, named('withAge'));
  // output(tRelaHHcnt, named('tRelaHHcnt'));
  // output(tRelaIncome, named('tRelaIncome'));
  // output(studentRecs, named('studentRecs'));
  // output(withStudent, named('withStudent'));
  // output(watercraftRecs, named('watercraftRecs'));
  // output(withWatercraft, named('withWatercraft'));
  // output(aircraftRecs, named('aircraftRecs'));
  // output(withAircraft, named('withAircraft'));
  // output(vehicleRecs, named('vehicleRecs'));
  // output(withVehicles, named('withVehicles'));
  // output(choosen(derogRecs,100), named('derogRecs'));
//   output(choosen(withDerogs,100), named('withDerogs'));
//   output(choosen(withProfLic,100), named('withProfLic'));
//   output(choosen(withBusnAssoc,100), named('withBusnAssoc'));
//   output(choosen(uccFilings, 100), named('uccFilings'));
  // output(choosen(sportsRecs,100), named('sportsRecs'));
  // output(choosen(withSports,100), named('withSports'));
  // output(p_address, named('p_address'));
  // output(ids_only, named('ids_only'));
  // output(p_address,, '~dvstemp::profile_booster_property_testcase::p_address::mathis_' + thorlib.wuid());
  // output(ids_only,, '~dvstemp::profile_booster_property_testcase::ids_only::mathis_' + thorlib.wuid());
	// output(choosen(with_InputBus_curraddrpopulated,100), named('with_InputBus_curraddrpopulated'));
  // output(choosen(with_infutor_inputaddrpopulated,100), named('with_infutor_inputaddrpopulated'));
  // output(choosen(with_infutor_inputaddr_notpopulated,100), named('with_infutor_inputaddr_notpopulated'));
  // output(choosen(prop_common,100), named('prop_common'));	
  // output(choosen(withProperty,100), named('withProperty'));
  // output(choosen(sortedProperty,100), named('sortedProperty'));
  // output(choosen(rolledProperty,100), named('rolledProperty'));
  // output(choosen(preAVM,100), named('preAVM'));
  // output(choosen(AVMrecs,100), named('AVMrecs'));
  // output(choosen(withAVM,100), named('withAVM'));
  // output(choosen(propOwners,100), named('propOwners'));
  // output(choosen(preAVMOwned,100), named('preAVMOwned'));
  // output(choosen(avm1Owned,100), named('avm1Owned'));
  // output(choosen(avms1Owned,100), named('avms1Owned'));
  // output(choosen(withAVMOwned,100), named('withAVMOwned'));
  // output(choosen(sortedAVMOwned,100), named('sortedAVMOwned'));
  // output(choosen(rolledAVMOwned,100), named('rolledAVMOwned'));
  // output(choosen(BSAVM,100), named('BSAVM'));
  // output(choosen(BSappended,100), named('BSappended'));
  // output(choosen(econTraj,100), named('econTraj'));
  // output(choosen(withEconTraj,100), named('withEconTraj'));
  // output(choosen(finalSort,100), named('finalSort'));
  // output(finalRollup, named('finalRollup'));
  // output(withRelaIncome, named('withRelaIncome'));
  // output(withRelaHHcnt, named('withRelaHHcnt'));
  // output(attributes, named('attributes'));
  // output(withIncome, named('withIncome'));
  // output(withHHIncome, named('withHHIncome'));
  // output( withBankingExperiance, named('withBankingExperiance'));
  // output(withAVM,, '~jfrancis::profile_booster20::withAVM_' + thorlib.wuid(), OVERWRITE);
//   testdids := [1439701036,10451331058,35079677273,1469465500,329715771,2602737429,1814630365,190567206340,333465668,145261689458,1240516440,645711285];
//   output(profLicRecs(did in testdids),named('profLicRecsSample'));
//   output(withProfLic(did in testdids),named('withProfLicSample'));
  //output(withStudent(did IN testdids),, '~jfrancis::profile_booster20::withStudent_' + thorlib.wuid(), OVERWRITE);
  //output(withWatercraft(did IN testdids),, '~jfrancis::profile_booster20::withWatercraft_' + thorlib.wuid(), OVERWRITE);
  //output(withAircraft(did IN testdids),, '~jfrancis::profile_booster20::withAircraft_' + thorlib.wuid(), OVERWRITE);
  //output(vehicleRecs(did IN testdids),, '~jfrancis::profile_booster20::vehicleRecs_' + thorlib.wuid(), OVERWRITE);
  //output(withVehicles(did IN testdids),, '~jfrancis::profile_booster20::withVehicles_' + thorlib.wuid(), OVERWRITE);
  //output(prop_common(did IN testdids), named('prop_common_sample'));	
  //output(withProperty(did IN testdids), named('withProperty_sample'));
  //output(choosen(withOneClickKey,1000), named('withOneClickKey'));
  //output(choosen(withOneClickRollup,1000), named('withOneClickRollup'));

/* ********************/

return Final;	


END;
