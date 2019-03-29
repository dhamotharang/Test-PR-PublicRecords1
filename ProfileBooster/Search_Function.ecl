import 	_Control, address, Address_Attributes, avm_v2, dma, doxie, Gateway, iesp, LN_PropertyV2_Services, mdr, ProfileBooster, 
				Riskwise, Risk_Indicators, ut, Relationship, aid, std;
onThor := _Control.Environment.OnThor;

EXPORT Search_Function(DATASET(ProfileBooster.Layouts.Layout_PB_In) PB_In, 
																						string50 DataRestrictionMask,
																						string50 DataPermissionMask,
																						string8 AttributesVersion, 
                                            boolean domodel=false,
                                            string modelname = ''
                                            ) := FUNCTION

BOOLEAN DEBUG := FALSE;

	isFCRA 			:= false;
	GLBA 				:= 0;
	DPPA 				:= 0;
	BSOptions := Risk_Indicators.iid_constants.BSOptions.RetainInputDID;
	bsversion := 50;
	append_best := 0;	
	gateways    := dataset([],Gateway.Layouts.Config);
	todaysdate	:= (STRING8)Std.Date.Today();
	nines		 		:= 9999999;

// ********************************************************************
// Transform PB input to Layout_Input so we can call iid_getDID_prepOutput
// ********************************************************************

Risk_Indicators.Layout_Input into(PB_In l) := TRANSFORM
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
		
		addr_value 	:= trim(l.street_addr);
		clean_a2 		:= Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, l.City_name, l.st, l.z5);
		self.in_streetAddress:= addr_value;
		self.in_city         := l.City_name;
		self.in_state        := l.st;
		self.in_zipCode      := l.z5;	
		self.prim_range      := Address.CleanFields(clean_a2).prim_range;
		self.predir          := Address.CleanFields(clean_a2).predir;
		self.prim_name       := Address.CleanFields(clean_a2).prim_name;
		self.addr_suffix     := Address.CleanFields(clean_a2).addr_suffix;
		self.postdir         := Address.CleanFields(clean_a2).postdir;
		self.unit_desig      := Address.CleanFields(clean_a2).unit_desig;
		self.sec_range       := Address.CleanFields(clean_a2).sec_range;
		self.p_city_name     := Address.CleanFields(clean_a2).p_city_name;
		self.st              := Address.CleanFields(clean_a2).st;
		self.z5              := Address.CleanFields(clean_a2).zip;
		self.zip4            := Address.CleanFields(clean_a2).zip4;
		self.lat             := Address.CleanFields(clean_a2).geo_lat;
		self.long            := Address.CleanFields(clean_a2).geo_long;
		self.addr_type 			 := risk_indicators.iid_constants.override_addr_type(l.street_addr, Address.CleanFields(clean_a2).rec_type[1],Address.CleanFields(clean_a2).cart);
		self.addr_status     := Address.CleanFields(clean_a2).err_stat;
		county          		 := Address.CleanFields(clean_a2).county;
		self.county          := county[3..5]; //bytes 1-2 are state code, 3-5 are county number
		self.geo_blk         := Address.CleanFields(clean_a2).geo_blk;
		self.Phone10				 := StringLib.StringFilter(l.Phone10, '0123456789');
		self := [];
	END;




	iid_prep_roxie := PROJECT(PB_In, into(left));	


// NEW::  Calling the AID address cache macro now that Tony added the new feature for us:  https://bugzilla.seisint.com/show_bug.cgi?id=194258

r_layout_input_PlusRaw	:=
record
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
	with_DID := JOIN(distribute(PB_In, seq), distribute(did_prepped_output, seq), 
									LEFT.seq = RIGHT.seq, TRANSFORM(Risk_Indicators.Layout_Output, SELF.Account := LEFT.AcctNo; SELF := RIGHT), local);


donotmail_key := dma.key_DNM_Name_Address;

//join to DoNotMail to set the DNM attribute
	ProfileBooster.Layouts.Layout_PB_Shell setDNMFlag(with_DID le, donotmail_key ri ) := TRANSFORM
		self.DoNotMail 		:= if(ri.l_zip='', '0', '1');
		self.DID2 				:= le.DID; 	//propogate the prospect's DID to DID2 at this point
		self.rec_type 		:= ProfileBooster.Constants.recType.Prospect; //all records are "Prospect" type at this point.  Household and Relatives will be added later.
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
	
  withVerification := ProfileBooster.getVerification(withDoNotMail);

//Search Death Master by DID. Set 2 dates (1 with SSA permission and 1 not) and choose appropriately 
	ProfileBooster.Layouts.Layout_PB_Shell getDeceasedDID(withVerification le, Doxie.key_Death_masterV2_DID ri) := transform
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
  ProfileBooster.Layouts.Layout_PB_Shell rollDeceased(ProfileBooster.Layouts.Layout_PB_Shell le, ProfileBooster.Layouts.Layout_PB_Shell ri) := transform
		self.dod		:= max(le.dod, ri.dod);
		self.dodSSA	:= max(le.dodSSA, ri.dodSSA);
		self				:= le;
	end;
	
  rolledDeceased := rollup(sortedDeceased, rollDeceased(left,right), seq);

//join to the Infutor key to get marital status and gender
	ProfileBooster.Layouts.Layout_PB_Shell getInfutor(rolledDeceased le, ProfileBooster.Key_Infutor_DID ri ) := TRANSFORM
		self.marital_status	:= ri.marital_status;
		self.gender					:= ri.gender;
		self.DOB						:= if(le.DOB = '', ri.DOB, le.DOB);
    historydate := risk_indicators.iid_constants.myGetDate(le.historydate)[1..6]; 
		self.ProspectAge		:= if(le.ProspectAge <> 0, le.ProspectAge, risk_indicators.years_apart((unsigned)HistoryDate, (unsigned)ri.DOB));
		self 								:= le;
	END;
	
	withInfutor_roxie := join(rolledDeceased, ProfileBooster.Key_Infutor_DID,
		keyed(left.DID = right.DID), 
		getInfutor(left,right), left outer, keep(1)
	);
	
	withInfutor_thor := join(distribute(rolledDeceased, did), 
													 distribute(pull(ProfileBooster.Key_Infutor_DID), did),
		left.DID = right.DID, 
		getInfutor(left,right), left outer, keep(1), local)
	// ;	
	: PERSIST('~PROFILEBOOSTER::with_infutor_thor_full'); // remove persists because low on disk space and it's rebuilding persist file each time anyway
	
	#IF(onThor)
		withInfutor := withInfutor_thor;
	#ELSE
		withInfutor := withInfutor_roxie;
	#END
	
