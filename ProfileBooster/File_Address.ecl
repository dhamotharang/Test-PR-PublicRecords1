import ProfileBooster, Doxie, MDR, dx_header, Risk_Indicators, address, AID, Gateway, STD, dma, 
       Address_Attributes, Riskwise, avm_v2, dx_ProfileBooster, LN_PropertyV2, LN_PropertyV2_Services, Advo, AID_Build;

export File_Address(UNSIGNED3 history_date) := function
  DataRestrictionMask := Risk_Indicators.iid_constants.default_DataRestriction;
  DataPermissionMask := Risk_Indicators.iid_constants.default_DataPermission;
 	isFCRA 			:= false;
	GLBA 				:= 0;
	DPPA 				:= 0;
	BSOptions   := Risk_Indicators.iid_constants.BSOptions.RetainInputDID;
	bsversion   := 50;
	append_best := 0;	
	gateways    := dataset([],Gateway.Layouts.Config);
	todaysdate	:= (STRING8)Std.Date.Today();
	nines		 		:= 9999999;

 // base := choosen(dx_header.key_addr_hist(0)(date_first_seen<=history_date),1000);  // no zip4
 // base := DISTRIBUTE(dx_header.key_addr_hist(0)(date_first_seen<=history_date AND prim_name<>''), RANDOM());  // no zip4
 // base := DISTRIBUTE(dx_header.key_addr_hist(0)(date_first_seen<=history_date AND prim_name<>''),hash64(prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,zip));  // no zip4
 // key_addr_hist := DISTRIBUTE(CHOOSEN(dx_header.key_addr_hist(0)(date_first_seen<=history_date AND prim_name<>''),100),hash64(prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,zip));  // no zip4
 // base := dx_header.key_address(0); // no zip4
 //to get started, you could use a sample of the address rank key, clean the addresses in there so you have zip4, then do whatever other joins you need.  
 //that's basically what you're going to get when/if KS-5834 is going to add it
 //6/29/2020 - KS-5834 still in a TODO status
 
 // key_addr_hist := DISTRIBUTE(dx_header.key_addr_hist(0)(date_first_seen<=history_date AND prim_name<>''),rawaid);  // no zip4
 key_addr_hist := DISTRIBUTE(dx_header.key_addr_hist(0)(date_first_seen<=history_date AND prim_name<>''),hash64(zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range));  // no zip4
 /*
single_instance_address 	:= ri.addressstatus[5]='S';
		addr1 := address.Addr1FromComponents(ri.prim_range,ri.predir,ri.prim_name,ri.suffix,ri.postdir,ri.unit_desig,ri.sec_range);
		address_history_seq := map(
			ri.address_history_seq  in [0,91,92,93,94,95,96,97,98,99] or ri.addresstype='BUS' 														=> 255,
			risk_indicators.iid_constants.override_addr_type(addr1, '','')='P'																						=> 255,  //exclude PO Box addresses
			le.zip4='' 																																																		=> 255,
			ri.source_count=1 and single_instance_address 																																=> 255,
			ri.source_count=1 and ri.insurance_source_count=0 and ri.property_source_count=0 and
			ri.utility_source_count=0 and ri.vehicle_source_count=0 and ri.dl_source_count=0 and ri.voter_source_count=0 	=> 255,
																																																											 ri.address_history_seq);
		SELF.address_history_seq	:= address_history_seq;
		SELF.hdr_date_first_seen	:= ri.date_first_seen;
		SELF.hdr_date_last_seen		:= ri.date_last_seen;
		SELF.LifeEvTimeLastMove		:= if(ri.date_first_seen <> 0, ut.MonthsApart(risk_indicators.iid_constants.myGetDate(le.historydate)[1..6],((string)ri.date_first_seen)[1..6]), nines);
		
*/
 //TEMP SOLUTION UNTIL FULL LEXID KEY BUILD 
 // pb20LexidKey1 := DISTRIBUTE(dx_profilebooster.Key_Lexid(0)(curr_addr_rawaid>0),curr_addr_rawaid);
 // pb20LexidKey2 := DISTRIBUTE(dx_profilebooster.Key_Lexid(0)(prev_addr_rawaid>0),prev_addr_rawaid);
 // rolledAddrsFile := '~jfrancis::out::pb20_withverification_roxie';
 // raLayout := ProfileBooster.V2_Layouts.Layout_PB2_Shell;
 // rolledAddrs := DATASET(rolledAddrsFile,raLayout,CSV(HEADING(single), QUOTE('"')));

 RECORDOF(key_addr_hist) doHalfJoin(key_addr_hist l) := TRANSFORM
	single_instance_address 	:= l.addressstatus[5]='S';
  addr1 := address.Addr1FromComponents(l.prim_range,l.predir,l.prim_name,l.suffix,l.postdir,l.unit_desig,l.sec_range);
  address_history_seq := map(
    l.address_history_seq  in [0,91,92,93,94,95,96,97,98,99] or l.addresstype='BUS' 							  							=> 255,
    risk_indicators.iid_constants.override_addr_type(addr1, '','')='P'																						=> 255,  //exclude PO Box addresses
    // l.zip4='' 																																																		=> 255,
    l.source_count=1 and single_instance_address 																																  => 255,
    l.source_count=1 and l.insurance_source_count=0 and l.property_source_count=0 and
    l.utility_source_count=0 and l.vehicle_source_count=0 and l.dl_source_count=0 and l.voter_source_count=0 	    => 255,
                                                                                                                     l.address_history_seq);
  SELF.address_history_seq	:= address_history_seq;
	SELF := l;
 END;
 // output(COUNT(key_addr_hist),named('key_addr_hist_cnt'));
