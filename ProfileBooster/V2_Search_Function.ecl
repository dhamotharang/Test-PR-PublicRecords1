import	 _Control, address, Address_Attributes, avm_v2, dma, doxie, Gateway, LN_PropertyV2_Services, mdr, ProfileBooster, 
				Riskwise, Risk_Indicators, Relationship, aid, std, dx_header, dx_ProfileBooster, Watchdog, ML;

onThor := _Control.Environment.OnThor;

EXPORT V2_Search_Function( DATASET(ProfileBooster.V2_Layouts.Layout_PB2_In) PB2_Input, 
													string50 DataRestrictionMask,
													string50 DataPermissionMask,
													string20 AttributesVersion, 
													boolean domodel=FALSE,
													string modelname = ''
													) := FUNCTION

	BOOLEAN DEBUG := FALSE;

	isFCRA			 := FALSE;
	GLBA				 := 0;
	DPPA				 := 0;
	BSOptions	 := Risk_Indicators.iid_constants.BSOptions.RetainInputDID;
	bsversion	 := 50;
	append_best := 0;	
	gateways		:= dataset([],Gateway.Layouts.Config);
	todaysdate	:= (STRING8)Std.Date.Today();
	nines				 := 9999999;

	mod_transforms := ProfileBooster.V2_Transforms;

	// MarketingWatchdogKey := Watchdog.Key_Watchdog_marketing_V2; // , 'AMBIG', 'C_MERGE' ADL type should be 'CORE' or 'No_SSN' to filter out deceased
	MarketingWatchdogKey := dataset('~thor_data400::BASE::Watchdog_Best_marketing',Watchdog.Layout_Best,thor);; // , 'AMBIG', 'C_MERGE' ADL type should be 'CORE' or 'No_SSN' to filter out deceased
	// MarketingWatchdogKeyDEAD := Watchdog.Key_Watchdog_marketing_V2;
	// ******************************************************************** 
	// Join to Marketing Watchdog Header to get Best Info if only LexID was input
	// ******************************************************************** 
	/*	EXPORT Layout_PB2_In	:= RECORD
		string30	AcctNo;
		unsigned4 seq;
		unsigned6	LexID;
		STRING70	Name_Full;
		STRING5		Name_Title;
		STRING20	Name_First;
		STRING20	Name_Middle;
		STRING20	Name_Last;
		STRING5		Name_Suffix;
		STRING9		ssn;
		STRING8		dob;
		STRING10	phone10;
		STRING120	street_addr;
		String10	streetnumber;
		String2		streetpredirection;
		String28	streetname;
		String4		streetsuffix;
		String2		streetpostdirection;
		String10	unitdesignation;
		String8		unitnumber;
		STRING25	City_name;
		STRING2		st;
		STRING5		z5;
		STRING25	country;
		STRING100	emailAddress;
		unsigned3	HistoryDate;
	END;
	*/
	/*	 ProfileBooster.V2_Layouts.Layout_PB2_In getLexIDBestInfo(PB2_Input l, MarketingWatchdogKey r) := TRANSFORM
			self.lexid		 := (integer)l.LexId;
			// self.score := if((integer)l.lexid<>0, 100, 0);	// hard code the DID score if DID is passed in on input
			self.seq		 := l.seq;
			self.HistoryDate	 := if(l.historydate=0, risk_indicators.iid_constants.default_history_date, l.HistoryDate);
			self.ssn		 := r.ssn;
			// dob_val		 := riskwise.cleandob(r.dob);
			// dob				 := dob_val;
			self.dob		 := (STRING)r.dob;
		
			fname				:= r.fname;
			mname				:= r.mname;
			lname				:= r.lname ;
			suffix			 := r.Name_Suffix ;
			self.Name_First	:= stringlib.stringtouppercase(fname);
			self.Name_Middle	:= stringlib.stringtouppercase(mname);
			self.Name_Last	:= stringlib.stringtouppercase(lname);
			self.Name_Suffix := stringlib.stringtouppercase(suffix);
			
			addr_value	 := trim(Address.Addr1FromComponents(r.prim_range,r.predir,r.prim_name,
														r.suffix,r.postdir,r.unit_desig,r.sec_range));
			clean_a2		 := Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, r.City_name, r.st, r.zip);
			self.street_addr:= addr_value;
			self.City_name				 := r.city_name;
			self.st				:= r.st;
			self.z5			:= r.zip;	
			self.streetnumber			:= r.prim_range;
			self.streetpredirection					:= r.predir;
			self.streetname			 := r.prim_name;
			self.streetsuffix		 := r.suffix;
			self.streetpostdirection				 := r.postdir;
			self.unitdesignation			:= r.unit_desig;
			self.unitnumber			 := r.sec_range;
			self.Phone10				 := StringLib.StringFilter(r.Phone, '0123456789');
			self.emailAddress		 := l.emailAddress;
				self := r;
				self := l;
			self := [];
			
			END;	
	*/
	// bestInfoLexID_thor := JOIN(DISTRIBUTE(PB2_Input(LexID>0),LexID),DISTRIBUTE(MarketingWatchdogKey,did),
										// LEFT.LexID = RIGHT.did
										// AND RIGHT.adl_ind IN ['CORE', 'NO_SSN'],
										// getLexIDBestInfo(LEFT,RIGHT), LEFT OUTER, LOCAL);
	// bestInfoLexID_roxie := JOIN(PB2_Input(LexID>0),MarketingWatchdogKey,
										// LEFT.LexID = RIGHT.did
										// AND RIGHT.adl_ind IN ['CORE', 'NO_SSN'],
										// getLexIDBestInfo(LEFT,RIGHT), LEFT OUTER);
	// #IF(onThor)
		// bestInfoLexID := bestInfoLexID_thor;
	// #ELSE
		// bestInfoLexID := bestInfoLexID_roxie;
	// #END

	// PB2_In := PB2_Input(LexID=0)+bestInfoLexID;
	PB2_In := PB2_Input;//SWITCH THIS BEFORE FINALIZING CODE
	// ********************************************************************
	// Transform PB input to Layout_Input so we can call iid_getDID_prepOutput
	// ********************************************************************

	iid_prep_roxie := PROJECT(PB2_In, mod_transforms.xfm_RI_Layout_Input(left));	

	// NEW::	Calling the AID address cache macro now that Tony added the new feature for us:	https://bugzilla.seisint.com/show_bug.cgi?id=194258

	aid_prepped	:=	project(PB2_In, mod_transforms.prep_for_AID(left));

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
		self.did				:= (integer)l.LexId;
		self.score				:= if((integer)l.lexid<>0, 100, 0);	// hard code the DID score if DID is passed in on input
		self.seq				:= l.seq;	 
			self.HistoryDate		:= if(l.historydate=0, risk_indicators.iid_constants.default_history_date, l.HistoryDate);

		self.ssn				:= l.ssn;
		dob_val				:= riskwise.cleandob(l.dob);
		dob					:= dob_val;
		self.dob				:= if((unsigned)dob=0, '', dob);

		fname					 := l.Name_First ;
		mname					 := l.Name_Middle;
		lname					 := l.Name_Last ;
		suffix					:= l.Name_Suffix ;
		self.fname				 := stringlib.stringtouppercase(fname);
		self.mname			 := stringlib.stringtouppercase(mname);
		self.lname			 := stringlib.stringtouppercase(lname);
		self.suffix			:= stringlib.stringtouppercase(suffix);
		self.Phone10		 := StringLib.StringFilter(l.Phone10, '0123456789');		
		
		addr_value				:= trim(l.street_addr);
		self.in_streetAddress:= addr_value;
		self.in_city			 := l.City_name;
		self.in_state			:= l.st;
		self.in_zipCode			:= l.z5;	
		
		SELF.prim_range			:= l.aidwork_acecache.prim_range;
		SELF.predir					:= l.aidwork_acecache.predir;
		SELF.prim_name			 := l.aidwork_acecache.prim_name;
		SELF.addr_suffix		 := l.aidwork_acecache.addr_suffix;
		self.postdir				 := l.aidwork_acecache.postdir;
		self.unit_desig			:= l.aidwork_acecache.unit_desig;
		self.sec_range			 := l.aidwork_acecache.sec_range;
		self.p_city_name		 := l.aidwork_acecache.p_city_name;
		self.st							:= l.aidwork_acecache.st;
		self.z5							:= l.aidwork_acecache.zip5;
		self.zip4						:= l.aidwork_acecache.zip4;
		self.lat						 := l.aidwork_acecache.geo_lat;
		self.long						:= l.aidwork_acecache.geo_long;
		self.addr_type			:= risk_indicators.iid_constants.override_addr_type(l.street_addr, l.aidwork_acecache.rec_type[1],l.aidwork_acecache.cart);
		self.addr_status		 := l.aidwork_acecache.err_stat;
		self.county					:= l.aidwork_acecache.county[3..5]; //bytes 1-2 are state code, 3-5 are county number
		self.geo_blk				 := l.aidwork_acecache.geo_blk;		
		
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


	with_DID_thor := JOIN(distribute(PB2_In, seq), distribute(highestDIDScore, seq), 
										LEFT.seq = RIGHT.seq, 
										mod_transforms.xfm_with_DID(LEFT,RIGHT), local);
	with_DID_roxie := JOIN(PB2_In, highestDIDScore, 
										LEFT.seq = RIGHT.seq, 
										mod_transforms.xfm_with_DID(LEFT,RIGHT));
	#IF(onThor)
		with_DID := with_DID_thor;
	#ELSE
		with_DID := with_DID_roxie;
	#END

	donotmail_key := dma.key_DNM_Name_Address;

	//join to DoNotMail to set the DNM attribute
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
		mod_transforms.setDNMFlag(left,right), left outer, keep(1), atmost(riskwise.max_atmost)
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
		mod_transforms.setDNMFlag(left,right), left outer, keep(1), local
	);

	#IF(onThor)
		withDoNotMail := withDoNotMail_thor;
	#ELSE
		withDoNotMail := withDoNotMail_roxie;
	#END

	// ********************************************************************
	// Get the Email Address
	// ********************************************************************
	withEmail_thor := join(distribute(withDoNotMail,seq), distribute(PB2_In,seq),
		LEFT.seq = RIGHT.seq,
		mod_transforms.xfm_setEmailAddress(left,right), left outer, keep(1), local
	);

	withEmail_roxie := join(withDoNotMail, PB2_In,
		LEFT.seq = RIGHT.seq,
		mod_transforms.xfm_setEmailAddress(left,right), left outer, keep(1)
	);

	#IF(onThor)
		withEmail := withEmail_thor;
	#ELSE
		withEmail := withEmail_roxie;
	#END

	// ********************************************************************
	// Get the Marketing Watchdog demographics
	// ********************************************************************
	withWatchdog_thor := join(distribute(withEmail,did), distribute(MarketingWatchdogKey(adl_ind IN ['CORE', 'NO_SSN']),did),
									LEFT.did = RIGHT.did,
									mod_transforms.setWatchdog(left,right), left outer, keep(1), local
	);
	withWatchdog_roxie := join(withEmail, MarketingWatchdogKey,
									LEFT.did = RIGHT.did
									AND RIGHT.adl_ind IN ['CORE', 'NO_SSN'],
									mod_transforms.setWatchdog(left,right), left outer, keep(1)
	);
	#IF(onThor)
	withWatchdog := withWatchdog_thor;
	#ELSE
	withWatchdog := withWatchdog_roxie;
	#END

	withWatchdogDEAD_thor := join(distribute(withWatchdog,did), distribute(MarketingWatchdogKey(adl_ind IN ['DEAD']),did),
				LEFT.did = RIGHT.did,
				mod_transforms.setWatchdogDEAD(left,right), left outer, keep(1)
	);
	withWatchdogDEAD_roxie := join(withWatchdog, MarketingWatchdogKey(adl_ind IN ['DEAD']),
									LEFT.did = RIGHT.did,
									mod_transforms.setWatchdogDEAD(left,right), left outer, keep(1)
	);
	#IF(onThor)
	withWatchdogDEAD := withWatchdogDEAD_thor;
	#ELSE
	withWatchdogDEAD := withWatchdogDEAD_roxie;
	#END

	// ********************************************************************
	// Get the InfutorNarc demographics
	// ********************************************************************
	infutorNARC := ProfileBooster.Key_Infutor_DID;		 

	withInfutorNARC_thor := join(distribute(withWatchdog,did), distribute(infutorNARC,did),
									LEFT.did = RIGHT.did,
									mod_transforms.setInfutorNARC(left,right), left outer, keep(1), local
	);
	withInfutorNARC_roxie := join(withWatchdog, infutorNARC,
									LEFT.did = RIGHT.did,
									mod_transforms.setInfutorNARC(left,right), left outer, keep(1)
	);
	#IF(onThor)
		withInfutorNARC := withInfutorNARC_thor;
	#ELSE
		withInfutorNARC := withInfutorNARC_roxie;
	#END

	// ********************************************************************
	// Get the Prebuilt Keys 
	// ********************************************************************
	PB20LexIDKey := dx_ProfileBooster.Key_Lexid(0);
	withLexIDKey_thor := join(distribute(withInfutorNARC,did), distribute(PB20LexIDKey,did),
									LEFT.did = RIGHT.did,
									mod_transforms.xfmAddLexIDKey(left,right), left outer, keep(1), local
	);
	withLexIDKey_roxie := join(withInfutorNARC, PB20LexIDKey,
									LEFT.did = RIGHT.did,
									mod_transforms.xfmAddLexIDKey(left,right), left outer, keep(1)
	);
	#IF(onThor)
		withLexIDKey := withLexIDKey_thor;
	#ELSE
		withLexIDKey := withLexIDKey_roxie;
	#END

	withVerification := ProfileBooster.V2_getVerification(withLexIDKey); //ProfileBooster.V2_Layouts.Layout_PB2_Shell

	//Address Key
	PB20AddressKey := dx_ProfileBooster.Key_Address(0);

	ProfileBooster.V2_Layouts.Layout_PB2_Shell xfmAddInputAddressData(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, PB20AddressKey ri ) := TRANSFORM
		fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		// SELF.InpAddrOwnershipIndx := ri.AddrOwnershipIndx;
		SELF.InpAddrHasPoolFlag := ri.AddrHasPoolFlag;
		SELF.InpAddrIsMobileHomeFlag := ri.AddrIsMobileHomeFlag;
		SELF.InpAddrBathCnt := ri.AddrBathCnt;
		SELF.InpAddrParkingCnt := ri.AddrParkingCnt;
		SELF.InpAddrBuildYr := ri.AddrBuildYr;
		SELF.InpAddrBedCnt := ri.AddrBedCnt;
		SELF.InpAddrBldgSize := ri.AddrBldgSize;
		SELF.InpAddrLat := ri.AddrLat;
		SELF.InpAddrLng := ri.AddrLng;
		SELF.InpAddrIsCollegeFlag := ri.AddrIsCollegeFlag;
		// SELF.InpAddrAVMVal := ri.AddrAVMVal;
		// SELF.InpAddrAVMValA1Y := ri.AddrAVMValA1Y;
		// SELF.InpAddrAVMRatio1Y := (STRING10)ri.AddrAVMRatio1Y;
		// SELF.InpAddrAVMValA5Y := ri.AddrAVMValA5Y;
		// SELF.InpAddrAVMRatio5Y := (STRING10)ri.AddrAVMRatio5Y;
		// SELF.InpAddrMedAVMCtyRatio := (STRING10)ri.AddrMedAVMCtyRatio;
		// SELF.InpAddrMedAVMCenTractRatio := (STRING10)ri.AddrMedAVMCenTractRatio;
		// SELF.InpAddrMedAVMCenBlockRatio := (STRING10)ri.AddrMedAVMCenBlockRatio;
		SELF.InpAddrType := ri.AddrType;
		SELF.InpAddrTypeIndex := ri.AddrTypeIndx;
		SELF.InpAddrBusRegCnt := ri.AddrBusRegCnt;
		SELF.InpAddrIsVacantFlag := ri.AddrIsVacantFlag;
		// SELF.InpAddrForeclosure := ri.AddrForeclosure;
		// SELF.InpAddrStatus := ri.AddrStatus;
		SELF.InpAddrIsAptFlag := ri.AddrIsAptFlag;
		self								 := le;	
		self								 := [];
	END;	

	withInputAddressKey_thor := join(distribute(withVerification,hash64(z5,prim_range,prim_name,addr_suffix,predir,postdir,sec_range)), 
																		distribute(PB20AddressKey,hash64(zip5	 ,primaryrange	 ,primaryname	 ,suffix					,predirectional,postdirectional,secondaryrange)),
									TRIM(risk_indicators.MOD_AddressClean.street_address('',TRIM(LEFT.prim_range), TRIM(LEFT.predir), TRIM(LEFT.prim_name,ALL), TRIM(LEFT.addr_suffix), 
																																			TRIM(LEFT.postdir),	TRIM(LEFT.unit_desig), TRIM(LEFT.sec_range)),ALL) =
									TRIM(risk_indicators.MOD_AddressClean.street_address('',TRIM(RIGHT.primaryrange), TRIM(RIGHT.predirectional), TRIM(RIGHT.primaryname,ALL), TRIM(RIGHT.suffix), 
																																			TRIM(RIGHT.postdirectional),	TRIM(RIGHT.unitdesignation), TRIM(RIGHT.secondaryrange)),ALL) AND																								 
									TRIM(LEFT.z5) = TRIM(RIGHT.zip5),// AND
									xfmAddInputAddressData(left,right), LEFT OUTER, keep(1), local
		);
	// withInputAddressKey_roxie := join(withVerification, 
																		// PB20AddressKey,
									// TRIM(risk_indicators.MOD_AddressClean.street_address('',TRIM(LEFT.prim_range), TRIM(LEFT.predir), TRIM(LEFT.prim_name,ALL), TRIM(LEFT.addr_suffix), 
																																			// TRIM(LEFT.postdir),	TRIM(LEFT.unit_desig), TRIM(LEFT.sec_range)),ALL) =
									// TRIM(risk_indicators.MOD_AddressClean.street_address('',TRIM(RIGHT.primaryrange), TRIM(RIGHT.predirectional), TRIM(RIGHT.primaryname,ALL), TRIM(RIGHT.suffix), 
																																			// TRIM(RIGHT.postdirectional),	TRIM(RIGHT.unitdesignation), TRIM(RIGHT.secondaryrange)),ALL) AND																								 
									// TRIM(LEFT.z5) = TRIM(RIGHT.zip5),// AND
									// xfmAddInputAddressData(left,right), LEFT OUTER, keep(1)
	// );
	// #IF(onThor)
		withInputAddressKey := withInputAddressKey_thor;
	// #ELSE
		// withInputAddressKey := withInputAddressKey_roxie;
	// #END


	//Search Death Master by DID. Set 2 dates (1 with SSA permission and 1 not) and choose appropriately 
	withDeceasedDID_roxie := join(withInputAddressKey, Doxie.key_Death_masterV2_ssa_DID,
									left.DID <> 0 and
									(UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate AND									
									keyed(left.DID = right.l_did),
									mod_transforms.getDeceasedDID(left, right), left outer, keep(200), ATMOST(RiskWise.max_atmost));

	withDeceasedDID_thor := join(distribute(withInputAddressKey, did), 
																distribute(pull(Doxie.key_Death_masterV2_ssa_DID), l_did),
									left.DID <> 0 and
									(UNSIGNED)(RIGHT.dod8[1..6]) < LEFT.historydate AND									
									left.DID = right.l_did,
									mod_transforms.getDeceasedDID(left, right), left outer, keep(200), local);

	#IF(onThor)
		withDeceasedDID := withDeceasedDID_thor;
	#ELSE
		withDeceasedDID := withDeceasedDID_roxie;
	#END

	sortedDeceased := sort(withDeceasedDID, seq);

	// rollup by Deceased matches and keep whichever record has a DOD
	rolledDeceased := rollup(sortedDeceased, mod_transforms.rollDeceased(left,right), seq);

		/* GET ALL DIDS */
	//get household members (DIDs) by doing inner join of the HHID to the HHID_Did key
	index_hhid_did := dx_header.key_hhid_did();
	ProfileBooster.V2_Layouts.Layout_PB2_Shell add_household_members(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, index_hhid_did rt) := transform
			self.DID2			:= rt.DID;
			self.rec_type	:= ProfileBooster.Constants.recType.Household; //set rec_type as household member
			self := le;
	END;
	hhDIDs_roxie := join(rolledDeceased, index_hhid_did,
												keyed(left.HHID = right.hhid_relat) and
												keyed(right.ver = 1) and			 //ver of 1 = current household members
												left.DID <> right.DID,	//exclude the prospect's DID - we already have it as the prospect record
												add_household_members(left, right),
												atmost(RiskWise.max_atmost),keep(300));		

	hhDIDs_thor_hits := join(distribute(rolledDeceased(hhid<>0), hhid),
											distribute(pull(index_hhid_did), hhid_relat),
												left.HHID = right.hhid_relat and
												right.ver = 1 and			 //ver of 1 = current household members
												left.DID <> right.DID,	//exclude the prospect's DID - we already have it as the prospect record
												add_household_members(left, right),
												keep(300), local);		
	hhDIDs_thor := hhDIDs_thor_hits + withEmail(hhid=0);	// add back the records with no hhid										

	#IF(onThor)
		hhDIDs := hhDIDs_thor;
	#ELSE
		hhDIDs := hhDIDs_roxie;
	#END

	//get relatives (DIDs) by doing inner join 
	withEmail_dedp := dedup(sort(rolledDeceased,did), did);
	RelativeMax := 300;
	withEmail_dids := PROJECT(rolledDeceased, mod_transforms.xfm_getEmailDIDs(LEFT));

	rellyids := Relationship.proc_GetRelationshipNeutral(withEmail_dids,TopNCount:=RelativeMax,
		RelativeFlag:=TRUE,AssociateFlag:=TRUE,doAtmost:=TRUE,MaxCount:=RelativeMax, doThor := onThor).result; 

	relativeDIDs_roxie := join(rolledDeceased, rellyids,
												left.did = right.did1,
												mod_transforms.xfm_getRelativeDIDs(left, right));		
	relativeDIDs_thor := join(distribute(rolledDeceased, did), 
														distribute(rellyids, did1),
												left.did = right.did1,
												mod_transforms.xfm_getRelativeDIDs(left, right), 
														local);
	#IF(onThor)
		relativeDIDs := relativeDIDs_thor;
	#ELSE
		relativeDIDs := relativeDIDs_roxie;
	#END

	//merge Prospect rec, Household recs, Relatives recs into one file
	allDIDs := rolledDeceased + hhDIDs + relativeDIDs;

	//if a DID is both a household member and a relative, keep only the household record so relatives attributes are exclusive
	unique_DIDs_roxie := dedup(sort(allDIDs, seq, DID2, rec_type), seq, DID2);

	distributed_allDIDs := distribute(allDIDs, hash(seq, did2));
	unique_DIDs_thor := dedup(sort(distributed_allDIDs, seq, DID2, rec_type, local), seq, DID2, local);//	 : PERSIST('~PROFILEBOOSTER::unique_DIDs_thor');	// remove persists because low on disk space and it's rebuilding persist file each time anyway

	#IF(onThor)
		uniqueDIDs := unique_DIDs_thor;
	#ELSE
		uniqueDIDs := unique_DIDs_roxie;
	#END
		
	ProfileBooster.V2_Layouts.Layout_PB2_Shell xfmAddCurrentAddressData(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, PB20AddressKey ri ) := TRANSFORM
		fullhistorydate := risk_indicators.iid_constants.myGetDate(le.historydate);
		// SELF.CurrAddrOwnershipIndx := ri.AddrOwnershipIndx;
		SELF.CurrAddrHasPoolFlag := ri.AddrHasPoolFlag;
		SELF.CurrAddrIsMobileHomeFlag := ri.AddrIsMobileHomeFlag;
		SELF.CurrAddrBathCnt := ri.AddrBathCnt;
		SELF.CurrAddrParkingCnt := ri.AddrParkingCnt;
		SELF.CurrAddrBuildYr := ri.AddrBuildYr;
		SELF.CurrAddrBedCnt := ri.AddrBedCnt;
		SELF.CurrAddrBldgSize := ri.AddrBldgSize;
		SELF.CurrAddrLat := ri.AddrLat;
		SELF.CurrAddrLng := ri.AddrLng;
		SELF.CurrAddrIsCollegeFlag := ri.AddrIsCollegeFlag;
		// SELF.CurrAddrAVMVal := ri.AddrAVMVal;
		// SELF.CurrAddrAVMValA1Y := ri.AddrAVMValA1Y;
		// SELF.CurrAddrAVMRatio1Y := (STRING10)ri.AddrAVMRatio1Y;
		// SELF.CurrAddrAVMValA5Y := ri.AddrAVMValA5Y;
		// SELF.CurrAddrAVMRatio5Y := (STRING10)ri.AddrAVMRatio5Y;
		// SELF.CurrAddrMedAVMCtyRatio := (STRING10)ri.AddrMedAVMCtyRatio;
		// SELF.CurrAddrMedAVMCenTractRatio := (STRING10)ri.AddrMedAVMCenTractRatio;
		// SELF.CurrAddrMedAVMCenBlockRatio := (STRING10)ri.AddrMedAVMCenBlockRatio;
		// SELF.CurrAddrType := ri.AddrType; //CALCULATED IN GETVERIFICATION
		// SELF.CurrAddrTypeIndx := ri.AddrTypeIndx; //CALCULATED IN GETVERIFICATION
		SELF.CurrAddrBusRegCnt := ri.AddrBusRegCnt;
		SELF.CurrAddrIsVacantFlag := ri.AddrIsVacantFlag;
		SELF.CurrAddrStatus := ri.AddrStatus;
		SELF.CurrAddrIsAptFlag := ri.AddrIsAptFlag;
		self								 := le;	
		self								 := [];
	END;

	// withCurrAddressKey_thor := join(distribute(withLexIDKey,curr_addr_rawaid), distribute(PB20AddressKey,rawaid),
	withCurrAddressKey_thor := join(distribute(uniqueDIDs,hash64(curr_z5,curr_prim_range,curr_prim_name,curr_addr_suffix,curr_predir,	 curr_postdir,curr_sec_range)), 
																	distribute(PB20AddressKey,hash64(zip5	 ,primaryrange	 ,primaryname	 ,suffix					,predirectional,postdirectional,secondaryrange)),
									TRIM(risk_indicators.MOD_AddressClean.street_address('',TRIM(LEFT.curr_prim_range), TRIM(LEFT.curr_predir), TRIM(LEFT.curr_prim_name, ALL), TRIM(LEFT.curr_addr_suffix), 
																																			TRIM(LEFT.curr_postdir),	TRIM(LEFT.curr_unit_desig), TRIM(LEFT.curr_sec_range)),ALL) =
									TRIM(risk_indicators.MOD_AddressClean.street_address('',TRIM(RIGHT.primaryrange), TRIM(RIGHT.predirectional), TRIM(RIGHT.primaryname, ALL), TRIM(RIGHT.suffix), 
																																			TRIM(RIGHT.postdirectional),	TRIM(RIGHT.unitdesignation), TRIM(RIGHT.secondaryrange)),ALL) AND																								 
									TRIM(LEFT.curr_z5) = TRIM(RIGHT.zip5),// AND
									xfmAddCurrentAddressData(left,right), LEFT OUTER, keep(1), local
	);

	// withCurrAddressKey_roxie := join(uniqueDIDs, PB20AddressKey,
									// TRIM(risk_indicators.MOD_AddressClean.street_address('',TRIM(LEFT.curr_prim_range), TRIM(LEFT.curr_predir), TRIM(LEFT.curr_prim_name, ALL), TRIM(LEFT.curr_addr_suffix), 
																																			// TRIM(LEFT.curr_postdir),	TRIM(LEFT.curr_unit_desig), TRIM(LEFT.curr_sec_range)),ALL) =
									// TRIM(risk_indicators.MOD_AddressClean.street_address('',TRIM(RIGHT.primaryrange), TRIM(RIGHT.predirectional), TRIM(RIGHT.primaryname, ALL), TRIM(RIGHT.suffix), 
																																			// TRIM(RIGHT.postdirectional),	TRIM(RIGHT.unitdesignation), TRIM(RIGHT.secondaryrange)),ALL) AND																								 
									// TRIM(LEFT.curr_z5) = TRIM(RIGHT.zip5),// AND
									// xfmAddCurrentAddressData(left,right), LEFT OUTER, keep(1)
	// );
	// #IF(onThor)
		withCurrAddressKey := withCurrAddressKey_thor;
	// #ELSE
		// withCurrAddressKey := withCurrAddressKey_roxie;
	// #END

	//slim down the uniqueDIDs records to create a smaller layout to pass into all of the following searches
	slimShell := project(withCurrAddressKey,transform(ProfileBooster.V2_Layouts.Layout_PB2_Slim,self:= left));
	slimShell2 := project(withCurrAddressKey,transform(ProfileBooster.V2_Layouts.Layout_PB2_Slim_emergence,self:= left));

	EmrgAddress := ProfileBooster.V2_getEmrgAddress(slimShell2);

	ProfileBooster.V2_Layouts.Layout_PB2_Shell xfmAddEmergence(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, EmrgAddress ri ) := TRANSFORM
	 	SELF.EmrgLexIDsAtEmrgAddrCnt1Y := ri.EmrgLexIDsAtEmrgAddrCnt1Y;
		SELF.EmrgAddrType			   := ri.EmrgAddrType;
    	self 						   := le;  
		self 						   := [];
	END;  
	// output(withCurrAddressKey,, '~jfrancis::profile_booster20::withCurrAddressKey', OVERWRITE);
	// output(EmrgAddress,, '~jfrancis::profile_booster20::EmrgAddress', OVERWRITE);

	withEmergence_roxie := JOIN(withCurrAddressKey, EmrgAddress,
							LEFT.emrgprimaryrange=RIGHT.emrgprimaryrange AND	 
													LEFT.emrgpredirectional=RIGHT.emrgpredirectional AND
													LEFT.emrgprimaryname=RIGHT.emrgprimaryname AND
													RIGHT.emrgprimaryname<>'' AND
													LEFT.emrgsuffix=RIGHT.emrgsuffix AND
													LEFT.emrgpostdirectional=RIGHT.emrgpostdirectional AND
													LEFT.emrgunitdesignation=RIGHT.emrgunitdesignation AND
													LEFT.emrgsecondaryrange=RIGHT.emrgsecondaryrange AND
													LEFT.emrgzip5=RIGHT.emrgzip5 AND
							RIGHT.emrgzip5<>'',
							xfmAddEmergence(left,right), LEFT OUTER, keep(1));
	withEmergence_thor := JOIN(DISTRIBUTE(withCurrAddressKey,HASH64(emrgzip5,emrgprimaryrange,emrgpredirectional,emrgprimaryname,emrgsuffix,emrgpostdirectional,emrgunitdesignation,emrgsecondaryrange)), 
									DISTRIBUTE(EmrgAddress,HASH64(emrgzip5,emrgprimaryrange,emrgpredirectional,emrgprimaryname,emrgsuffix,emrgpostdirectional,emrgunitdesignation,emrgsecondaryrange)),
							LEFT.emrgprimaryrange=RIGHT.emrgprimaryrange AND	 
													LEFT.emrgpredirectional=RIGHT.emrgpredirectional AND
													LEFT.emrgprimaryname=RIGHT.emrgprimaryname AND
													RIGHT.emrgprimaryname<>'' AND
													LEFT.emrgsuffix=RIGHT.emrgsuffix AND
													LEFT.emrgpostdirectional=RIGHT.emrgpostdirectional AND
													LEFT.emrgunitdesignation=RIGHT.emrgunitdesignation AND
													LEFT.emrgsecondaryrange=RIGHT.emrgsecondaryrange AND
													LEFT.emrgzip5=RIGHT.emrgzip5 AND
							RIGHT.emrgzip5<>'',
							xfmAddEmergence(left,right), LEFT OUTER, keep(1), local);
	#IF(onThor)
		withEmergence := withEmergence_thor;
	#ELSE
		withEmergence := withEmergence_roxie;
	#END


	PropertyCommon := ProfileBooster.V2_getProperty(uniqueDIDs,slimShell,DataRestrictionMask,DataPermissionMask);

	//JOIN withPropertyCommon to uniqueDIDs? look at propcommon output
	withPropertyCommon := join(distribute(withEmergence,did2), 
															distribute(PropertyCommon,did2),
															LEFT.did2 = right.did2
															AND LEFT.did = right.did,
															mod_transforms.xfm_addPropertyCommon(LEFT, RIGHT), 
															left outer, keep(1), LOCAL);
															

	// finalSort	 := sort(withPropertyCommon, seq, rec_type, did2);
		// finalRollup := rollup(finalSort, rollFinal(left,right), seq);	

		
	/*	 //append relatives' average income
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
	*/

	emptyAttr := project(PB2_In, mod_transforms.xfm_tfEmpty(left)); 

				// adds back values for the household recs
	uniqueDIDs_WithPBLexIDKey_Thor := JOIN(DISTRIBUTE(withPropertyCommon,did2), DISTRIBUTE(PB20LexIDKey,did),
									LEFT.did2 = RIGHT.did,
									mod_transforms.xfmAddHouseholdInfo(LEFT,RIGHT), LEFT OUTER, KEEP(1), LOCAL);

	uniqueDIDs_WithPBLexIDKey_Roxie := JOIN(withPropertyCommon, PB20LexIDKey,
									LEFT.did2 = RIGHT.did,
									mod_transforms.xfmAddHouseholdInfo(LEFT,RIGHT), LEFT OUTER, KEEP(1));

	#IF(onThor)
			uniqueDIDs_WithPBLexIDKey := uniqueDIDs_WithPBLexIDKey_Thor;
	#ELSE
			uniqueDIDs_WithPBLexIDKey := uniqueDIDs_WithPBLexIDKey_Roxie;
	#END
    
    bestAddrInfo := PROJECT(uniqueDIDs_WithPBLexIDKey, ProfileBooster.V2_Transforms.getAddressInfo(LEFT));

	// *******************************************************************************************************************
	// Now that we have all necessary data in the PB2Shell, pass it to the attributes function to produce the attributes
	// *******************************************************************************************************************
	attributes := if(std.Str.ToUpperCase(AttributesVersion) in ProfileBooster.Constants.setValidAttributeVersionsV2 OR domodel, //if valid attributes version requested, go get attributes
										ProfileBooster.V2_getAttributes(bestAddrInfo, DataPermissionMask),
										emptyAttr);	
										
    bestAddrInfoSecRanges := SORT(attributes(curr_sec_range <> ''), seq, curr_sec_range);
    
    dedupBestAddrInfoSecRanges := DEDUP(bestAddrInfoSecRanges, seq, curr_sec_range);
    
    projectDedupBestAddrInfoSecRanges := PROJECT(dedupBestAddrInfoSecRanges, TRANSFORM(ProfileBooster.V2_Layouts.tempAttributesLayout,
    SELF.attributes.version2.HHUnitsInComplexCnt := IF(LEFT.attributes.version2.HHComplexTotalCnt = -99997, -99997, 1);
    SELF := LEFT;
    SELF := [];));
    	
	joinBestAddrInfoSecRangesToFinalSort := JOIN(attributes, projectDedupBestAddrInfoSecRanges, 
    LEFT.LexID = RIGHT.LexID AND LEFT.DID2 = RIGHT.DID2,
    TRANSFORM(ProfileBooster.V2_Layouts.tempAttributesLayout,
    SELF.attributes.version2.HHUnitsInComplexCnt := RIGHT.attributes.version2.HHUnitsInComplexCnt;
    SELF := LEFT;
  ), LEFT OUTER);
  
  	finalSort	 := sort(joinBestAddrInfoSecRangesToFinalSort, seq, rec_type, did2);	//sort prospect record to the top (rec_type = 1)

	flattenFinalSort := PROJECT(finalSort, TRANSFORM(ProfileBooster.V2_Layouts.Layout_ProfileBoosterV2_WithAdditionalFields, 
		SELF := LEFT.attributes.version2;
		SELF := LEFT;
		SELF := []));
		
	hhRecs := flattenFinalSort(rec_type = 1 OR rec_type = 2);
		
	projectUnscorables := ProfileBooster.V2_Functions.projectUnscorables(hhRecs, ProfileBooster.V2_Constants.setAttributesForUnscorableRollup, ProfileBooster.V2_Layouts.Layout_ProfileBoosterV2_WithAdditionalFields);
	
    rollupUnscorables := ProfileBooster.V2_Functions.rollupUnscorables(projectUnscorables, ProfileBooster.V2_Constants.setAttributesForUnscorableRollup, ProfileBooster.V2_Layouts.Layout_ProfileBoosterV2_WithAdditionalFields);

	ML.ToField(projectUnscorables,o, seq, 'HHMmbrAgeMed_Count');
  
    addMedianAttributes := PROJECT(o, TRANSFORM({UNSIGNED Seq, INTEGER Number, REAL Median},
    SELF.seq := LEFT.id;
    SELF.Number := LEFT.Number;
    SELF.Median := ML.FieldAggregates(o(id = LEFT.id)).Medians[LEFT.Number].median));

    sortMedianAttributes := SORT(addMedianAttributes, Seq, Number);
    
    dedupMedianAttributes := DEDUP(sortMedianAttributes, Seq, Number);
    
    joinMedianAttributes := JOIN(dedupMedianAttributes, rollupUnscorables, LEFT.Seq = RIGHT.Seq, TRANSFORM(ProfileBooster.V2_Layouts.Layout_ProfileBoosterV2_WithAdditionalFields,
    SELF.HHMmbrAgeMed_Count := (INTEGER)LEFT.Median;
    SELF := RIGHT;
    ));

	finalProject := PROJECT(rollupUnscorables, ProfileBooster.V2_Transforms.xfm_addHouseholdAndRelativeAttrs(LEFT));
																						
	withIncome := ProfileBooster.V2_estimatedIncome(finalProject);

	// withHHIncome := ProfileBooster.V2_HHestimatedIncome(withIncome); //for production

	// withBankingExperiance := ProfileBooster.V2_getBankingExperiance (withHHIncome);
	// #IF(DEBUG)
	////Model that is being tested goes here
	////with_mover_model := profilebooster.V2_PB1708_1_0(withBankingExperiance);
	// with_mover_model := profilebooster.V2_PB1708_1_0(withBankingExperiance);

	// #ELSE
	// with_mover_model := if(domodel,
												// CASE(modelname,
												////'PB1708_1' => profilebooster.V2_PB1708_1_0(withBankingExperiance, iid_prep),
												// 'PB1708_1' => profilebooster.V2_PB1708_1_0(withBankingExperiance),
												// 'PBM1803_0' => profilebooster.V2_PBM1803_0_1_score(withBankingExperiance, iid_prep),
												
																			// DATASET([],ProfileBooster.V2_Layouts.Layout_PB_BatchOut)),
												// withBankingExperiance);
		// #END												
		with_mover_model := withIncome;	

	//Blank out the fields calculated outside of V2_getAttributes for any minors
	ProfileBooster.V2_Layouts.Layout_PB2_BatchOut Blank_minors(ProfileBooster.V2_Layouts.Layout_PB2_BatchOut le) := TRANSFORM
		isMinor := le.attributes.version2.DemAge = '0'; //is zero if is a minor
		self.attributes.version2.DemEstInc := if(isMinor, '-99999', le.attributes.version2.DemEstInc);
		self.attributes.version2.DemBankingIndx := if(isMinor, '-99999', le.attributes.version2.DemBankingIndx);
		self.attributes.version2.HHEstimatedIncomeRange := if(isMinor, -99999, le.attributes.version2.HHEstimatedIncomeRange);
		self := le;
	END;

	BlankMinors := PROJECT(with_mover_model, Blank_minors(left));									 

	Xfm1Result := PROJECT(BlankMinors, mod_transforms.xfm_PB20_mod1(LEFT));	
	Xfm2Result := PROJECT(Xfm1Result, mod_transforms.xfm_PB20_mod2(LEFT));	
	Xfm3Result := PROJECT(Xfm2Result, mod_transforms.xfm_PB20_mod3(LEFT));	
	Xfm4Result := PROJECT(Xfm3Result, mod_transforms.xfm_PB20_mod4(LEFT));
	//Apply defaults for missing LexIDs
	PB20 := Xfm4Result(lexid<>0);
	PB20Corrected := PROJECT(Xfm4Result(lexid=0),mod_transforms.xfm_PB20_mod5(LEFT));

	finalResult := PB20+PB20Corrected;

	Final := PROJECT(finalResult, mod_transforms.xfm_Final(LEFT));

	// output(p_address,,'~dvstemp::out::property_thor_testing_inputs::p_address_' + thorlib.wuid());
	// output(ids_only,,'~dvstemp::out::property_thor_testing_inputs::ids_only_' + thorlib.wuid());
			
	/* ********************
		*	Debugging Section *
		********************* */

	// output(slimShell,,'~dvstemp::out::profilebooster::slimshell_' + thorlib.wuid());
	// output(choosen(bestInfoLexID,100), named('bestInfoLexID'));
	// output(choosen(PB2_In,100), named('PB2_In'));
	// output(choosen(did_prepped_output,100), named('did_prepped_output'));
	// output(choosen(highestDIDScore,100), named('highestDIDScore'));
	// output(with_mover_model, named('with_mover_model'));
	// output(iid_prep, named('iid_prep'));
	// output(with_DID, named('with_DID'));
	// output(withDoNotMail, named('withDoNotMail'));
	// output(withDeceasedDID, named('withDeceasedDID'));
	// output(choosen(rolledDeceased,100), named('rolledDeceased'));
	// output(count(rolledDeceased), named('rolledDeceasedCnt'));
	// output(choosen(PropertyCommon,100), named('PropertyCommon'));
	// output(count(PropertyCommon), named('PropertyCommonCnt'));
	// output(choosen(withPropertyCommon,100), named('withPropertyCommon'));
	// output(count(withPropertyCommon), named('withPropertyCommonCnt'));
	// output(withInfutor, named('withInfutor'));
	// output(withInputBus, named('withInputBus'));
	// output(withCurrBus, named('withCurrBus'));
	// output(CHOOSEN(hhDIDs,100), named('hhDIDs'));
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
	// output(allDids_WithPBLexIDKey, named('allDids_WithPBLexIDKey'));
	// output(withRelaIncome, named('withRelaIncome'));
	// output(withRelaHHcnt, named('withRelaHHcnt'));
  // output(uniqueDIDs(did=1648786953),named('uniqueDIDs1648786953'));
  // output(attributes(lexid=1648786953),named('attributes1648786953'));
  // output(projectFinalSort(LexID=1648786953),named('projectFinalSort1648786953'));
  // output(finalSort(LexID=1648786953),named('finalSort1648786953'));
  // output(hhRecs(LexID=1648786953),named('hhRecs1648786953'));
  // output(rollupUnscorables(LexID=1648786953),named('rollupUnscorables1648786953'));
  // output(finalProject(LexID=1648786953),named('finalProject1648786953'));

	// output(choosen(attributes(attributes.version2.HHMmbrDrgNewMsnc7Y>0),100), named('attributesHHMmbrDrgNewMsnc7Y'));
	// output(count(attributes(attributes.version2.HHMmbrDrgNewMsnc7Y>0)),named('attributesHHMmbrDrgNewMsnc7Ycnt'));
	// output(choosen(projectFinalSort(HHMmbrDrgNewMsnc7Y>0),100), named('projectFinalSort'));
	// output(count(projectFinalSort(HHMmbrDrgNewMsnc7Y>0)),named('projectFinalSortHHMmbrDrgNewMsnc7Ycnt'));
	// output(choosen(finalSort(attributes.version2.HHMmbrDrgNewMsnc7Y>0),100), named('finalSort'));
	// output(count(finalSort(attributes.version2.HHMmbrDrgNewMsnc7Y>0)),named('finalSortHHMmbrDrgNewMsnc7Ycnt'));
	// output(choosen(hhRecs(HHMmbrDrgNewMsnc7Y>0),100), named('hhRecs'));
	// output(count(hhRecs(HHMmbrDrgNewMsnc7Y>0)),named('hhRecsHHMmbrDrgNewMsnc7Ycnt'));
	// output(choosen(rollupUnscorables(HHMmbrDrgNewMsnc7Y>0),100), named('rollupUnscorables'));
	// output(count(rollupUnscorables(HHMmbrDrgNewMsnc7Y>0)),named('rollupUnscorablesHHMmbrDrgNewMsnc7Ycnt'));
	// output(choosen(finalProject(attributes.version2.HHMmbrDrgNewMsnc7Y>0),100), named('finalProject'));
	// output(count(finalProject(attributes.version2.HHMmbrDrgNewMsnc7Y>0)),named('finalProjectHHMmbrDrgNewMsnc7Ycnt'));
	// output(choosen(withIncome(attributes.version2.HHMmbrDrgNewMsnc7Y>0),100), named('withIncome'));
	// output(withIncome, named('withIncome'));
	// output(withHHIncome, named('withHHIncome'));
	// output(withBankingExperiance, named('withBankingExperiance'));
	// output(choosen(withEmail, 100), named('V2SF_withEmail'));
	// output(choosen(PB20LexIDKey, 100), named('V2SF_PB20LexIDKey'));
	// output(choosen(withLexIDKey, 100), named('V2SF_withLexIDKey'));
	// output(count(withLexIDKey), named('V2SF_withLexIDKey_Cnt'));
	// output(count(withLexIDKey(dt_first_seen<>0)), named('V2SF_withLexIDKey_Cnt_DFSeen'));
	// output(count(withLexIDKey(dt_last_seen<>201901)), named('V2SF_withLexIDKey_Cnt_DLSeen'));
	// output(choosen(withVerification, 100), named('V2SF_withVerification'));
	// output(withLexIDKey,,'~jfrancis::out::PB20_withLexIDKey_ROXIE',CSV(HEADING(single), QUOTE('"')),OVERWRITE);
	// output(count(withLexIDKey), named('V2SF_withLexIDKey_Cnt'));
	// output(count(withLexIDKey(EmrgSrc='')), named('V2SF_withLexIDKey_Src_Cnt'));
	// output(count(withLexIDKey(EmrgDt_First_seen=0)), named('V2SF_withLexIDKey_DFS_Cnt'));
	// output(count(withLexIDKey(EmrgDob IN ['','0'])), named('V2SF_withLexIDKey_EmrgDob_Cnt'));
//   output(choosen(withVerification, 100), named('V2SF_withVerification'));
  // output(withLexIDKey,,'~jfrancis::out::PB20_withLexIDKey_ROXIE',CSV(HEADING(single), QUOTE('"')),OVERWRITE);
  // output(count(withLexIDKey), named('V2SF_withLexIDKey_Cnt'));
  // output(count(withLexIDKey(EmrgSrc='')), named('V2SF_withLexIDKey_Src_Cnt'));
  // output(count(withLexIDKey(EmrgDt_First_seen=0)), named('V2SF_withLexIDKey_DFS_Cnt'));
  // output(count(withLexIDKey(EmrgDob IN ['','0'])), named('V2SF_withLexIDKey_EmrgDob_Cnt'));

	// output(finalRollup,,'~jfrancis::out::PB20_finalRollup_ROXIE',CSV(HEADING(single), QUOTE('"')),OVERWRITE);
	// output(choosen(withWatchdog, 100), named('V2SF_withWatchdog'));
	// output(choosen(withInfutorNARC, 100), named('V2SF_withInfutorNARC'));
	// output(choosen(withCurrAddressKey, 100), named('V2SF_withCurrAddressKey'));
	// output(choosen(withEmergence, 100), named('V2SF_withEmergence'));	
	// output(count(withCurrAddressKey), named('V2SF_withCurrAddressKey_Cnt'));
	// output(count(withCurrAddressKey(CurrAddrLat<>'')), named('V2SF_withCurrAddressKeyADDRLAT_Cnt'));
	// output(choosen(withInputAddressKey, 100), named('V2SF_withInputAddressKey'));
	// output(count(withInputAddressKey), named('V2SF_withInputAddressKey_Cnt'));
	// output(count(withInputAddressKey(InpAddrLat<>'')), named('V2SF_withInputAddressKeyADDRLAT_Cnt'));
	// output(choosen(BlankMinors, 100), named('V2SF_BlankMinors'));
	// output(count(attributes), named('V2SF_attributesCnt'));
	// output(choosen(Final, 100), named('V2SF_Final'));
	// testdids := [1653020855,2688684342,1765560556,2304428264,781043815];
	// output(withCurrAddressKey(did in testdids),named('withCurrAddressKeySample'));
	// output(PropertyCommon(did2 in testdids),named('PropertyCommonSample'));
	// output(withPropertyCommon(did in testdids),named('withPropertyCommonSample'));

	/* ********************/

	return Final;	

END;