//get business count for the input address
ProfileBooster.Layouts.Layout_PB_Shell getInputBus(withInfutor le, Address_Attributes.key_AML_addr ri)  := TRANSFORM
		self.ResInputBusinessCnt 	:= ri.biz_cnt;
		// self.ResCurrBusinessCnt 	:= if(le.curr_equals_input, ri.biz_cnt, 0);
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
ProfileBooster.Layouts.Layout_PB_Shell  getCurrBus(withInputBus le, Address_Attributes.key_AML_addr ri)  := TRANSFORM
		self.ResCurrBusinessCnt := if(ri.biz_cnt > 0, ri.biz_cnt, le.ResCurrBusinessCnt); 
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
ProfileBooster.Layouts.Layout_PB_Shell add_household_members(ProfileBooster.Layouts.Layout_PB_Shell le, doxie.Key_HHID_Did rt) := transform
		self.DID2			:= rt.DID;
		self.rec_type	:= ProfileBooster.Constants.recType.Household; //set rec_type as household member
		self := le;
end;

	hhDIDs_roxie := join(withCurrBus, doxie.Key_HHID_Did,
												keyed(left.HHID = right.hhid_relat) and
												keyed(right.ver = 1) and 			//ver of 1 = current household members
												left.DID <> right.DID,	//exclude the prospect's DID - we already have it as the prospect record
												add_household_members(left, right),
												atmost(RiskWise.max_atmost),keep(300));		

	hhDIDs_thor_hits := join(distribute(withCurrBus(hhid<>0), hhid),
											distribute(pull(doxie.Key_HHID_Did), hhid_relat),
												left.HHID = right.hhid_relat and
												right.ver = 1 and 			//ver of 1 = current household members
												left.DID <> right.DID,	//exclude the prospect's DID - we already have it as the prospect record
												add_household_members(left, right),
												keep(300), local);		
	hhDIDs_thor := hhDIDs_thor_hits + withCurrBus(hhid=0);	// add back the records with no hhid										

	#IF(onThor)
		hhDIDs := hhDIDs_thor;
	#ELSE
		hhDIDs := hhDIDs_roxie;
	#END
  
//get relatives (DIDs) by doing inner join 
	withCurrBus_dedp := dedup(sort(withCurrBus,did), did);
	RelativeMax := 300;
	withCurrBus_dids := PROJECT(withCurrBus_dedp, 
		TRANSFORM(Relationship.Layout_GetRelationship.DIDs_layout, SELF.DID := LEFT.DID));
	rellyids := Relationship.proc_GetRelationship(withCurrBus_dids,TopNCount:=RelativeMax,
		RelativeFlag:=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RelativeMax, doThor := onThor).result; 
	
	relativeDIDs_roxie := join(withCurrBus, rellyids,
												left.did = right.did1,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.DID2			:= right.did2;
																	self.rec_type	:= ProfileBooster.Constants.recType.Relative; //set rec_type as relative
																	self := left));		
	relativeDIDs_thor := join(distribute(withCurrBus, did), 
														distribute(rellyids, did1),
												left.did = right.did1,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.DID2			:= right.did2;
																	self.rec_type	:= ProfileBooster.Constants.recType.Relative; //set rec_type as relative
																	self := left), 
														local);
														
	#IF(onThor)
		relativeDIDs := relativeDIDs_thor;
	#ELSE
		relativeDIDs := relativeDIDs_roxie;
	#END

//merge Prospect rec, Household recs, Relatives recs into one file
	allDIDs := withCurrBus + hhDIDs + relativeDIDs;
	
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
												transform(ProfileBooster.Layouts.Layout_PB_Slim,
																	self 							:= left));

//--------- Get age of household members and relatives -------------//

	ageRecs 		:= ProfileBooster.getAge(slimShell(DID <> DID2)); //we already have age of prospect so exclude them here
		
	dedupHH 	 	:= dedup(sort(ageRecs(rec_type=ProfileBooster.Constants.recType.Relative), seq, HHID), seq, HHID); 

	tRelaHHcnt 	:= table(dedupHH, {seq, RelaHHcnt := count(group)}, seq); //count number of unique HHIDs within relative recs
	tRelaIncome := table(ageRecs(rec_type=ProfileBooster.Constants.recType.Relative and med_hhinc <> 0), {seq, RelaIncome := ave(group, med_hhinc)}, seq);
	
	withAge := join(uniqueDIDs, ageRecs,  
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.HHTeenagerMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age between 13 and 19, 1, 0);  
																	self.HHYoungAdultMmbrCnt 	:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age between 20 and 39, 1, 0);  
																	self.HHMiddleAgemmbrCnt 	:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age between 40 and 64, 1, 0);  
																	self.HHSeniorMmbrCnt 			:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age between 65 and 79, 1, 0);  
																	self.HHElderlyMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Household and right.age > 79, 1, 0);  
																	self.HHCnt 								:= if(left.rec_type = ProfileBooster.Constants.recType.Household, 1, 0);  
																	self.RaATeenageMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age between 13 and 19, 1, 0);  
																	self.RaAYoungAdultMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age between 20 and 39, 1, 0);  
																	self.RaAMiddleAgeMmbrCnt 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age between 40 and 64, 1, 0);  
																	self.RaASeniorMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age between 65 and 79, 1, 0);  
																	self.RaAElderlyMmbrCnt 		:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.age > 79, 1, 0);  
																	self.RaAMmbrCnt 					:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, 1, 0);  
																	self := left), left outer);