/* base_pre1 := JOIN(key_addr_hist, pb20LexidKey1,
              left.rawaid=right.curr_addr_rawaid,
              // left.rawaid IN [right.curr_addr_rawaid,right.prev_addr_rawaid],
              doHalfJoin(LEFT), INNER, KEEP(1), LOCAL);
 // output(COUNT(base_pre1),named('kbase_pre1_cnt'));
 base_pre2 := JOIN(key_addr_hist, pb20LexidKey2,
              left.rawaid=right.prev_addr_rawaid,
              // left.rawaid IN [right.curr_addr_rawaid,right.prev_addr_rawaid],
              doHalfJoin(LEFT), INNER, KEEP(1), LOCAL);
*/
 // output(COUNT(base_pre2),named('base_pre2_cnt'));
 /*
base_pre3 := JOIN(DISTRIBUTE(key_addr_hist,HASH64(zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range)), 
                   DISTRIBUTE(rolledAddrs,HASH64(curr_z5,curr_prim_range,curr_prim_name,curr_predir,curr_addr_suffix,curr_postdir,curr_unit_desig,curr_sec_range)),
                          // risk_indicators.MOD_AddressClean.street_address('',TRIM(LEFT.prim_range), TRIM(LEFT.predir), TRIM(LEFT.prim_name), TRIM(LEFT.suffix), 
                                                                             // TRIM(LEFT.postdir),  TRIM(LEFT.unit_desig), TRIM(LEFT.sec_range)) =                                                                             
                          // risk_indicators.MOD_AddressClean.street_address('',TRIM(RIGHT.curr_prim_range), TRIM(RIGHT.curr_predir), TRIM(RIGHT.curr_prim_name), TRIM(RIGHT.curr_addr_suffix), 
                                                                             // TRIM(RIGHT.curr_postdir),  TRIM(RIGHT.curr_unit_desig), TRIM(RIGHT.curr_sec_range)) AND                                                 
                          TRIM(LEFT.prim_range) = TRIM(RIGHT.curr_prim_range) AND
                          TRIM(LEFT.prim_name,ALL) = TRIM(RIGHT.curr_prim_name,ALL) AND
                          TRIM(LEFT.zip) = TRIM(RIGHT.curr_z5),
              doHalfJoin(LEFT), LOCAL);
 base_pre4 := JOIN(DISTRIBUTE(key_addr_hist,HASH64(zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range)), 
                   DISTRIBUTE(rolledAddrs,hash64(z5   ,prim_range   ,prim_name   ,addr_suffix          ,predir,postdir,sec_range)),
                          // risk_indicators.MOD_AddressClean.street_address('',TRIM(LEFT.prim_range), TRIM(LEFT.predir), TRIM(LEFT.prim_name), TRIM(LEFT.suffix), 
                                                                             // TRIM(LEFT.postdir),  TRIM(LEFT.unit_desig), TRIM(LEFT.sec_range)) =                                                                             
                          // risk_indicators.MOD_AddressClean.street_address('',TRIM(RIGHT.prim_range), TRIM(RIGHT.predir), TRIM(RIGHT.prim_name), TRIM(RIGHT.addr_suffix), 
                                                                     // TRIM(RIGHT.postdir),  TRIM(RIGHT.unit_desig), TRIM(RIGHT.sec_range)) AND                                                 
                          TRIM(LEFT.prim_range) = TRIM(RIGHT.prim_range) AND
                          TRIM(LEFT.prim_name,ALL) = TRIM(RIGHT.prim_name,ALL) AND
                          TRIM(LEFT.zip) = TRIM(RIGHT.z5),
              doHalfJoin(LEFT), LOCAL);
*/
 // base_pre := PROJECT(key_addr_hist, doHalfJoin(LEFT), LOCAL);             
 base_pre := PROJECT(key_addr_hist, doHalfJoin(LEFT), LOCAL);             
 base := DEDUP(base_pre(address_history_seq<>255),ALL);
 // base_sorted := SORT(base_pre(address_history_seq<>255),zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range,LOCAL);
 // base_sorted := SORT(base_pre3+base_pre4,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range);
 // base  := DEDUP(base_sorted,zip,prim_range,prim_name,predir,suffix,postdir,unit_desig,sec_range,LOCAL);
 // OUTPUT(base_dedup(zip='10009' and prim_range='1' and prim_name='HAVEN'),named('sampleSanityCheck'));
 // output(COUNT(base_dedup),named('base_pre_cnt'));
 // base := DISTRIBUTE(base_dedup, hash64(prim_range,predir,prim_name,suffix,postdir,unit_desig,sec_range,zip));
 // OUTPUT(count(base_dedup),named('Check1'));
 // OUTPUT(CHOOSEN(base, 1000),named('base_sample'));
 
 
 
 // ********************************************************************
 // Transform PB input to Layout_Input so we can call iid_getDID_prepOutput
 // ********************************************************************
 Risk_Indicators.Layout_Input into(base l, INTEGER c) := TRANSFORM
		// self.did 		:= (integer)l.LexId;
		self.score := 0;//if((integer)l.lexid<>0, 100, 0);  // hard code the DID score if DID is passed in on input
		self.seq 		:= c;
		self.HistoryDate 	:= if(history_date=0, risk_indicators.iid_constants.default_history_date, history_date);
		// self.ssn 		:= l.ssn;
		// dob_val 		:= riskwise.cleandob(l.dob);
		// dob 				:= dob_val;
		// self.dob 		:= if((unsigned)dob=0, '', dob);

		// fname  			:= l.Name_First ;
		// mname  			:= l.Name_Middle;
		// lname  			:= l.Name_Last ;
		// suffix 			:= l.Name_Suffix ;
		// self.fname  := stringlib.stringtouppercase(fname);
		// self.mname  := stringlib.stringtouppercase(mname);
		// self.lname  := stringlib.stringtouppercase(lname);
		// self.suffix := '';//stringlib.stringtouppercase(suffix);
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
		// self.Phone10				 := StringLib.StringFilter(l.Phone10, '0123456789');
    self := l;
    self := [];
	END;

  iid_prep_thor := DEDUP(PROJECT(base, into(left,counter)),z5,prim_range,prim_name,predir,addr_suffix,postdir,unit_desig,sec_range,LOCAL);
                      // prim_range,predir,prim_name,addr_suffix,postdir,sec_range,p_city_name,st,z5,zip4,LOCAL);	

