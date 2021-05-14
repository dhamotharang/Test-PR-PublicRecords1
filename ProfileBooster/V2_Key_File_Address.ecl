import ProfileBooster, Doxie, MDR, dx_header, Risk_Indicators, address, AID, Gateway, STD, dma, 
       Address_Attributes, Riskwise, avm_v2, dx_ProfileBooster, LN_PropertyV2, LN_PropertyV2_Services, Advo, AID_Build;

export V2_Key_File_Address(UNSIGNED3 history_date) := function
  	DataRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction;
  	DataPermissionMask  := Risk_Indicators.iid_constants.default_DataPermission;
 	isFCRA 			    := false;
	GLBA 				:= 0;
	DPPA 				:= 0;
	BSOptions           := Risk_Indicators.iid_constants.BSOptions.RetainInputDID;
	bsversion           := 50;
	append_best         := 0;	
	gateways            := dataset([],Gateway.Layouts.Config);
	todaysdate	        := (STRING8)Std.Date.Today();
	nines		 		:= 9999999;

 	key_addr_hist := DISTRIBUTE(dx_header.key_addr_hist(0)(date_first_seen<=history_date AND prim_name<>''),hash64(zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));  // no zip4
 
 	RECORDOF(key_addr_hist) doHalfJoin(key_addr_hist l) := TRANSFORM
		single_instance_address 	:= l.addressstatus[5]='S';
  		addr1 := address.Addr1FromComponents(l.prim_range,l.predir,l.prim_name,l.suffix,l.postdir,l.unit_desig,l.sec_range);
  		address_history_seq := map(
		l.address_history_seq  in [0,91,92,93,94,95,96,97,98,99] or l.addresstype='BUS' 							  							=> 255,
		risk_indicators.iid_constants.override_addr_type(addr1, '','')='P'																						=> 255,  //exclude PO Box addresses
		l.source_count=1 and single_instance_address 																																  => 255,
		l.source_count=1 and l.insurance_source_count=0 and l.property_source_count=0 and
		l.utility_source_count=0 and l.vehicle_source_count=0 and l.dl_source_count=0 and l.voter_source_count=0 	    => 255,
																														l.address_history_seq);
		SELF.address_history_seq	:= address_history_seq;
		SELF := l;
 	END;
	base_pre := PROJECT(key_addr_hist, doHalfJoin(LEFT), LOCAL);             
	base := DEDUP(base_pre(address_history_seq<>255),ALL);
	
	// ********************************************************************
	// Transform PB input to Layout_Input so we can call iid_getDID_prepOutput
	// ********************************************************************
	Risk_Indicators.Layout_Input into(base l, INTEGER c) := TRANSFORM
		self.score := 0;//if((integer)l.lexid<>0, 100, 0);  // hard code the DID score if DID is passed in on input
		self.seq 		:= c;
		self.HistoryDate 	:= if(history_date=0, risk_indicators.iid_constants.default_history_date, history_date);
		addr1_full  := address.Addr1FromComponents(l.prim_range,l.predir,l.prim_name,l.suffix,l.postdir,l.unit_desig,l.sec_range);
		addr_value 	:= trim(addr1_full);
		clean_a2 		:= Risk_Indicators.MOD_AddressClean.clean_addr(addr_value, ''/*l.City_name*/,''/*l.st*/, l.zip);
		self.in_streetAddress:= addr_value;
		self.in_city         := Address.CleanFields(clean_a2).p_city_name;
		self.in_state        := Address.CleanFields(clean_a2).st;
		self.in_zipCode      := l.zip;	
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
		self.addr_type 			 := l.addresstype;//risk_indicators.iid_constants.override_addr_type(addr_value, Address.CleanFields(clean_a2).rec_type[1],Address.CleanFields(clean_a2).cart);
		self.addr_status     := l.addressstatus;//Address.CleanFields(clean_a2).err_stat;
		county          		 := Address.CleanFields(clean_a2).county;
		self.county          := county[3..5]; //bytes 1-2 are state code, 3-5 are county number
		self.geo_blk         := Address.CleanFields(clean_a2).geo_blk;
    	self := l;
    	self := [];
	END;

  	iid_prep_thor := DEDUP(PROJECT(base, into(left,counter)),z5,prim_range,prim_name,predir,addr_suffix,postdir,unit_desig,sec_range,LOCAL);

	r_layout_input_PlusRaw	:=
	record
		ProfileBooster.V2_Key_Layouts.Layout_PB2_In;
		// add these 3 fields to existing layout anytime i want to use this macro
		string60	Line1;
		string60	LineLast;
		unsigned8	rawAID;
	end;

	r_layout_input_PlusRaw	prep_for_AID(iid_prep_thor le)	:=
	transform
		self.Line1		    :=	trim(stringlib.stringtouppercase(le.in_streetaddress));
		self.LineLast	    :=	address.addr2fromcomponents(stringlib.stringtouppercase(le.p_city_name), stringlib.stringtouppercase(le.St),  le.Z5);  // );, uppercase and trim city and state, zip5 only
		self.rawAID			  :=	0;
		self.street_addr  :=  le.in_streetaddress;
		self.streetnumber :=  le.prim_range;
		self.streetpredirection  :=  le.predir;
		self.streetname   :=  le.prim_name;
		self.streetsuffix :=  le.addr_suffix;
		self.streetpostdirection  :=  le.postdir;
		self.unitdesignation  :=  le.unit_desig;
		self.unitnumber   :=  le.sec_range;
		self.city_name    :=  le.p_city_name;
		self	:=	le;
		self  :=  [];
	end;
	aid_prepped	:=	project(iid_prep_thor, prep_for_AID(left),LOCAL);

	// new parameter is the NoNewCacheFiles
	unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords | AID.Common.eReturnValues.NoNewCacheFiles;

	AID.MacAppendFromRaw_2Line(	aid_prepped,
								Line1,
								LineLast,
								rawAID,
								my_dataset_with_address_cache,
								lAIDAppendFlags,
                            	TRUE
							  );

	Risk_Indicators.Layout_Input prep_for_thor(my_dataset_with_address_cache l) := TRANSFORM
		self.seq 		:= l.seq;   
	    self.HistoryDate 	:= if(l.historydate=0, risk_indicators.iid_constants.default_history_date, l.HistoryDate);
		addr_value 	:= trim(l.street_addr);
		self.in_streetAddress:= addr_value;
		self.in_city         := l.City_name;
		self.in_state        := l.st;
		self.in_zipCode      := l.z5;	
		
		self.prim_range      := l.streetnumber;//l.aidwork_acecache.prim_range;
		self.predir          := l.streetpredirection;//l.aidwork_acecache.predir;
		self.prim_name       := l.streetname;//l.aidwork_acecache.prim_name;
		self.addr_suffix     := l.streetsuffix;//l.aidwork_acecache.addr_suffix;
		self.postdir         := l.streetpostdirection;//l.aidwork_acecache.postdir;
		self.unit_desig      := l.unitdesignation;//l.aidwork_acecache.unit_desig;
		self.sec_range       := l.unitnumber;//l.aidwork_acecache.sec_range;
		self.p_city_name     := l.city_name;//l.aidwork_acecache.p_city_name;
		self.st              := l.st;//l.aidwork_acecache.st;
		self.z5              := l.z5;//l.aidwork_acecache.zip5;
		self.zip4            := l.aidwork_acecache.zip4;
		self.lat             := l.aidwork_acecache.geo_lat;
		self.long            := l.aidwork_acecache.geo_long;
		self.addr_type 			 := risk_indicators.iid_constants.override_addr_type(l.street_addr, l.aidwork_acecache.rec_type[1],l.aidwork_acecache.cart);
		self.addr_status     := l.aidwork_acecache.err_stat;
		self.county          := l.aidwork_acecache.county[3..5]; //bytes 1-2 are state code, 3-5 are county number
		self.geo_blk         := l.aidwork_acecache.geo_blk;		
		
		self := [];
	END;

	iid_prep := project(my_dataset_with_address_cache, prep_for_thor(left), LOCAL);									 
										 
	did_prepped_output_pre := ungroup(Risk_Indicators.iid_getDID_prepOutput_THOR(iid_prep, DPPA, GLBA, isFCRA, bsversion, DataRestrictionMask, append_best, gateways, BSOptions));
	did_prepped_output_dist := DISTRIBUTE(did_prepped_output_pre, seq);
	sortDIDs := SORT(UNGROUP(did_prepped_output_dist), seq, -score, did, LOCAL);
	highestDIDScore := DEDUP(sortDIDs, seq, LOCAL);  
	
	without_DID := PROJECT(highestDIDScore, TRANSFORM(Risk_Indicators.Layout_Output, SELF.Account := (STRING)LEFT.Seq; SELF := LEFT), LOCAL);
	donotmail_key := dma.key_DNM_Name_Address;
 
  	//join to DoNotMail to set the DNM attribute
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell setDNMFlag(without_DID le, donotmail_key ri ) := TRANSFORM
		self.DoNotMail 		:= if(ri.l_zip='', '0', '1');
		self.DID2 				:= le.DID; 	//propogate the prospect's DID to DID2 at this point
		self.rec_type 		:= ProfileBooster.Constants.recType.Prospect; //all records are "Prospect" type at this point.  Household and Relatives will be added later.
		self.AcctNo				:= le.Account;
		self 							:= le;
		self 							:= [];
	END;
	
	withDoNotMail := join(distribute(without_DID, hash64(z5, prim_name, prim_range, st)), 
												distribute(pull(donotmail_key), hash64(l_zip, l_prim_name, l_prim_range, l_st)),
		left.z5 != ''
		and left.prim_name = right.l_prim_name
		and left.prim_range = right.l_prim_range
		and left.st = right.l_st
		and right.l_city_code in doxie.Make_CityCodes(left.p_city_name).rox
		and left.z5= right.l_zip
		and left.sec_range = right.l_sec_range,
		setDNMFlag(left,right), left outer, keep(1), local
	);
  
  	//join to my_dataset_with_address_cache to get RawAID back
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell setRawAID(withDoNotMail le, my_dataset_with_address_cache ri ) := TRANSFORM
		self.RawAID				:= ri.aidwork_rawaid;
		self 							:= le;
		self 							:= [];
	END;
  	withRawAID := join(distribute(withDoNotMail, hash64(z5, prim_name, prim_range, st)), 
	  				   distribute(my_dataset_with_address_cache, hash64(z5, streetname, streetnumber, st)),
		    left.prim_name = right.streetname
		and left.prim_range = right.streetnumber
		and left.st = right.st
		and left.p_city_name = right.city_name
		and left.z5= right.z5
		and left.sec_range = right.unitnumber,
		setRawAID(left,right), left outer, keep(1), local
	);

	//JOIN to aid_key to get addr_type and addr_status
	aid_key := AID_Build.Key_AID_Base;

	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_addr_type(withRawAID le, aid_key rt) := transform
		unparsedAddress := address.Addr1FromComponents(le.prim_range, le.predir, le.prim_name, le.suffix, le.postdir, le.unit_desig, le.sec_range);
		self.addr_type		:= if(le.addr_type='',risk_indicators.iid_constants.override_addr_type(unparsedAddress,rt.rec_type,rt.cart),le.addr_type);
		self.addr_status	:= if(le.addr_status='',rt.err_stat,le.addr_status);
		self := le;
    	self := []
	end;

	withAID_key := join(distribute(withRawAID, rawaid), distribute(pull(aid_key), rawaid),
													    right.rawaid=left.hdr_rawaid,
															append_addr_type(left,right),
															left outer, atmost(riskwise.max_atmost), keep(1), local); 
	
	//get business count for the input address
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell getInputBus(withAID_key le, Address_Attributes.key_AML_addr ri)  := TRANSFORM
		self.InpAddrBusRegCnt 	:= ri.biz_cnt;
		self 											:= le;
	END;

	withDoNotMail_inputaddrpopulated := withAID_key(z5<>'' and prim_name<>'');

	withInputBus_thor_hits := join(distribute(withDoNotMail_inputaddrpopulated, hash64(z5, prim_range, prim_name, addr_suffix, predir, postdir)), 
													     distribute(Address_Attributes.key_AML_addr, hash64(zip, prim_range, prim_name, addr_suffix, predir, postdir)), 
		trim(LEFT.z5) 					= RIGHT.zip AND
		trim(LEFT.prim_range) 	= RIGHT.prim_range AND
		trim(LEFT.prim_name) 		= RIGHT.prim_name AND
		trim(LEFT.addr_suffix) 	= RIGHT.addr_suffix AND
		trim(LEFT.predir) 			= RIGHT.predir AND
		trim(LEFT.postdir)			= RIGHT.postdir AND 
		trim(LEFT.sec_range)    = RIGHT.sec_range,
		getInputBus(LEFT, RIGHT),left outer, keep(1),  //only need to keep 1 because biz_cnt is the same on all records for the address
      	atmost(10000), local);

	kaf := LN_PropertyV2.key_addr_fid(FALSE);

	// layout_ids_plus_fares append_fares_id_by_addr(p_addr le, kaf rt) := transform
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_fares_id_by_addr(withInputBus_thor_hits le, kaf rt) := transform
		SELF.ln_fares_id := rt.ln_fares_id,
		SELF := le,			
		SELF := []
	end;
 	STRING1   PROPERTY             := 'P';
 	ids_plus_fares_by_address_thor := 
		JOIN(
			distribute(withInputBus_thor_hits(prim_name<>''), hash64(prim_name, prim_range, z5, sec_range)), 
			distribute(pull(kaf)(source_code_2 = PROPERTY), hash64(prim_name, prim_range, zip, sec_range)),
			LEFT.prim_name = RIGHT.prim_name AND
			LEFT.prim_range = RIGHT.prim_range AND
			LEFT.z5 = RIGHT.zip AND
			LEFT.predir = RIGHT.predir AND
			LEFT.postdir = RIGHT.postdir AND
			LEFT.addr_suffix = RIGHT.suffix AND
			LEFT.sec_range = RIGHT.sec_range,
			append_fares_id_by_addr(left, right),
			LEFT OUTER,
			KEEP(1), 
			ATMOST(RiskWise.max_atmost),
			local
		);

  	Assessments := LN_PropertyV2.File_Assessment;
  
  	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_assessments(ids_plus_fares_by_address_thor l, Assessments r) := TRANSFORM
    	SELF.AddrHasPoolFlag := MAP(r.pool_code NOT IN ['0',''] => 1,0);
		MobileHomeLandUseCodeSet := ['0135','0136','0137','0138','0454','0531','1006','1109'];
		SELF.AddrIsMobileHomeFlag := IF(r.ln_mobile_home_indicator='Y',1,0);
		SELF.AddrBathCnt := (INTEGER4)r.no_of_baths;
		SELF.AddrParkingCnt := (INTEGER4)r.parking_no_of_cars;
		SELF.AddrBuildYr := (INTEGER4)r.year_built;
		SELF.AddrBedCnt := (INTEGER4)r.no_of_bedrooms;
		SELF.AddrBldgSize := (INTEGER4)r.building_area;
		SELF.AddrLat := l.lat;
		SELF.AddrLng := l.long;
	    SELF.AddrBusRegCnt := l.AddrBusRegCnt;
		SELF := l;
		SELF := []
	END;
  
	withAssessments := JOIN(DISTRIBUTE(ids_plus_fares_by_address_thor,hash(ln_fares_id)), 
                            DISTRIBUTE(Assessments,hash(ln_fares_id)),
                            LEFT.ln_fares_id = RIGHT.ln_fares_id,
                            append_assessments(LEFT,RIGHT), LEFT OUTER, KEEP(1), atmost(RiskWise.max_atmost), LOCAL);
 
  	ADVO_BASE_PRE := advo.key_addr1;
  
	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_advo(withAssessments l, ADVO_BASE_PRE r) := TRANSFORM
		MissingInADVO := r.street_name='' AND r.zip_5='';  
		SELF.AddrIsCollegeFlag := MAP(MissingInADVO => -99998,
									r.college_indicator='Y' => 1,
									r.college_indicator='N' => 0,
																-99997);  
		BusinessIndicatorSet := ['B','D'];
		AddrIsAptFlag := NOT r.Residential_or_Business_Ind IN BusinessIndicatorSet; 
		SELF.AddrIsAptFlag := MAP(MissingInADVO => -99998,
								AddrIsAptFlag => 1,
								r.Residential_or_Business_Ind = '' => -99997,
												0);
		SELF.AddrIsVacantFlag := MAP(MissingInADVO => -99998,
									r.address_vacancy_indicator='Y' => 1,
									r.address_vacancy_indicator='N' => 0,
																		-99997);
		SELF := l;
		SELF := []
	END;
  
	withADVO := JOIN(DISTRIBUTE(withAssessments,hash(prim_name,prim_range,z5,predir,postdir,addr_suffix,sec_range)), 
					DISTRIBUTE(ADVO_BASE_PRE,hash(street_name,street_num,zip_5,street_pre_directional,street_post_directional,street_suffix,secondary_unit_number)),
								LEFT.prim_name = RIGHT.street_name AND
							LEFT.prim_range = RIGHT.street_num AND
							LEFT.z5 = RIGHT.zip_5 AND
							LEFT.predir = RIGHT.street_pre_directional AND
							LEFT.postdir = RIGHT.street_post_directional AND
							LEFT.addr_suffix = RIGHT.street_suffix AND
							LEFT.sec_range = RIGHT.secondary_unit_number,
					append_advo(LEFT,RIGHT), LEFT OUTER, KEEP(1), atmost(RiskWise.max_atmost), LOCAL);

	header_key := dx_header.key_header();

	ProfileBooster.V2_Key_Layouts.Layout_PB2_Shell append_header(withADVO l, header_key r) := TRANSFORM
		SELF.HHID := r.HHID;
		SELF := l;
		SELF := []
	END;
  
  	withHeader := JOIN(DISTRIBUTE(withADVO,hash(prim_name,prim_range,z5,predir,postdir,addr_suffix,sec_range)), 
                       DISTRIBUTE(header_key,hash(prim_name,prim_range,zip,predir,postdir,suffix,sec_range)),
                   		LEFT.prim_name = RIGHT.prim_name AND
                        LEFT.prim_range = RIGHT.prim_range AND
                        LEFT.z5 = RIGHT.zip AND
                        LEFT.predir = RIGHT.predir AND
                        LEFT.postdir = RIGHT.postdir AND
                        LEFT.addr_suffix = RIGHT.suffix AND
                        LEFT.sec_range = RIGHT.sec_range AND
                        RIGHT.src in MDR.sourcetools.set_Marketing_Header and
    										RIGHT.dt_first_seen <> 0 and RIGHT.dt_first_seen < history_date,
                     	append_header(LEFT,RIGHT), LEFT OUTER, KEEP(1), LOCAL);

	final2 := PROJECT(withHeader,TRANSFORM(dx_ProfileBooster.Layouts.i_address, 
						SELF.rawaid           := LEFT.rawaid;
						addr1                 := Address.Addr1FromComponents(LEFT.prim_range,LEFT.predir,LEFT.prim_name,LEFT.addr_suffix,
													LEFT.postdir,LEFT.unit_desig,LEFT.sec_range);
						SELF.addrfull         := TRIM(addr1) + ' ' + TRIM(LEFT.p_city_name) + ', ' + TRIM(LEFT.st) + ' ' + TRIM(LEFT.z5)+'-'+TRIM(LEFT.zip4);
						SELF.primaryrange     := LEFT.prim_range;
						SELF.predirectional   := LEFT.predir;
						SELF.primaryname      := LEFT.prim_name;
						SELF.suffix           := LEFT.addr_suffix;
						SELF.postdirectional  := LEFT.postdir;
						SELF.unitdesignation  := LEFT.unit_desig;
						SELF.secondaryrange   := LEFT.sec_range;
						SELF.zip5             := LEFT.z5;
						SELF.zip4             := LEFT.zip4;
						SELF.city_name        := LEFT.p_city_name;
						SELF.st               := LEFT.st;
						SELF.AddrType         := LEFT.addr_type;
						SELF.AddrTypeIndx     := MAP(LEFT.addr_type in ['S','G','R']	=> 3,
													LEFT.addr_type in ['P']					=> 2,
													LEFT.addr_type in ['H','F']			=> 1,
																						0);

						SELF.addrstatus       := (INTEGER)LEFT.addr_status;
						SELF.county           := LEFT.county;
						SELF.geo_blk          := LEFT.geo_blk;
						SELF.addr1            := LEFT.in_streetaddress;
						SELF.geoLink          := LEFT.geoLink;
						SELF.AddrHasPoolFlag := LEFT.AddrHasPoolFlag;
						SELF.AddrIsMobileHomeFlag := LEFT.AddrIsMobileHomeFlag;
						SELF.AddrBathCnt := LEFT.AddrBathCnt;
						SELF.AddrParkingCnt := LEFT.AddrParkingCnt;
						SELF.AddrBuildYr := LEFT.AddrBuildYr;
						SELF.AddrBedCnt := LEFT.AddrBedCnt;
						SELF.AddrBldgSize := LEFT.AddrBldgSize;
						SELF.AddrLat := LEFT.AddrLat;
						SELF.AddrLng := LEFT.AddrLng;
						SELF.AddrIsCollegeFlag := LEFT.AddrIsCollegeFlag;
						SELF.AddrIsVacantFlag := LEFT.AddrIsVacantFlag;
						SELF.AddrForeclosure := LEFT.AddrForeclosure;
						SELF.AddrAVMVal := LEFT.InpAddrAVMVal;
						SELF.AddrAVMValA1Y := LEFT.InpAddrAVMValA1Y;
						SELF.AddrAVMRatio1Y := (DECIMAL10_2)LEFT.InpAddrAVMRatio1Y;
						SELF.AddrAVMValA5Y := LEFT.InpAddrAVMValA5Y;
						SELF.AddrAVMRatio5Y := (DECIMAL10_2)LEFT.InpAddrAVMRatio5Y;
						SELF.AddrMedAVMCtyRatio := (DECIMAL10_2)LEFT.InpAddrMedAVMCtyRatio;
						SELF.AddrMedAVMCenTractRatio := (DECIMAL10_2)LEFT.InpAddrMedAVMCenTractRatio;
						SELF.AddrMedAVMCenBlockRatio := (DECIMAL10_2)LEFT.InpAddrMedAVMCenBlockRatio;
						SELF.AddrBusRegCnt := LEFT.InpAddrBusRegCnt;
						AddrIsMultiUnitFlag := LEFT.addr_type IN ['H','HD'] OR LEFT.unit_desig<>'' OR LEFT.sec_range<>'';  
						SELF.AddrIsAptFlag := IF(AddrIsMultiUnitFlag AND LEFT.AddrIsAptFlag=1,1,0);
						SELF.HHID             := LEFT.HHID;  
						SELF.nbhdid           := (INTEGER)(LEFT.z5+LEFT.zip4);
						SELF.datetime         := STD.Date.Today();
						SELF                  := LEFT; 
						SELF                  := [];), LOCAL);

	finalDeduped := DEDUP(final2, ALL);


 	return finalDeduped;

END;