//--------- Student-------------//

	dk := choosen(doxie.key_max_dt_last_seen, 1);
	hdrBuildDate01 := dk[1].max_date_last_seen[1..6]+'01';

	studentRecs := ProfileBooster.getStudent(slimShell);
	
	withStudent := join(withAge, studentRecs,
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	within4Years											:= right.student_college_code = '4' and ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.student_date_first_seen,true) < 49;
																	within2Years											:= right.student_college_code = '2' and ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.student_date_first_seen,true) < 25;
																	self.ProspectCollegeAttending			:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect and (within4Years or within2Years), '1', '0');
																	self.ProspectCollegeAttended			:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect and right.student_date_first_seen <> '', '1', '0');
																	self.ProspectCollegeProgramType		:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, 
																																					map(right.student_college_code = '1'	=> '3', 
																																							right.student_college_code = '4'	=> '2',
																																							right.student_college_code = '2'	=> '1',
																																																									 '0'),
																																					'0');
																	self.ProspectCollegePrivate				:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect and right.student_college_type in ['P','R'], '1', '0'); 
																	self.ProspectCollegeTier					:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect and right.student_college_tier <> '', right.student_college_tier, '0');
																	//include prospect information in with the household attributes (rec_type = 1 or 2)
																	self.HHCollegeAttendedMmbrCnt 	 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_date_first_seen <> '', 1, 0);
																	self.HHCollege2yrAttendedMmbrCnt 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_code = '2', 1, 0); 
																	self.HHCollege4yrAttendedMmbrCnt 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_code = '4', 1, 0); 
																	self.HHCollegeGradAttendedMmbrCnt := if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_code = '1', 1, 0);  
																	self.HHCollegePrivateMmbrCnt		 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_type = 'P', 1, 0);
																	self.HHCollegeTierMmbrHighest		 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.student_college_tier <> '', (integer)right.student_college_tier, 0);
																	//do not include prospect information in with relatives attributes
																	self.RaACollegeAttendedMmbrCnt 	 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_date_first_seen <> '', 1, 0);
																	self.RaACollege2yrAttendedMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_code = '2', 1, 0); 
																	self.RaACollege4yrAttendedMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_code = '4', 1, 0); 
																	self.RaACollegeGradAttendedMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_code = '1', 1, 0);  
																	self.RaACollegePrivateMmbrCnt		 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_type = 'P', 1, 0);
																	self.RaACollegeTopTierMmbrCnt		 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_tier in ['1','2'], 1, 0);
																	self.RaACollegeMidTierMmbrCnt		 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_tier in ['3','4'], 1, 0);
																	self.RaACollegeLowTierMmbrCnt		 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.student_college_tier in ['5','6'], 1, 0);
																	self := left), left outer, parallel);
																	
//--------- Watercraft-------------//

	watercraftRecs := ProfileBooster.getWatercraft(slimShell);
	
	withWatercraft := join(withStudent, watercraftRecs,
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.PPCurrOwnedWtrcrftCnt 	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.watercraftCount, 0);
																	self.PPCurrOwner 						:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, if(right.watercraftCount > 0, 1, left.PPCurrOwner), left.PPCurrOwner);
																	self.PPCurrOwnedCnt 				:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, left.PPCurrOwnedCnt + right.watercraftCount, left.PPCurrOwnedCnt);
																	self.LifeEvTimeFirstAssetPurchase	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, max(left.LifeEvTimeFirstAssetPurchase, right.months_first_reg), left.LifeEvTimeFirstAssetPurchase);
																	//we want most recent purchase here so keep smallest number of months back but disregard 0
																	self.LifeEvTimeLastAssetPurchase		:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, map(right.months_first_reg = 0	=> left.LifeEvTimeLastAssetPurchase,
																																																 left.LifeEvTimeLastAssetPurchase = 0	=> right.months_last_reg,
																																																 min(left.LifeEvTimeLastAssetPurchase,right.months_last_reg)),
																																						left.LifeEvTimeLastAssetPurchase);
																	self.HHPPCurrOwnedCnt 				:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], left.HHPPCurrOwnedCnt + right.watercraftCount, left.HHPPCurrOwnedCnt);  //sum all personal prop for household member
																	self.HHPPCurrOwnedWtrcrftCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.watercraftCount, 0);
																	self.RaAPPCurrOwnerMmbrCnt				:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.watercraftCount > 0, 1, left.RaAPPCurrOwnerMmbrCnt); //flag if relative owns any personal prop
																	self.RaAPPCurrOwnerWtrcrftMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.watercraftCount > 0, 1, 0);
																	self := left), left outer, parallel);
																	
//--------- Aircraft -------------//

	aircraftRecs := ProfileBooster.getAircraft(slimShell);
	
	withAircraft := join(withWatercraft, aircraftRecs,
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.PPCurrOwnedAircrftCnt	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.aircraftCount, 0);
																	self.PPCurrOwner 						:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, if(right.aircraftCount > 0, 1, left.PPCurrOwner), left.PPCurrOwner);
																	self.PPCurrOwnedCnt 				:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, left.PPCurrOwnedCnt + right.aircraftCount, left.PPCurrOwnedCnt);
																	self.LifeEvTimeFirstAssetPurchase	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, max(left.LifeEvTimeFirstAssetPurchase, right.months_first_reg), left.LifeEvTimeFirstAssetPurchase);
																	//we want most recent purchase here so keep smallest number of months back but disregard 0
																	self.LifeEvTimeLastAssetPurchase		:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, 
																																						map(right.months_first_reg = 0	=> 					 left.LifeEvTimeLastAssetPurchase,
																																								left.LifeEvTimeLastAssetPurchase = 0	=> right.months_last_reg,
																																																												 min(left.LifeEvTimeLastAssetPurchase,right.months_last_reg)),
																																						left.LifeEvTimeLastAssetPurchase);
																	self.HHPPCurrOwnedCnt 				:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], left.HHPPCurrOwnedCnt + right.aircraftCount, left.HHPPCurrOwnedCnt);	//sum all personal prop for household member
																	self.HHPPCurrOwnedAircrftCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.aircraftCount, 0);
																	self.RaAPPCurrOwnerMmbrCnt				 := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.aircraftCount > 0, 1, left.RaAPPCurrOwnerMmbrCnt);	//flag if relative owns any personal prop
																	self.RaAPPCurrOwnerAircrftMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.aircraftCount > 0, 1, 0);
																	self := left), left outer, parallel);		

//--------- Vehicles -------------//

	vehicleRecs := ProfileBooster.getVehicles(slimShell);
	
	withVehicles := join(withAircraft, vehicleRecs,
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.PPCurrOwnedAutoCnt					:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.vehicleCount, 0);
																	self.PPCurrOwnedMtrcycleCnt			:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.motorcycleCount, 0);
																	self.PPCurrOwner 								:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, if(right.vehicleCount + right.motorcycleCount > 0, 1, left.PPCurrOwner), left.PPCurrOwner);
																	self.PPCurrOwnedCnt 						:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, left.PPCurrOwnedCnt + right.vehicleCount + right.motorcycleCount, left.PPCurrOwnedCnt);
																	self.LifeEvTimeFirstAssetPurchase	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, max(left.LifeEvTimeFirstAssetPurchase, right.months_first_reg), left.LifeEvTimeFirstAssetPurchase);
																	//we want most recent purchase here so keep smallest number of months back but disregard 0
																	self.LifeEvTimeLastAssetPurchase		:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, 
																																						map(right.months_first_reg = 0						=> left.LifeEvTimeLastAssetPurchase,
																																								left.LifeEvTimeLastAssetPurchase = 0	=> right.months_last_reg,
																																																												 min(left.LifeEvTimeLastAssetPurchase,right.months_last_reg)),
																																						left.LifeEvTimeLastAssetPurchase);
																	self.HHPPCurrOwnedCnt 					:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], left.HHPPCurrOwnedCnt + right.vehicleCount + right.motorcycleCount, left.HHPPCurrOwnedCnt);
																	self.HHPPCurrOwnedAutoCnt				:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.vehicleCount, 0);
																	self.HHPPCurrOwnedMtrcycleCnt		:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.motorcycleCount, 0);
																	self.RaAPPCurrOwnerMmbrCnt				 := if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.vehicleCount + right.motorcycleCount > 0, 1, left.RaAPPCurrOwnerMmbrCnt), left.RaAPPCurrOwnerMmbrCnt);
																	self.RaAPPCurrOwnerAutoMmbrCnt 		 := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.vehicleCount > 0, 1, 0);
																	self.RaAPPCurrOwnerMtrcycleMmbrCnt := if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.motorcycleCount > 0, 1, 0);
		
																	SELF.PPCurrOwnedAutoVIN := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoVIN, '');
																	self.PPCurrOwnedAutoYear  := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoYear, '');
																	self.PPCurrOwnedAutoMake := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoMake, '');
																	self.PPCurrOwnedAutoModel := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoModel, '');
																	self.PPCurrOwnedAutoSeries := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoSeries, '');
																	self.PPCurrOwnedAutoType := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.PPCurrOwnedAutoType, '');
	
																	self := left																	
																	), left outer, parallel);	