// OUTPUT(count(base),named('Check2'));
  // NEW::  Calling the AID address cache macro now that Tony added the new feature for us:  https://bugzilla.seisint.com/show_bug.cgi?id=194258

r_layout_input_PlusRaw	:=
record
	ProfileBooster.V2_Layouts.Layout_PB2_In;
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
		// self.did 		:= (integer)l.LexId;
		// self.score := if((integer)l.lexid<>0, 100, 0);  // hard code the DID score if DID is passed in on input
		// self.seq 		:= l.seq;   
		self.seq 		:= l.seq;   
    self.HistoryDate 	:= if(l.historydate=0, risk_indicators.iid_constants.default_history_date, l.HistoryDate);

		// self.ssn 		:= l.ssn;
		// dob_val 		:= riskwise.cleandob(l.dob);
		// dob 				:= dob_val;
		// self.dob 		:= if((unsigned)dob=0, '', dob);

		// fname  			:= l.Name_First ;
		// mname  			:= l.Name_Middle;
		// lname  			:= l.Name_Last ;
		// suffix 			:= l.Name_Suffix ;
		// self.fname  := stringlib.stringtouppercase(fname);
		// self.mname  := stringlib.stringtouppercase(mname);
		// self.lname  := stringlib.stringtouppercase(lname);
		// self.suffix := stringlib.stringtouppercase(suffix);
		// self.Phone10				 := StringLib.StringFilter(l.Phone10, '0123456789');		
		
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
  // did_prepped_output_sorted := sort(did_prepped_output_pre, seq, LOCAL);
  // did_prepped_output := dedup(did_prepped_output_sorted, seq, LOCAL);
  sortDIDs := SORT(UNGROUP(did_prepped_output_dist), seq, -score, did, LOCAL);
  highestDIDScore := DEDUP(sortDIDs, seq, LOCAL);  
  
  without_DID := PROJECT(highestDIDScore, TRANSFORM(Risk_Indicators.Layout_Output, SELF.Account := (STRING)LEFT.Seq; SELF := LEFT), LOCAL);
OUTPUT(count(without_DID),named('Check3'));
  donotmail_key := dma.key_DNM_Name_Address;
 
  //join to DoNotMail to set the DNM attribute
	ProfileBooster.V2_Layouts.Layout_PB2_Shell setDNMFlag(without_DID le, donotmail_key ri ) := TRANSFORM
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
		// and left.lname = right.l_lname
		// and left.fname = right.l_fname,
		setDNMFlag(left,right), left outer, keep(1), local
	);
// OUTPUT(count(withDoNotMail),named('Check4'));
  
  //join to my_dataset_with_address_cache to get RawAID back
	ProfileBooster.V2_Layouts.Layout_PB2_Shell setRawAID(withDoNotMail le, my_dataset_with_address_cache ri ) := TRANSFORM
		// self.RawAID				:= ri.aidwork_acecache.AID;
		// self.RawAID				:= ri.aidwork_acecache.cleanAID;
		self.RawAID				:= ri.aidwork_rawaid;
		self 							:= le;
		self 							:= [];
	END;
  withRawAID := join(distribute(withDoNotMail, hash64(z5, prim_name, prim_range, st)), 
												// distribute(my_dataset_with_address_cache), hash64(aidwork_acecache.zip5, aidwork_acecache.prim_name, aidwork_acecache.prim_range, aidwork_acecache.st, aidwork_acecache.zip4)),
												distribute(my_dataset_with_address_cache, hash64(z5, streetname, streetnumber, st)),
		    left.prim_name = right.streetname
		and left.prim_range = right.streetnumber
		and left.st = right.st
		and left.p_city_name = right.city_name
		and left.z5= right.z5
		and left.sec_range = right.unitnumber,
		setRawAID(left,right), left outer, keep(1), local
	);