//--------- Derogs -------------//

	preDerogs := group(project(slimShell,  
												transform(Risk_Indicators.layouts.layout_derogs_input,
																	self.seq 					:= left.seq;
																	self.did 					:= left.did2;
																	self.historydate 	:= left.historydate;
																	self 							:= [])), seq);
	
	derogRecs := ProfileBooster.getDerogs_Hist(preDerogs);

	withDerogs := join(withVehicles, derogRecs,
												left.seq = right.seq and
												left.did2 = right.did,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	totalCourtRecs := sum(right.BJL.filing_count, right.BJL.eviction_count, right.BJL.felony_count, 
																												right.BJL.liens_recent_unreleased_count, right.BJL.liens_historical_unreleased_count, 
																												right.BJL.nonfelony_criminal_count); 
																	
																	self.CrtRecCnt			:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, totalCourtRecs, 0);
																	totalCourtRecs12Mo	:= sum(right.BJL.bk_count12, right.BJL.eviction_count12, right.BJL.criminal_count12, 
																														 right.BJL.liens_unreleased_count12, right.BJL.nonfelony_criminal_count12); 
																	self.CrtRecCnt12Mo	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, totalCourtRecs12Mo, 0);
																	lastFelony	 := if(right.BJL.last_felony_date <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.BJL.last_felony_date,true), nines);
																	lastCrime		 := if(right.BJL.last_nonfelony_criminal_date <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.BJL.last_nonfelony_criminal_date,true), nines);
																	lastLien		 := if((integer)right.BJL.last_liens_unreleased_date <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),right.BJL.last_liens_unreleased_date,true), nines);
																	lastBankrupt := if(right.BJL.date_last_seen <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.BJL.date_last_seen,true), nines);
																	lastEviction := if(right.BJL.last_eviction_date <> 0, ProfileBooster.Common.MonthsApart_YYYYMMDD(risk_indicators.iid_constants.myGetDate(left.historydate),(string)right.BJL.last_eviction_date,true), nines);
																	lastCourtRec := min(lastFelony,lastCrime,lastLien,lastBankrupt,lastEviction); 
																	
																	self.CrtRecTimeNewest	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, lastCourtRec, 0);
																	
																	self.CrtRecFelonyCnt 	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.felony_Count, 0);
																	self.CrtRecFelonyCnt12Mo	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.criminal_Count12, 0);
																	self.CrtRecFelonyTimeNewest	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, lastFelony, 0);
																	
																	self.CrtRecMsdmeanCnt 	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.nonfelony_criminal_count, 0); 
																	self.CrtRecMsdmeanCnt12Mo	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.nonfelony_criminal_count12, 0); //populates only for FCRA
																	self.CrtRecMsdmeanTimeNewest	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, lastCrime, 0);

																	self.CrtRecEvictionCnt 	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.eviction_count, 0);
																	self.CrtRecEvictionCnt12Mo	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.eviction_count12, 0);
																	self.CrtRecEvictionTimeNewest	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, lastEviction, 0);

																	self.CrtRecLienJudgCnt 	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.liens_recent_unreleased_count + right.BJL.liens_historical_unreleased_count, 0);
																	self.CrtRecLienJudgCnt12Mo	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.liens_unreleased_count12, 0);
																	self.CrtRecLienJudgTimeNewest	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, lastLien, 0);
																	totalLienAmount	:= sum(right.Liens.liens_unreleased_civil_judgment.total_amount,
																												 right.Liens.liens_unreleased_federal_tax.total_amount,
																												 right.Liens.liens_unreleased_foreclosure.total_amount,
																												 right.Liens.liens_unreleased_landlord_tenant.total_amount,
																												 right.Liens.liens_unreleased_lispendens.total_amount,
																												 right.Liens.liens_unreleased_other_lj.total_amount,
																												 right.Liens.liens_unreleased_other_tax.total_amount,
																												 right.Liens.liens_unreleased_small_claims.total_amount,
																												 right.Liens.liens_unreleased_suits.total_amount);
																	self.CrtRecLienJudgAmtTtl	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, totalLienAmount, 0);
																
																	self.CrtRecBkrptCnt 	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.filing_count, 0);
																	self.CrtRecBkrptCnt12Mo	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.BJL.BK_count12, 0);
																	self.CrtRecBkrptTimeNewest	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, lastBankrupt, 0);
																	self.CrtRecSeverityIndex	:= map(left.rec_type<>ProfileBooster.Constants.recType.Prospect	=> '0',
																																	 right.BJL.felony_count > 0																=> '5',
																																	 right.BJL.eviction_count > 0															=> '4',
																																	 right.BJL.liens_recent_unreleased_count + right.BJL.liens_historical_unreleased_count > 0 =>	'3',
																																	 right.BJL.nonfelony_criminal_count > 0 									=> '2',
																																	 right.BJL.filing_count > 0 															=> '1',
																																																															 '0');
																	self.HHCrtRecMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(totalCourtRecs > 0, 1, 0), 0);
																	self.HHCrtRecMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(totalCourtRecs12Mo > 0, 1, 0), 0);
																	self.HHCrtRecFelonyMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.felony_Count > 0, 1, 0), 0);
																	self.HHCrtRecFelonyMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.criminal_Count12 > 0, 1, 0), 0);
																	self.HHCrtRecMsdmeanMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.nonfelony_criminal_count > 0, 1, 0), 0);
																	self.HHCrtRecMsdmeanMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.nonfelony_criminal_count12 > 0, 1, 0), 0);
																	self.HHCrtRecEvictionMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.eviction_count > 0, 1, 0), 0);
																	self.HHCrtRecEvictionMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.eviction_count12 > 0, 1, 0), 0);
																	self.HHCrtRecLienJudgMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.liens_recent_unreleased_count + right.BJL.liens_historical_unreleased_count > 0, 1, 0), 0);
																	self.HHCrtRecLienJudgMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.liens_unreleased_count12 > 0, 1, 0), 0);
																	self.HHCrtRecLienJudgAmtTtl	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], totalLienAmount, 0);
																	self.HHCrtRecBkrptMmbrCnt	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.filing_count > 0, 1, 0), 0);
																	self.HHCrtRecBkrptMmbrCnt12Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.BK_count12 > 0, 1, 0), 0);
																	self.HHCrtRecBkrptMmbrCnt24Mo	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], if(right.BJL.BK_count24 > 0, 1, 0), 0);

																	self.RaACrtRecMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(totalCourtRecs > 0, 1, 0), 0);
																	self.RaACrtRecMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(totalCourtRecs12Mo > 0, 1, 0), 0);
																	self.RaACrtRecFelonyMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.felony_Count > 0, 1, 0), 0);
																	self.RaACrtRecFelonyMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.criminal_Count12 > 0, 1, 0), 0);
																	self.RaACrtRecMsdmeanMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.nonfelony_criminal_count > 0, 1, 0), 0);
																	self.RaACrtRecMsdmeanMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.nonfelony_criminal_count12 > 0, 1, 0), 0);
																	self.RaACrtRecEvictionMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.eviction_count > 0, 1, 0), 0);
																	self.RaACrtRecEvictionMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.eviction_count12 > 0, 1, 0), 0);
																	self.RaACrtRecLienJudgMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.liens_recent_unreleased_count + right.BJL.liens_historical_unreleased_count > 0, 1, 0), 0);
																	self.RaACrtRecLienJudgMmbrCnt12Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.liens_unreleased_count12 > 0, 1, 0), 0);
																	//take the highest of the lien amounts but cap at 9,999,999
																	RaACrtRecLienJudgAmtMax  := max(
																																	 right.Liens.liens_unreleased_federal_tax.total_amount,
																																	 right.Liens.liens_unreleased_foreclosure.total_amount,
																																	 right.Liens.liens_unreleased_landlord_tenant.total_amount,
																																	 right.Liens.liens_unreleased_lispendens.total_amount,
																																	 right.Liens.liens_unreleased_other_lj.total_amount,
																																	 right.Liens.liens_unreleased_other_tax.total_amount,
																																	 right.Liens.liens_unreleased_small_claims.total_amount,
																																	 right.Liens.liens_unreleased_suits.total_amount);
																	self.RaACrtRecLienJudgAmtMax  := if(left.rec_type = ProfileBooster.Constants.recType.Relative, min(RaACrtRecLienJudgAmtMax, nines), 0); 
																	self.RaACrtRecBkrptMmbrCnt36Mo	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, if(right.BJL.BK_count36 > 0, 1, 0), 0);
																	self := left), left outer, parallel);	

//--------- Professional License -------------//

	profLicRecs := ProfileBooster.getProfLic(slimShell);
	
	withProfLic := join(withDerogs, profLicRecs,
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.OccProfLicense 				:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, (integer)right.professional_license_flag, 0);
																	self.OccProfLicenseCategory := if(left.rec_type=ProfileBooster.Constants.recType.Prospect, if(right.PLcategory <> '', right.PLcategory, '0'), '0');
																	self.HHOccProfLicMmbrCnt 		:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.professional_license_flag=true, 1, 0);  
																	self.RaAOccProfLicMmbrCnt		:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.professional_license_flag=true, 1, 0); 
																	self := left), left outer, parallel);

//--------- People at Work -------------//

	busnAssocRecs := ProfileBooster.getBusnAssoc(slimShell);
	
	withBusnAssoc := join(withProfLic, busnAssocRecs,
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.OccBusinessAssociation 		:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.OccBusinessAssociation, 0);	
																	self.OccBusinessAssociationTime	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect and right.contact_id<>0, right.OccBusinessAssociationTime, nines);
																	self.OccBusinessTitleLeadership	:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.OccBusinessTitleLeadership, 0);
																	self.HHOccBusinessAssocMmbrCnt 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.OccBusinessAssociation = 1, 1, 0);  
																	self.RaAOccBusinessAssocMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.OccBusinessAssociation = 1, 1, 0); 
																	self := left), left outer, parallel);

//--------- Outdoor sports -------------//

	sportsRecs := ProfileBooster.getSports(slimShell);
	
	withSports_temp := join(withBusnAssoc, sportsRecs,
												left.seq = right.seq and
												left.did2 = right.did2,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.InterestSportPerson 						:= if(left.rec_type=ProfileBooster.Constants.recType.Prospect, right.sportsInterest, 0);	
																	self.HHInterestSportPersonMmbrCnt 	:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and right.sportsInterest = 1, 1, 0);  
																	self.RaAInterestSportPersonMmbrCnt	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative and right.sportsInterest = 1, 1, 0); 
																	self := left), left outer, parallel);
	with_Sports_thor := withSports_temp : PERSIST('~PROFILEBOOSTER::with_Sports_thor') ;  // try adding another stopping point here to help out  // remove persists because low on disk space and it's rebuilding persist file each time anyway

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
	