// OUTPUT(count(withRawAID),named('Check5'));

  //JOIN to aid_key to get addr_type and addr_status
  aid_key := AID_Build.Key_AID_Base;

	ProfileBooster.V2_Layouts.Layout_PB2_Shell append_addr_type(withRawAID le, aid_key rt) := transform
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
  ProfileBooster.V2_Layouts.Layout_PB2_Shell getInputBus(withAID_key le, Address_Attributes.key_AML_addr ri)  := TRANSFORM
		self.InpAddrBusRegCnt 	:= ri.biz_cnt;
		// self.ResCurrBusinessCnt 	:= if(le.curr_equals_input, ri.biz_cnt, 0);
		self 											:= le;
  END;

withDoNotMail_inputaddrpopulated := withAID_key(z5<>'' and prim_name<>'');
// withDoNotMail_inputaddr_notpopulated := withDoNotMail(z5='' or prim_name='');
OUTPUT(count(withDoNotMail_inputaddrpopulated),named('Check6'));

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

OUTPUT(count(withInputBus_thor_hits),named('Check7'));
 
  // withInputBus_thor := withInputBus_thor_hits + withDoNotMail_inputaddr_notpopulated;	// add back the records that didn't have input address populated
  
  // allDIDs := withInputBus_thor_hits;
 
	// allDIDs := withInputBus;
	
/*  
//if a DID is both a household member and a relative, keep only the household record so relatives attributes are exclusive
	distributed_allDIDs := distribute(withInputBus_thor_hits, hash(seq, did2));
	unique_DIDs_thor := dedup(sort(distributed_allDIDs, seq, DID2, rec_type, local), seq, DID2, local);//   : PERSIST('~PROFILEBOOSTER::unique_DIDs_thor');  // remove persists because low on disk space and it's rebuilding persist file each time anyway
	
	uniqueDIDs := unique_DIDs_thor;
  
//slim down the uniqueDIDs records to create a smaller layout to pass into all of the following searches
	slimShell := project(uniqueDIDs,  
												transform(ProfileBooster.Layouts.Layout_PB_Slim,
																	self 							:= left), local);

//--------- Property -------------//

	includeRelativeInfo := false;
	filter_out_fares		:= true;	//Fares data is restricted from use in any Marketing product

//for prospect pass input address, current address and previous address into property common function as we need info for all
  Risk_Indicators.Layout_PropertyRecord get_addresses(withInputBus_thor_hits le, integer c) := TRANSFORM
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
	
  p_address := group(normalize(withInputBus_thor_hits, 1, get_addresses (LEFT,COUNTER))(prim_name != '', zip5 != ''), seq);
	
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
	
ProfileBooster.V2_Layouts.Layout_PB2_Shell append_property(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, prop_common rt) := transform
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
		self.LifeAstPurchOldMsnc	:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect, max(le.LifeAstPurchOldMsnc, monthsSincePurchased), le.LifeAstPurchOldMsnc);
		self.LifeAstPurchNewMsnc	:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect, 
																						map(monthsSincePurchased = 0							=> le.LifeAstPurchNewMsnc,
																								le.LifeAstPurchNewMsnc = 0	=> monthsSincePurchased,
																																												 min(le.LifeAstPurchNewMsnc,monthsSincePurchased)),
																						le.LifeAstPurchNewMsnc);	
		self.CurrAddrOwnershipIndx				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect,
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
		self.InpAddrOwnershipIndx				:= if(le.rec_type=ProfileBooster.Constants.recType.Prospect,
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
	
withSports_distr := distribute(withInputBus_thor_hits, did2);
prop_common_distr := distribute(prop_common, did);
	
	withProperty_thor := join(withSports_distr, prop_common_distr,
												left.did2 = right.did,
												append_property(left, right), left outer, local)
												;
	// : PERSIST('~PROFILEBOOSTER::withProperty_thor');// remove persists because low on disk space and it's rebuilding persist file each time anyway
	
	withProperty := withProperty_thor;
	
	withProperty_distributed := distribute(withProperty, seq);
	sortedProperty :=  sort(withProperty, seq, did2, -sale_date_by_did, -owned_prim_range, -owned_prim_name, local); //within DID, sort most recent sold property to top

	ProfileBooster.V2_Layouts.Layout_PB2_Shell rollProperty(sortedProperty le, sortedProperty ri) := TRANSFORM
		same_prop := le.owned_prim_range=ri.owned_prim_range and le.owned_prim_name=ri.owned_prim_name;
		same_sold_prop := le.sold_prim_range = ri.sold_prim_range AND le.sold_prim_name = ri.sold_prim_name;
		
		// self.PropCurrOwner								:= max(le.PropCurrOwner, ri.PropCurrOwner);
		// self.PropCurrOwnedCnt							:= le.PropCurrOwnedCnt + if(same_prop, 0, ri.PropCurrOwnedCnt);
		// self.PropCurrOwnedAssessedTtl			:= le.PropCurrOwnedAssessedTtl + if(same_prop, 0, ri.PropCurrOwnedAssessedTtl);
		// self.PropTimeLastSale							:= min(le.PropTimeLastSale, ri.PropTimeLastSale);
		// self.PropEverOwnedCnt							:= le.PropEverOwnedCnt + if(same_prop, 0, ri.PropEverOwnedCnt);
		// self.PropEverSoldCnt							:= le.PropEverSoldCnt + if(same_sold_prop, 0, ri.PropEverSoldCnt);
		// self.PropSoldCnt12Mo							:= le.PropSoldCnt12Mo + if(same_sold_prop, 0, ri.PropSoldCnt12Mo);
		// self.PropSoldRatio								:= le.propSoldRatio; //most recent was sorted first so always just keep the left
		// self.PropPurchaseCnt12Mo					:= le.PropPurchaseCnt12Mo + if(same_prop, 0, ri.PropPurchaseCnt12Mo);
		// self.LifeAstPurchOldMsnc	:= max(le.LifeAstPurchOldMsnc, ri.LifeAstPurchOldMsnc);
		// self.LifeAstPurchNewMsnc	:= map(ri.LifeAstPurchNewMsnc = 0	=> le.LifeAstPurchNewMsnc,
																						 // le.LifeAstPurchNewMsnc = 0	=> ri.LifeAstPurchNewMsnc,
																																									 // min(le.LifeAstPurchNewMsnc, ri.LifeAstPurchNewMsnc));
		self.CurrAddrOwnershipIndx			 	:= max(le.CurrAddrOwnershipIndx, ri.CurrAddrOwnershipIndx);  
		self.ResCurrMortgageType					:= if(ri.ResCurrMortgageType <> '', ri.ResCurrMortgageType, le.ResCurrMortgageType);
		self.ResCurrMortgageAmount				:= max(le.ResCurrMortgageAmount, ri.ResCurrMortgageAmount);
		self.InpAddrOwnershipIndx			   	:= max(le.InpAddrOwnershipIndx, ri.InpAddrOwnershipIndx);  
		self.ResInputMortgageType					:= if(ri.ResInputMortgageType <> '', ri.ResInputMortgageType, le.ResInputMortgageType);
		self.ResInputMortgageAmount				:= max(le.ResInputMortgageAmount, ri.ResInputMortgageAmount);
		self.curr_AssessedAmount					:= max(le.curr_AssessedAmount, ri.curr_AssessedAmount);
		self.prev_AssessedAmount					:= max(le.prev_AssessedAmount, ri.prev_AssessedAmount);
		// self.HHPropCurrOwnerMmbrCnt			 	:= max(le.HHPropCurrOwnerMmbrCnt, ri.HHPropCurrOwnerMmbrCnt);  
		// self.HHPropCurrOwnedCnt					 	:= le.HHPropCurrOwnedCnt + if(same_prop, 0, ri.HHPropCurrOwnedCnt); 
		// self.RaAPropCurrOwnerMmbrCnt			:= max(le.RaAPropCurrOwnerMmbrCnt, ri.RaAPropCurrOwnerMmbrCnt);
		self								 							:= le;
	END;

	rolledProperty :=  rollup(sortedProperty, left.seq = right.seq and left.did2 = right.did2,
											rollProperty(left, right), LOCAL);

//--------- AVM -------------//

	preAVM := group(project(rolledProperty,  // withInfutor contains only Prospect records...we don't need HH or relatives info
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
												transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
																	// self.CurrAddrAVMVal 					:= right.address_history_1.avm_automated_valuation;
																	// self.CurrAddrAVMValA1Y 			:= right.address_history_1.avm_automated_valuation2;
																	// self.CurrAddrAVMRatio1Y := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_automated_valuation2 = 0, 
																																		 // '0', 
																																		 // trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_automated_valuation2, 99.0)));
																	// self.CurrAddrAVMValA5Y 			:= right.address_history_1.avm_automated_valuation6;
																	// self.CurrAddrAVMRatio5Y := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_automated_valuation6 = 0, 
																																		 // '0', 
																																		 // trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_automated_valuation6, 99.0)));
																	// self.CurrAddrMedAVMCtyRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_fips_level = 0, 
																																  // '0', 
																																	// trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_fips_level, 99.0)));
																	// self.CurrAddrMedAVMCenTractRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_geo11_level = 0, 
																																	// '0', 
																																	// trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_geo11_level, 99.0)));
																	// self.CurrAddrMedAVMCenBlockRatio := if(right.address_history_1.avm_automated_valuation = 0 or right.address_history_1.avm_median_geo12_level = 0, 
																																	// '0', 
																																	// trim((string)(decimal4_2)min(right.address_history_1.avm_automated_valuation / right.address_history_1.avm_median_geo12_level, 99.0)));
																	self.InpAddrAVMVal 				:= right.Input_Address_Information.avm_automated_valuation;
																	self.InpAddrAVMValA1Y 		:= right.Input_Address_Information.avm_automated_valuation2;
																	self.InpAddrAVMRatio1Y := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_automated_valuation2 = 0, 
																																			'0', 
																																			trim((string)(decimal4_2)min(right.Input_Address_Information.avm_automated_valuation / right.Input_Address_Information.avm_automated_valuation2, 99.0)));
																	self.InpAddrAVMValA5Y 		:= right.Input_Address_Information.avm_automated_valuation6;
																	self.InpAddrAVMRatio5Y := if(right.Input_Address_Information.avm_automated_valuation = 0 or right.Input_Address_Information.avm_automated_valuation6 = 0, 
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
	
	// avm1Owned_roxie := join(preAVMOwned, avm_v2.Key_AVM_Address,  
								// left.address_verification.input_address_information.prim_name!='' and left.address_verification.input_address_information.zip5!='' and
								// keyed(left.address_verification.input_address_information.prim_name = right.prim_name) and
								// keyed(left.address_verification.input_address_information.st = right.st) and
								// keyed(left.address_verification.input_address_information.zip5 = right.zip) and
								// keyed(left.address_verification.input_address_information.prim_range = right.prim_range) and
								// keyed(left.address_verification.input_address_information.sec_range = right.sec_range) and	// NNEQ here?
								// left.address_verification.input_address_information.predir=right.predir and 
								// left.address_verification.input_address_information.postdir=right.postdir,
							// add_AVM(left, right),  
									// atmost(RiskWise.max_atmost), keep(100));

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

	avm1Owned := group(avm1Owned_thor, seq);
	
	// when choosing which AVM to output if the addr returns more than 1 result, 
	// always pick the record with the most recent recording date and secondarily the most recent assessed value year
	avms1Owned := dedup(sort(avm1Owned, seq, did, prim_range, prim_name, zip, -Input_Address_Information.avm_recording_date, -Input_Address_Information.avm_assessed_value_year),
																			seq, did, prim_range, prim_name, zip);
	
	withAVMOwned := join(withAVM, avms1Owned,
												left.seq = right.seq and
												left.DID2 = right.DID,
												transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
																	self.PropCurrOwnedAVMTtl 			:= if(left.rec_type = ProfileBooster.Constants.recType.Prospect, right.Input_Address_Information.avm_automated_valuation, 0);
																	self.HHPropCurrAVMHighest 		:= if(left.rec_type in [ProfileBooster.Constants.recType.Prospect,ProfileBooster.Constants.recType.Household], right.Input_Address_Information.avm_automated_valuation, 0);
																	self.RaAPropOwnerAVMHighest 	:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, right.Input_Address_Information.avm_automated_valuation, 0);
																	self.RaAPropOwnerAVMMed 			:= if(left.rec_type = ProfileBooster.Constants.recType.Relative, right.Input_Address_Information.avm_automated_valuation, 0);
																	self := left), left outer, parallel);

	sortedAVMOwned :=  sort(withAVMOwned, seq, did2); 

	groupAVMOwned := group(sortedAVMOwned(RaAPropOwnerAVMMed<>0), seq);	

	ProfileBooster.V2_Layouts.Layout_PB2_Shell rollAVMOwned(sortedAVMOwned le, sortedAVMOwned ri) := TRANSFORM
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
                                  
                                  self.other_address_info.addrs_last_5years										:= if(right.LifeMoveNewMsnc > 60, 0, 1);
																	self.reported_dob																						:= (integer)right.dob;
																	self.addrpop2																								:= right.curr_prim_name <> '' and right.curr_z5 <> '';
																	self.addrpop3																								:= right.prev_prim_name <> '' and right.prev_z5 <> '';
																	self := left), left outer, parallel);

	econTraj := risk_indicators.getEconomicTrajectory(Group(BSappended, seq));		

	withEconTraj := join(rolledAVMOwned, econTraj,
												left.seq = right.seq and
												left.rec_type = ProfileBooster.Constants.recType.Prospect,  //update only the prospect record (not HH or relative)
												transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
																	self.LifeAddrEconTrajType 	:= right.economic_trajectory;
																	self.LifeAddrEconTrajIndx 	:= right.economic_trajectory_index;
																	self := left), left outer, parallel);
	
// At this point we have one record for the prospect, one for each household member and one for each relative - roll them up 
// here to sum all of the household and relatives attributes for the prospect record  
  ProfileBooster.V2_Layouts.Layout_PB2_Shell rollFinal(ProfileBooster.V2_Layouts.Layout_PB2_Shell le, ProfileBooster.V2_Layouts.Layout_PB2_Shell ri) := transform
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
*/
//append relatives' average income
	// withRelaIncome := join(finalRollup, tRelaIncome,  
												// left.seq = right.seq,
												// transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
																	// self.RaAMedIncomeRange	:= right.RelaIncome;  
																	// self := left), left outer);