ProfileBooster.Layouts.Layout_PB_Shell append_property(ProfileBooster.Layouts.Layout_PB_Shell le, prop_common rt) := transform
		//see if the input address or current address came back as an owned address
		isInputAddr												:= le.z5=rt.zip5 and le.prim_range=rt.prim_range and le.prim_name=rt.prim_name;                              
		isCurrAddr												:= le.curr_z5=rt.zip5 and le.curr_prim_range=rt.prim_range and le.curr_prim_name=rt.prim_name;
		isPrevAddr												:= le.prev_z5=rt.zip5 and le.prev_prim_range=rt.prim_range and le.prev_prim_name=rt.prim_name;
		self.sale_date_by_did							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect, rt.sale_date_by_did, 0);
		self.PropCurrOwner								:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'O', 1, 0);
		self.PropCurrOwnedCnt							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'O', 1, 0);
		self.PropCurrOwnedAssessedTtl			:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'O', rt.assessed_amount, 0);
		validsaledate := Doxie.DOBTools(rt.sale_date_by_did).IsValidDOB;
		monthsSinceSold 									:= if(~validsaledate, nines, min(ProfileBooster.Common.MonthsApart_YYYYMMDD((string)rt.sale_date_by_did,risk_indicators.iid_constants.myGetDate(le.historydate),true),960));
		self.PropTimeLastSale							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and validsaledate, monthsSinceSold, nines);
		self.PropEverOwnedCnt							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant in ['O','S'], 1, 0);
		self.PropEverSoldCnt							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and rt.property_status_applicant = 'S', 1, 0);
		self.PropSoldCnt12Mo							:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and validsaledate and monthsSinceSold <= 12, 1, 0);
		salePrice													:= if(rt.sale_price1<>0, rt.sale_price1, rt.sale_price2);
		self.PropSoldRatio := if(rt.purchase_amount = 0 or salePrice = 0, 
														 '0', 
														 trim((string)(decimal4_2)min(salePrice / rt.purchase_amount, 99.0)));
		validpurchasedate := Doxie.DOBTools(rt.purchase_date_by_did).IsValidDOB;
		monthsSincePurchased							:= if(~validpurchasedate, 0, min(ProfileBooster.Common.MonthsApart_YYYYMMDD((string)rt.purchase_date_by_did,risk_indicators.iid_constants.myGetDate(le.historydate),true),960));
		self.PropPurchaseCnt12Mo					:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and monthsSincePurchased <> 0 and monthsSincePurchased <= 12, 1, 0);
		self.LifeEvTimeFirstAssetPurchase	:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect, max(le.LifeEvTimeFirstAssetPurchase, monthsSincePurchased), le.LifeEvTimeFirstAssetPurchase);
		self.LifeEvTimeLastAssetPurchase	:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect, 
																						map(monthsSincePurchased = 0							=> le.LifeEvTimeLastAssetPurchase,
																								le.LifeEvTimeLastAssetPurchase = 0	=> monthsSincePurchased,
																																												 min(le.LifeEvTimeLastAssetPurchase,monthsSincePurchased)),
																						le.LifeEvTimeLastAssetPurchase);	
		self.ResCurrOwnershipIndex				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect,
																						map(isCurrAddr and rt.property_status_applicant = 'O' and rt.naprop = 4				=> 4,
																								isCurrAddr and rt.naprop = 3																							=> 3,
																								isCurrAddr and rt.occupant_owned																					=> 2,
																								isCurrAddr and rt.property_status_applicant <> 'O'												=> 1,
																																																													   0),
																						0);
		self.ResCurrMortgageType					:= map(~le.rec_type=ProfileBooster.Constants.recType.Prospect or ~isCurrAddr	=>	'-1', 
																						 rt.type_financing = 'ADJ'																							=>	'1',
																						 rt.type_financing = 'CNV'																							=>	'2',
																						 rt.type_financing <> ''																								=>	'0',
																																																													'-1');
		self.ResCurrMortgageAmount				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and isCurrAddr, rt.mortgage_amount, 0);
		self.ResInputOwnershipIndex				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect,
																						map(isInputAddr and rt.property_status_applicant = 'O' and rt.naprop = 4			=> 4,
																								isInputAddr and rt.naprop = 3																							=> 3,
																								isInputAddr and rt.occupant_owned																					=> 2,
																								isInputAddr and rt.property_status_applicant <> 'O'												=> 1,
																																																														 0),
																						0);
		self.ResInputMortgageType					:= map(~le.rec_type=ProfileBooster.Constants.recType.Prospect or ~isInputAddr	=>	'-1', 
																						 rt.type_financing = 'ADJ'																							=>	'1',
																						 rt.type_financing = 'CNV'																							=>	'2',
																						 rt.type_financing <> ''																								=>	'0',
																																																													'-1');
		self.ResInputMortgageAmount				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and isInputAddr, rt.mortgage_amount, 0);																	
		self.HHPropCurrOwnerMmbrCnt			 	:= if(le.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and rt.property_status_applicant = 'O', 1, 0);  
		self.HHPropCurrOwnedCnt					 	:= if(le.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household] and rt.property_status_applicant = 'O', 1, 0); 
		self.RaAPropCurrOwnerMmbrCnt			:= if(le.rec_type = ProfileBooster.Constants.recType.Relative and rt.property_status_applicant = 'O', 1, 0);
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
		
		self.curr_AssessedAmount					:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and isCurrAddr, rt.assessed_amount, 0);
		self.prev_AssessedAmount					:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect and isPrevAddr, rt.assessed_amount, 0);
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

	ProfileBooster.Layouts.Layout_PB_Shell rollProperty(sortedProperty le, sortedProperty ri) := TRANSFORM
		same_prop := le.owned_prim_range=ri.owned_prim_range and le.owned_prim_name=ri.owned_prim_name;
		same_sold_prop := le.sold_prim_range = ri.sold_prim_range AND le.sold_prim_name = ri.sold_prim_name;
		
		self.PropCurrOwner								:= max(le.PropCurrOwner, ri.PropCurrOwner);
		self.PropCurrOwnedCnt							:= le.PropCurrOwnedCnt + if(same_prop, 0, ri.PropCurrOwnedCnt);
		self.PropCurrOwnedAssessedTtl			:= le.PropCurrOwnedAssessedTtl + if(same_prop, 0, ri.PropCurrOwnedAssessedTtl);
		self.PropTimeLastSale							:= min(le.PropTimeLastSale, ri.PropTimeLastSale);
		self.PropEverOwnedCnt							:= le.PropEverOwnedCnt + if(same_prop, 0, ri.PropEverOwnedCnt);
		self.PropEverSoldCnt							:= le.PropEverSoldCnt + if(same_sold_prop, 0, ri.PropEverSoldCnt);
		self.PropSoldCnt12Mo							:= le.PropSoldCnt12Mo + if(same_sold_prop, 0, ri.PropSoldCnt12Mo);
		self.PropSoldRatio								:= le.propSoldRatio; //most recent was sorted first so always just keep the left
		self.PropPurchaseCnt12Mo					:= le.PropPurchaseCnt12Mo + if(same_prop, 0, ri.PropPurchaseCnt12Mo);
		self.LifeEvTimeFirstAssetPurchase	:= max(le.LifeEvTimeFirstAssetPurchase, ri.LifeEvTimeFirstAssetPurchase);
		self.LifeEvTimeLastAssetPurchase	:= map(ri.LifeEvTimeLastAssetPurchase = 0	=> le.LifeEvTimeLastAssetPurchase,
																						 le.LifeEvTimeLastAssetPurchase = 0	=> ri.LifeEvTimeLastAssetPurchase,
																																									 min(le.LifeEvTimeLastAssetPurchase, ri.LifeEvTimeLastAssetPurchase));
		self.ResCurrOwnershipIndex			 	:= max(le.ResCurrOwnershipIndex, ri.ResCurrOwnershipIndex);  
		self.ResCurrMortgageType					:= if(ri.ResCurrMortgageType <> '', ri.ResCurrMortgageType, le.ResCurrMortgageType);
		self.ResCurrMortgageAmount				:= max(le.ResCurrMortgageAmount, ri.ResCurrMortgageAmount);
		self.ResInputOwnershipIndex			 	:= max(le.ResInputOwnershipIndex, ri.ResInputOwnershipIndex);  
		self.ResInputMortgageType					:= if(ri.ResInputMortgageType <> '', ri.ResInputMortgageType, le.ResInputMortgageType);
		self.ResInputMortgageAmount				:= max(le.ResInputMortgageAmount, ri.ResInputMortgageAmount);
		self.curr_AssessedAmount					:= max(le.curr_AssessedAmount, ri.curr_AssessedAmount);
		self.prev_AssessedAmount					:= max(le.prev_AssessedAmount, ri.prev_AssessedAmount);
		self.HHPropCurrOwnerMmbrCnt			 	:= max(le.HHPropCurrOwnerMmbrCnt, ri.HHPropCurrOwnerMmbrCnt);  
		self.HHPropCurrOwnedCnt					 	:= le.HHPropCurrOwnedCnt + if(same_prop, 0, ri.HHPropCurrOwnedCnt); 
		self.RaAPropCurrOwnerMmbrCnt			:= max(le.RaAPropCurrOwnerMmbrCnt, ri.RaAPropCurrOwnerMmbrCnt);
		self								 							:= le;
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
												left.seq = right.seq and
												left.rec_type=ProfileBooster.Constants.recType.Prospect, //we sent only Prospect recs to AVM search so only need to update Prospects here
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.ResCurrAVMValue 					:= right.address_history_1.avm_automated_valuation;
																	self.ResCurrAVMValue12Mo 			:= right.address_history_1.avm_automated_valuation2;
																	self.ResCurrAVMRatioDiff12Mo := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_automated_valuation2 = 0, 
																																		 '0', 
																																		 trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_automated_valuation2, 99.0)));
																	self.ResCurrAVMValue60Mo 			:= right.address_history_1.avm_automated_valuation6;
																	self.ResCurrAVMRatioDiff60Mo := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_automated_valuation6 = 0, 
																																		 '0', 
																																		 trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_automated_valuation6, 99.0)));
																	self.ResCurrAVMCntyRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_fips_level = 0, 
																																  '0', 
																																	trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_fips_level, 99.0)));
																	self.ResCurrAVMTractRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_geo11_level = 0, 
																																	'0', 
																																	trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_geo11_level, 99.0)));
																	self.ResCurrAVMBlockRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_geo12_level = 0, 
																																	'0', 
																																	trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_geo12_level, 99.0)));
																	self.ResInputAVMValue 				:= right.Input_Address_Information.avm_automated_valuation;
																	self.ResInputAVMValue12Mo 		:= right.Input_Address_Information.avm_automated_valuation2;
																	self.ResInputAVMRatioDiff12Mo := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_automated_valuation2 = 0, 
																																			'0', 
																																			trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_automated_valuation2, 99.0)));
																	self.ResInputAVMValue60Mo 		:= right.Input_Address_Information.avm_automated_valuation6;
																	self.ResInputAVMRatioDiff60Mo := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_automated_valuation6 = 0, 
																																			'0', 
																																			trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_automated_valuation6, 99.0)));
																	self.ResInputAVMCntyRatio := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_median_fips_level = 0, 
																																	'0', 
																																	trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_median_fips_level, 99.0)));
																	self.ResInputAVMTractRatio := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_median_geo11_level = 0, 
																																	 '0', 
																																	 trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_median_geo11_level, 99.0)));
																	self.ResInputAVMBlockRatio := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_median_geo12_level = 0, 
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
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.PropCurrOwnedAVMTtl 			:= if(left.rec_type = ProfileBooster.Constants.recType.Prospect, right.Input_Address_Information.avm_automated_valuation, 0);
																	self.HHPropCurrAVMHighest 		:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.Input_Address_Information.avm_automated_valuation, 0);
																	self.RaAPropOwnerAVMHighest 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, right.Input_Address_Information.avm_automated_valuation, 0);
																	self.RaAPropOwnerAVMMed 			:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, right.Input_Address_Information.avm_automated_valuation, 0);
																	self := left), left outer, parallel);

	sortedAVMOwned :=  sort(withAVMOwned, seq, did2); 

	groupAVMOwned := group(sortedAVMOwned(RaAPropOwnerAVMMed<>0), seq);	

	ProfileBooster.Layouts.Layout_PB_Shell rollAVMOwned(sortedAVMOwned le, sortedAVMOwned ri) := TRANSFORM
		self.PropCurrOwnedAVMTtl					:= le.PropCurrOwnedAVMTtl + ri.PropCurrOwnedAVMTtl;
		self.HHPropCurrAVMHighest					:= max(le.HHPropCurrAVMHighest, ri.HHPropCurrAVMHighest);
		self.RaAPropOwnerAVMHighest				:= max(le.RaAPropOwnerAVMHighest, ri.RaAPropOwnerAVMHighest);
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
	BSappended := join(BSAVM, rolledAVMOwned(rec_type=ProfileBooster.Constants.recType.Prospect), //only need prospect (rec_type 1)
												left.seq = right.seq,
												transform(Risk_Indicators.Layout_Boca_Shell,
																	self.address_verification.addr_type2												:= right.curr_addr_type;
																	self.address_verification.address_history_1.assessed_amount	:= right.curr_assessedAmount;
																	self.address_verification.addr_type3												:= right.prev_addr_type;
																	self.address_verification.address_history_2.assessed_amount	:= right.prev_assessedAmount;
																	self.other_address_info.addrs_last_5years										:= if(right.LifeEvTimeLastMove > 60 and right.LifeEvTimeLastMove <> nines, 0, 1);
																	self.reported_dob																						:= (integer)right.dob;
																	self.addrpop2																								:= right.curr_prim_name <> '' and right.curr_z5 <> '';
																	self.addrpop3																								:= right.prev_prim_name <> '' and right.prev_z5 <> '';
																	self := left), left outer, parallel);

	econTraj := risk_indicators.getEconomicTrajectory(Group(BSappended, seq));		

	withEconTraj := join(rolledAVMOwned, econTraj,
												left.seq = right.seq and
												left.rec_type = ProfileBooster.Constants.recType.Prospect,  //update only the prospect record (not HH or relative)
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.LifeEvEconTrajectory 			:= (string)right.economic_trajectory;
																	self.LifeEvEconTrajectoryIndex 	:= (string)right.economic_trajectory_index;
																	self := left), left outer, parallel);
	