//append count of households within relatives
	// withRelaHHcnt := join(withRelaIncome, tRelaHHcnt,  
												// left.seq = right.seq,
												// transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
																	// self.RaAHHCnt	:= right.RelaHHcnt;  
																	// self := left), left outer);

	// tRelaAVMMed := table(groupAVMOwned(rec_type=ProfileBooster.Constants.recType.Relative and RAAPropOwnerAVMMed <> 0), {seq, RelaAVMMed := ave(group, RAAPropOwnerAVMMed)}, seq);

//append median AVM value for relatives
	// withAVMMed := join(withRelaHHcnt, tRelaAVMMed,  
												// left.seq = right.seq,
												// transform(ProfileBooster.V2_Layouts.Layout_PB2_Shell,
																	// self.RAAPropOwnerAVMMed	:= right.RelaAVMMed;  
																	// self := left), left outer);
	
	// ProfileBooster.Layouts.Layout_PB_BatchOut tfEmpty(PB_In le) := transform
		// self.seq			:= le.seq;
		// SELF.AcctNo		:= le.AcctNo;
		// self 					:= [];
	// end;

	// emptyAttr := project(PB_In, tfEmpty(left)); 
			
// *******************************************************************************************************************
// Now that we have all necessary data in the PBShell, pass it to the attributes function to produce the attributes
// *******************************************************************************************************************
  // attributes := if(StringLib.StringToUpperCase(AttributesVersion) in ProfileBooster.Constants.setValidAttributeVersions OR domodel, //if valid attributes version requested, go get attributes
									 // ProfileBooster.getAttributes(withAVMMed, DataPermissionMask),
									 // emptyAttr);  
									 
	// withIncome := ProfileBooster.estimatedIncome(attributes);
	
	// withHHIncome := ProfileBooster.HHestimatedIncome(withIncome); //for production
	
	// withBankingExperiance := ProfileBooster.getBankingExperiance (withHHIncome);
// #IF(DEBUG)
  //Model that is being tested goes here
  // with_mover_model := profilebooster.PB1708_1_0(withBankingExperiance);
 // with_mover_model := profilebooster.PB1708_1_0(withBankingExperiance);
 
// #ELSE
  // with_mover_model := if(domodel,
                        // CASE(modelname,
////                        'PB1708_1' => profilebooster.PB1708_1_0(withBankingExperiance, iid_prep),
                        // 'PB1708_1' => profilebooster.PB1708_1_0(withBankingExperiance),
                        // 'PBM1803_0' => profilebooster.PBM1803_0_1_score(withBankingExperiance, iid_prep),
                        
                                      // DATASET([],ProfileBooster.Layouts.Layout_PB_BatchOut)),
                        // withBankingExperiance);
// #END                        

//Blank out the fields calculated outside of getAttributes for any minors
// ProfileBooster.Layouts.Layout_PB_BatchOut Blank_minors(ProfileBooster.Layouts.Layout_PB_BatchOut le) := TRANSFORM
  // isMinor := le.attributes.version1.ProspectAge = '0'; //is zero if is a minor
  // self.attributes.version1.prospectestimatedincomerange := if(isMinor, '-1', le.attributes.version1.prospectestimatedincomerange);
  // self.attributes.version1.prospectbankingexperience := if(isMinor, '-1', le.attributes.version1.prospectbankingexperience);
  // self.attributes.version1.hhestimatedincomerange := if(isMinor, '-1', le.attributes.version1.hhestimatedincomerange);
  // self := le;
// END;



 // Final := PROJECT(with_mover_model, Blank_minors(left));                   
 kaf := LN_PropertyV2.key_addr_fid(FALSE);

 // layout_ids_plus_fares append_fares_id_by_addr(p_addr le, kaf rt) := transform
 ProfileBooster.V2_Layouts.Layout_PB2_Shell append_fares_id_by_addr(withInputBus_thor_hits le, kaf rt) := transform
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
			// INNER,
			LEFT OUTER,
			KEEP(1), 
			ATMOST(RiskWise.max_atmost),
			local
		);
OUTPUT(count(ids_plus_fares_by_address_thor),named('Check8'));

  Assessments := LN_PropertyV2.File_Assessment;
  
  ProfileBooster.V2_Layouts.Layout_PB2_Shell append_assessments(ids_plus_fares_by_address_thor l, Assessments r) := TRANSFORM
    SELF.AddrHasPoolFlag := MAP(r.pool_code NOT IN ['0',''] => 1,0);
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
    SELF.AddrIsMobileHomeFlag := IF(r.ln_mobile_home_indicator='Y',1,0);
    SELF.AddrBathCnt := (INTEGER4)r.no_of_baths;
    SELF.AddrParkingCnt := (INTEGER4)r.parking_no_of_cars;
    SELF.AddrBuildYr := (INTEGER4)r.year_built;
    SELF.AddrBedCnt := (INTEGER4)r.no_of_bedrooms;
    SELF.AddrBldgSize := (INTEGER4)r.building_area;
    SELF.AddrLat := l.lat;
    SELF.AddrLng := l.long;
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
    SELF.AddrBusRegCnt := l.AddrBusRegCnt;
    // SELF.AddrIsAptFlag := LEFT.rawaid;
    SELF := l;
    SELF := []
  END;
  
  withAssessments := JOIN(DISTRIBUTE(ids_plus_fares_by_address_thor,hash(ln_fares_id)), 
                          DISTRIBUTE(Assessments,hash(ln_fares_id)),
                          LEFT.ln_fares_id = RIGHT.ln_fares_id,
                          append_assessments(LEFT,RIGHT), LEFT OUTER, KEEP(1), atmost(RiskWise.max_atmost), LOCAL);
OUTPUT(count(withAssessments),named('Check9'));
 