// At this point we have one record for the prospect, one for each household member and one for each relative - roll them up 
// here to sum all of the household and relatives attributes for the prospect record  
  ProfileBooster.Layouts.Layout_PB_Shell rollFinal(ProfileBooster.Layouts.Layout_PB_Shell le, ProfileBooster.Layouts.Layout_PB_Shell ri) := transform
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
		self.HHCollegeTierMmbrHighest				:= map(le.HHCollegeTierMmbrHighest = 0	=> ri.HHCollegeTierMmbrHighest,
																							 ri.HHCollegeTierMmbrHighest = 0	=> le.HHCollegeTierMmbrHighest,
																																									 min(le.HHCollegeTierMmbrHighest, ri.HHCollegeTierMmbrHighest)); 
		self.HHPropCurrOwnerMmbrCnt					:= le.HHPropCurrOwnerMmbrCnt + ri.HHPropCurrOwnerMmbrCnt;
		self.HHPropCurrOwnedCnt							:= le.HHPropCurrOwnedCnt + ri.HHPropCurrOwnedCnt;
		self.HHPropCurrAVMHighest						:= max(le.HHPropCurrAVMHighest, ri.HHPropCurrAVMHighest);
		self.HHPPCurrOwnedCnt								:= le.HHPPCurrOwnedCnt + ri.HHPPCurrOwnedCnt;
		self.HHPPCurrOwnedAutoCnt						:= le.HHPPCurrOwnedAutoCnt + ri.HHPPCurrOwnedAutoCnt;
		self.HHPPCurrOwnedMtrcycleCnt				:= le.HHPPCurrOwnedMtrcycleCnt + ri.HHPPCurrOwnedMtrcycleCnt;
		self.HHPPCurrOwnedAircrftCnt				:= le.HHPPCurrOwnedAircrftCnt + ri.HHPPCurrOwnedAircrftCnt;
		self.HHPPCurrOwnedWtrcrftCnt				:= le.HHPPCurrOwnedWtrcrftCnt + ri.HHPPCurrOwnedWtrcrftCnt;
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
		self.HHCrtRecLienJudgAmtTtl					:= le.HHCrtRecLienJudgAmtTtl + ri.HHCrtRecLienJudgAmtTtl;
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
	
	finalSort 	:= sort(withEconTraj, seq, rec_type, did2);  //sort prospect record to the top (rec_type = 1)
  finalRollup := rollup(finalSort, rollFinal(left,right), seq);