/*   PropertyAssessments := LN_PropertyV2.key_assessor_fid(FALSE);
   
     ProfileBooster.V2_Layouts.Layout_PB2_Shell append_property_assessments(ids_plus_fares_by_address_thor l, PropertyAssessments r) := TRANSFORM
       SELF.AddrHasPoolFlag := MAP(r.pool_code NOT IN ['0',''] => 1,0);
       SELF.AddrIsMobileHomeFlag := IF(r.ln_mobile_home_indicator='Y',1,0);
       SELF.MobHomeFlag := IF(r.ln_mobile_home_indicator='Y',1,0);
       SELF.AddrBathCnt := (INTEGER4)r.no_of_baths;
       SELF.AddrParkingCnt := (INTEGER4)r.parking_no_of_cars;
       SELF.AddrBuildYr := (INTEGER4)r.year_built;
       SELF.AddrBedCnt := (INTEGER4)r.no_of_bedrooms;
       SELF.AddrBldgSize := (INTEGER4)r.building_area;
       // SELF.AddrLat := LEFT.rawaid;
       // SELF.AddrLng := LEFT.rawaid;
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
       SELF.AddrBusRegCnt := l.AddrBusRegCnt;
       // SELF.AddrIsAptFlag := LEFT.rawaid;
   
       SELF := l;
       SELF := []
     END;
     

  withPropertyAssessments := JOIN(withAssessments, PropertyAssessments,
                          LEFT.ln_fares_id = RIGHT.ln_fares_id,
                          append_property_assessments(LEFT,RIGHT));
*/

  ADVO_BASE_PRE := advo.key_addr1;
  
  ProfileBooster.V2_Layouts.Layout_PB2_Shell append_advo(withAssessments l, ADVO_BASE_PRE r) := TRANSFORM
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
    // SELF.AddrForeclosure := r.
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
OUTPUT(count(withADVO),named('Check10'));

  // ProfileBooster.V2_Layouts.Layout_PB2_Shell without_advo(withAssessments l, ADVO_BASE_PRE r) := TRANSFORM
    // SELF.AddrIsCollegeFlag := -99998;
    // SELF.AddrIsAptFlag     := -99998;
    // SELF.AddrIsVacantFlag  := -99998;
    // SELF := l;
    // SELF := []
  // END;
  // withoutADVO := JOIN(DISTRIBUTE(withAssessments,hash(prim_name,prim_range,z5,predir,postdir,addr_suffix,sec_range)), 
                   // DISTRIBUTE(ADVO_BASE_PRE,hash(street_name,street_num,zip_5,street_pre_directional,street_post_directional,street_suffix,secondary_unit_number)),
                   			// LEFT.prim_name = RIGHT.street_name AND
                        // LEFT.prim_range = RIGHT.street_num AND
                        // LEFT.z5 = RIGHT.zip_5 AND
                        // LEFT.predir = RIGHT.street_pre_directional AND
                        // LEFT.postdir = RIGHT.street_post_directional AND
                        // LEFT.addr_suffix = RIGHT.street_suffix AND
                        // LEFT.sec_range = RIGHT.secondary_unit_number,
                   // without_advo(LEFT,RIGHT), LEFT ONLY, KEEP(1), atmost(RiskWise.max_atmost), LOCAL);
// OUTPUT(count(withoutADVO),named('Check10b'));

  header_key := dx_header.key_header();

  ProfileBooster.V2_Layouts.Layout_PB2_Shell append_header(withADVO l, header_key r) := TRANSFORM
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
                   // left outer, keep(200), atmost(RiskWise.max_atmost)

OUTPUT(count(withHeader),named('Check11'));

// final2 := PROJECT(withPropertyAssessments,TRANSFORM(dx_ProfileBooster.Layouts.i_address, 
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
  // SELF.Rent := LEFT.rawaid;
  // SELF.RentValue := LEFT.rawaid;
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

//DEBUGGING

// OUTPUT(choosen(iid_prep_thor,1000),named('iid_prep_thor'));
// OUTPUT(choosen(aid_prepped,1000),named('aid_prepped'));
// OUTPUT(choosen(my_dataset_with_address_cache,100),named('my_dataset_with_address_cache'));
// OUTPUT(choosen(iid_prep,1000),named('iid_prep'));
// OUTPUT(choosen(withDoNotMail,100),named('withDoNotMail'));
// OUTPUT(choosen(withRawAID,100),named('withRawAID'));
// OUTPUT(choosen(withInputBus_thor_hits,1000),named('withInputBus_thor_hits'));
// OUTPUT(choosen(econTraj,1000),named('econTraj'));
// OUTPUT(choosen(withAssessments,1000),named('withAssessments'));
// OUTPUT(choosen(withADVO,1000),named('withADVO'));
// OUTPUT(choosen(withHeader,1000),named('withHeader'));
// OUTPUT(choosen(withPropertyAssessments,1000),named('withPropertyAssessments'));
// OUTPUT(withInputBus,,'~jrf::pb20::withInputBus.csv',CSV(HEADING(SINGLE)), __compressed__, overwrite);
// OUTPUT(choosen(avm1Owned,100),named('avm1Owned'));
// OUTPUT(avms1Owned(prim_range, prim_name, zip),named('avms1Owned'));
// OUTPUT(preAVMOwned,named('preAVMOwned'));
// OUTPUT(choosen(preAVM,100),named('preAVM'));
// OUTPUT(choosen(AVMrecs,100),named('AVMrecs'));
// OUTPUT(choosen(withAVM,100),named('withAVM'));
// OUTPUT(final,named('final_address'));
// OUTPUT(choosen(iid_prep,1000), named('iid_prep'));
// OUTPUT(choosen(iid_prep_thor,1000), named('iid_prep_thor'));
// OUTPUT(choosen(did_prepped_output,1000), named('did_prepped_output'));
// OUTPUT(choosen(finalRollup,1000), named('finalRollup'));
// OUTPUT(choosen(final2,1000), named('final2'));
 
 return finalDeduped;

 END;