//append relatives' average income
	withRelaIncome := join(finalRollup, tRelaIncome,  
												left.seq = right.seq,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.RaAMedIncomeRange	:= right.RelaIncome;  
																	self := left), left outer);

//append count of households within relatives
	withRelaHHcnt := join(withRelaIncome, tRelaHHcnt,  
												left.seq = right.seq,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.RaAHHCnt	:= right.RelaHHcnt;  
																	self := left), left outer);

	tRelaAVMMed := table(groupAVMOwned(rec_type=ProfileBooster.Constants.recType.Relative and RAAPropOwnerAVMMed <> 0), {seq, RelaAVMMed := ave(group, RAAPropOwnerAVMMed)}, seq);

//append median AVM value for relatives
	withAVMMed := join(withRelaHHcnt, tRelaAVMMed,  
												left.seq = right.seq,
												transform(ProfileBooster.Layouts.Layout_PB_Shell,
																	self.RAAPropOwnerAVMMed	:= right.RelaAVMMed;  
																	self := left), left outer);
	
	ProfileBooster.Layouts.Layout_PB_BatchOut tfEmpty(PB_In le) := transform
		self.seq			:= le.seq;
		SELF.AcctNo		:= le.AcctNo;
		self 					:= [];
	end;

	emptyAttr := project(PB_In, tfEmpty(left)); 
			
// *******************************************************************************************************************
// Now that we have all necessary data in the PBShell, pass it to the attributes function to produce the attributes
// *******************************************************************************************************************
  attributes := if(StringLib.StringToUpperCase(AttributesVersion) in ProfileBooster.Constants.setValidAttributeVersions OR domodel, //if valid attributes version requested, go get attributes
									 ProfileBooster.getAttributes(withAVMMed, DataPermissionMask),
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



Final := PROJECT(with_mover_model, Blank_minors(left));                   
     
// output(p_address,,'~dvstemp::out::property_thor_testing_inputs::p_address_' + thorlib.wuid());
// output(ids_only,,'~dvstemp::out::property_thor_testing_inputs::ids_only_' + thorlib.wuid());
		
/* ********************
 *  Debugging Section *
 ********************* */
 
  // output(slimShell,,'~dvstemp::out::profilebooster::slimshell_' + thorlib.wuid());
	
	  //output(with_mover_model, named('with_mover_model'));
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
  // output(slimShell, named('slimShell'));
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
  // output(derogRecs, named('derogRecs'));
  // output(withDerogs, named('withDerogs'));
  // output(withProfLic, named('withProfLic'));
  // output(withBusnAssoc, named('withBusnAssoc'));
  // output(sportsRecs, named('sportsRecs'));
  // output(withSports, named('withSports'));
  // output(p_address, named('p_address'));
  // output(ids_only, named('ids_only'));
	 
	// output(p_address,, '~dvstemp::profile_booster_property_testcase::p_address::mathis_' + thorlib.wuid());
	// output(ids_only,, '~dvstemp::profile_booster_property_testcase::ids_only::mathis_' + thorlib.wuid());
	
  // output(prop_common, named('prop_common'));	
  // output(withProperty, named('withProperty'));
  // output(sortedProperty, named('sortedProperty'));
  // output(rolledProperty, named('rolledProperty'));
  // output(preAVM, named('preAVM'));
  // output(AVMrecs, named('AVMrecs'));
  // output(withAVM, named('withAVM'));
  // output(propOwners, named('propOwners'));
  // output(preAVMOwned, named('preAVMOwned'));
  // output(avm1Owned, named('avm1Owned'));
  // output(avms1Owned, named('avms1Owned'));
  // output(withAVMOwned, named('withAVMOwned'));
  // output(sortedAVMOwned, named('sortedAVMOwned'));
  // output(rolledAVMOwned, named('rolledAVMOwned'));
  // output(BSAVM, named('BSAVM'));
  // output(BSappended, named('BSappended'));
  // output(econTraj, named('econTraj'));
  // output(withEconTraj, named('withEconTraj'));
  // output(finalSort, named('finalSort'));
  // output(finalRollup, named('finalRollup'));
  // output(withRelaIncome, named('withRelaIncome'));
  // output(withRelaHHcnt, named('withRelaHHcnt'));
   //output(attributes, named('attributes'));
  // output(withIncome, named('withIncome'));
  // output(withHHIncome, named('withHHIncome'));
	 //output( withBankingExperiance, named('withBankingExperiance'));
/* ********************/

return Final;	


END;
