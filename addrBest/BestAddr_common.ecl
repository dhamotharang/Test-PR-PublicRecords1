import AddrBest, doxie, ut, address, didville, monitoring, DID_Add, STD;


string todays_date := (string) STD.Date.Today ();

export BestAddr_common(dataset(AddrBest.Layout_BestAddr.Batch_in) f_in_raw, UNSIGNED YYMM=1000, BOOLEAN rollup_lastname = false, integer min_threshold = 75,
											 AddrBest.IParams.SearchParams in_mod = AddrBest.IParams.DefaultParams,
											 dataset(AddrBest.layout_header_ext) rank_in = dataset([],AddrBest.layout_header_ext)) := FUNCTION

// ----------[ Local scalar attributes ]----------

doxie.MAC_Header_Field_Declare()

unsigned1 Max_records_per_address 		:= in_mod.MaxRecordsToReturn;
boolean input_addr_dup_value 					:= in_mod.InputAddressDedup;
boolean start_next_most_current_value := in_mod.StartWithNextMostCurrent;
boolean end_next_most_current_value 	:= in_mod.EndWithNextMostCurrent;
boolean ret_dedup_flag_value 					:= in_mod.ReturnDedupFlag;
boolean partial_addr_dup_value 				:= in_mod.PartialAddressDedup;
boolean FNameLNameMatch_value 				:= in_mod.FirstNameLastNameMatch;
boolean FNameMatch_value 							:= in_mod.FirstNameMatch;
boolean LNameMatch_value 							:= in_mod.LastNameMatch;
boolean FullNameMatch_value 					:= in_mod.FullNameMatch;
boolean FInitialLNameMatch_value 			:= in_mod.FirstInitialLastNameMatch;
boolean b_rollup_dtfirstseen 					:= NOT in_mod.DoNOTRollupDateFirstSeen;
boolean IncludeBlankDateLastSeen 			:= in_mod.IncludeBlankDateLastSeen;
BOOLEAN NameMatch_value 							:= in_mod.Match_Name;
BOOLEAN StreetAddressMatch_value 			:= in_mod.Match_Street_Address;
BOOLEAN cityMatch_value 							:= in_mod.Match_City;
BOOLEAN stateMatch_value 							:= in_mod.Match_State;
BOOLEAN zipMatch_value 								:= in_mod.Match_Zip;
BOOLEAN dobMatch_value 								:= in_mod.Match_DOB;
BOOLEAN ssnMatch_value 								:= in_mod.Match_SSN;
BOOLEAN didMatch_value 								:= in_mod.Match_LinkID;
BOOLEAN OnlyReturnSuccessfullyCleanedAddresses := in_mod.OnlyReturnSuccessfullyCleanedAddresses;
BOOLEAN use_nd_val 										:= in_mod.UseNameUniqueDID;

// ----------[ Local transforms ]----------

AddrBest.layout_header_ext get_input_addrs(f_in_raw l, integer C) :=transform
	
	uc := stringlib.stringtouppercase;
	
	addr := uc(
		case(C,
				 1=>trim(l.addr1) + ' ' + trim(l.addr1_2),
				 2=>trim(l.addr2) + ' ' + trim(l.addr2_2),
				 3=>trim(l.addr3) + ' ' + trim(l.addr3_2),
				 4=>trim(l.addr4) + ' ' + trim(l.addr4_2),
				 5=>trim(l.addr5) + ' ' + trim(l.addr5_2),
				 6=>trim(l.addr6) + ' ' + trim(l.addr6_2),
				 7=>trim(l.addr7) + ' ' + trim(l.addr7_2),
				 8=>trim(l.addr8) + ' ' + trim(l.addr8_2),
				 9=>trim(l.addr9) + ' ' + trim(l.addr9_2),
						trim(l.addr10) + ' ' + trim(l.addr10_2)));
	city := uc(
		case(C,1=>l.city_name1,2=>l.city_name2,3=>l.city_name3,4=>l.city_name4,5=>l.city_name5,6=>l.city_name6,7=>l.city_name7,8=>l.city_name8,9=>l.city_name9,l.city_name10));
	state :=uc(
		case(C,1=>l.st1,2=>l.st2,3=>l.st3,4=>l.st4,5=>l.st5,6=>l.st6,7=>l.st7,8=>l.st8,9=>l.st9,l.st10));
	zip := case(C,1=>l.zip1,2=>l.zip2,3=>l.zip3,4=>l.zip4,5=>l.zip5,6=>l.zip6,7=>l.zip7,8=>l.zip8,9=>l.zip9,l.zip10);

	addr_line_first := if(C=0,
	uc(TRIM(l.prim_range) + ' ' + TRIM(l.predir) + ' ' +  TRIM(l.prim_name) + ' ' + TRIM(l.suffix) + ' ' + TRIM(l.postdir)+ ' ' + TRIM(l.unit_desig)+ ' ' + TRIM(l.sec_range)),
	addr);
	

	addr_line_second := if(C=0,
	uc(Trim(l.p_city_name)+ ' ' + trim(l.st) + ' '+ trim(l.z5)),	
	TRIM(city) + ' ' + TRIM(state) + ' ' + TRIM(zip));

	// create cleaned US address
	
	//Clean_Address := Address.ca_US(addr_line_first,addr_line_second);
	// roll this code back once prod platform gets updated

  Clean_Addr :=Address.CleanAddress182(addr_line_first,addr_line_second);
  
  prim_range := clean_addr [1..10];
  predir     := clean_addr [11..12];
  prim_name  := clean_addr [13..40];
  suffix     := clean_addr [41..44];
  postdir    := clean_addr [45..46];
  sec_range  := clean_addr [57..64];
  v_city     := clean_addr [90..114];
  st         := clean_addr [115..116];
  z5         := clean_addr [117..121]; 	
  zip4       := clean_addr [122..125];
  
	alt_addr_parse := partial_addr_dup_value and prim_range ='';

									 
	alt_prim_range := addr_line_first[1..Stringlib.StringFind(addr_line_first,' ', 1)-1];
	alt_prim_name  := trim(addr_line_first[Stringlib.StringFind(addr_line_first,' ', 1)+1..]);

	self.is_Input := TRUE;
	self.best_address_number := Max_Records_Per_Address;
	self.did := (unsigned6) l.Acctno;
	self.prim_range := if(alt_addr_parse, alt_prim_range, prim_range);
	self.predir := predir;
	self.prim_name := if(alt_addr_parse, alt_prim_name, prim_name);
	self.suffix :=suffix;
	self.postdir := postdir;
	self.sec_range :=sec_range;
	self.city_name :=if(alt_addr_parse,city, v_city);
	self.st :=if(alt_addr_parse,state, st);
	self.zip :=if(alt_addr_parse,zip, z5);
	self.zip4 := zip4;
	self := [];
END;

// ----------[ Local layouts ]----------

Batch_in := Layout_BestAddr.Batch_in;

acc_did_rec := RECORD
	QSTRING20	acctno;
	UNSIGNED6	did;
END;

acc_did_rec_v2 := RECORD(acc_did_rec)
	unsigned2 score := 0;
END;	

// ----------[ Local functions ]----------

viaDIDAppend(DATASET(Batch_in) rawInput) := FUNCTION

	Layout_Did_InBatch_X := RECORD(DidVille.Layout_Did_InBatch)
		STRING20	acctno;
		unsigned6 did;
	END;

	Layout_Did_InBatch_X toDIDInBatchX(Batch_in l, UNSIGNED cnt) := TRANSFORM
		SELF.seq := cnt;
		SELF.phone10 := l.phoneno;
		SELF.title := '';
		SELF.fname := l.name_first;
		SELF.mname := l.name_middle;
		SELF.lname := l.name_last;
		SELF.suffix := l.name_suffix;
		SELF.addr_suffix := l.suffix;
		SELF := l;
	END;

	inBatchX := PROJECT(rawInput, toDIDInBatchX(LEFT, COUNTER));
	macroInput := PROJECT(inBatchX, DidVille.Layout_Did_OutBatch);

	DidVille.MAC_DidAppend(macroInput, macroOutput, TRUE, '4N'); // And '4N' means...?

	acc_did_rec_v2 toAccDID(DidVille.Layout_Did_OutBatch l, Layout_Did_InBatch_X r) := 
		TRANSFORM, // This SKIP needs to be reworked. The EXISTS( ) is probably very expensive.
			SKIP(LENGTH(TRIM(l.ssn)) = 6 AND ~EXISTS(DidVille.key_did_ssn(did = l.did AND ssn[4..] = l.ssn)))
				SELF.did := l.did;
				SELF.acctno := r.acctno;
				SELF.score := l.score;
		END;

	accDids  := JOIN(macroOutput(did <> 0, score>=min_threshold or score=0 or in_mod.ReturnMultiADLIndicator), inBatchX,
									LEFT.seq = RIGHT.seq,
									toAccDID(LEFT, RIGHT),
									LEFT OUTER, KEEP(1));

	RETURN accDids;
END;

// ----------[ <<<<< MAIN >>>>> ]----------

// 1. Normalize and clean the input record addresses. The resulting layout is header.layout_header 
// plus a few extra fields added.
norm_input := if(input_addr_dup_value,1,0);

f_inputs := normalize(f_in_raw,map(left.addr10 <> ''=>10 + norm_input,
																	 left.addr9 <> '' => 9+ norm_input,
																	 left.addr8 <> '' => 8+ norm_input,
																	 left.addr7 <> '' => 7 + norm_input,
																	 left.addr6 <> '' => 6+ norm_input,
																	 left.addr5 <> '' =>5+ norm_input,
																	 left.addr4 <> '' => 4 + norm_input,
																	 left.addr3 <> ''=> 3 + norm_input,
																	 left.addr2 <> ''=>2 + norm_input,
																	 1 + norm_input),get_input_addrs(left,counter-norm_input));														

// 2. Append a DID and score it.
did_append_recs := viaDIDAppend(f_in_raw);

// 3. Project the input records into a layout for easier use among several functions, below.
alphabet := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
AlphasOnly (string strIn) := stringlib.stringfilter (strIn, alphabet);

f_in := project(f_in_raw, transform(didville.Layout_BestInfo_BatchIn_w_did,
																		 self.name_first :=
																		 AlphasOnly(stringlib.stringtouppercase(left.name_first)),
																		 self.name_middle :=
																		 AlphasOnly(stringlib.stringtouppercase(left.name_middle)),
																		 self.name_last :=
																		 AlphasOnly(stringlib.stringtouppercase(left.name_last)),
																		 self := left,self:=[]));

// 4. Call Didville.All_recs.get_tpl( ) to obtain DIDs and Best header records by 
// all possible means. Filter; then sort by DID.
f_in_triple := project(f_in, didville.layout_bestInfo_batchin);
acctno_did  := project(did_append_recs,acc_did_rec);

tpl_best_prefilt_pre := 
		Didville.All_recs.get_tpl( f_in_triple, use_nd_val, FALSE, acctno_did, true);

tpl_best_prefilt :=
		tpl_best_prefilt_pre( // awkward filter:
			prim_name[1..3]<>'DOD' and 
			(
			 (zip4 <> '' and OnlyReturnSuccessfullyCleanedAddresses)
			 or OnlyReturnSuccessfullyCleanedAddresses = false
			)
		);
												
tpl_best_prefilt_plus := sort(tpl_best_prefilt,did);

// 5. Perform some additional filtering to obtain Best header records based on the record date 
// and user-selected options. Assign the value of the maximum number of records to return.
AddrBest.layout_header_ext add_num_addr(tpl_best_prefilt_plus l) := transform
	self.best_address_number := Max_records_per_address;
	Self.is_Input := FALSE;
	self := l;
end;

// ...Note: date_last_seen_value is obtained from doxie.mac_header_field_declare( )
max_date_last_seen := MAX(date_last_seen_value,((unsigned)(todays_date[1..6])-YYMM));

tpl_best_filt := 
		tpl_best_prefilt_plus( // filter:
			dt_last_seen >= max_date_last_seen or 
			(IncludeBlankDateLastSeen and dt_last_seen = 0) or 
			(in_mod.IncludeHistoricRecords and dt_last_seen > 0)
		);
		
tpl_best  := ungroup(project(tpl_best_filt, add_num_addr(left))) + rank_in;
// 6. Append the normalized input records (or not) to the Best header records retrieved  
// above, depending on user choice. See the note below for more detailed explanation.

// Bug #89436: By default, normalized input addresses (addr1, ..., addrN) are used to dedupe (is_input=true) 
// records inside Mac_Monitoring_Best_Addr.
// Product also wants to use those addresses to flag confirmed match code without removing ('deduping') 
// the addresses from the output. So if returned confirmed match code is enabled and no explicit address 
// dedup option is selected, we skip dedup by not passing these records to Mac_Monitoring_Best_Addr.
// We will use the normalized input addresses later on to set the confirmed match code before returning
// the final records.
f_input_recs := if(~in_mod.ReturnConfirmedMatchCode or input_addr_dup_value or ret_dedup_flag_value,
										f_inputs, dataset([], AddrBest.layout_header_ext));
best_ready := tpl_best + f_input_recs;

// 7. Set values to instruct Mac_Monitoring_Best_Addr both how to dedup the Best records  
// retrieved already, and what name and address criteria to use for matching against the 
// retrieved records.
dedup_option := map(end_next_most_current_value and ret_dedup_flag_value => 6,
									  end_next_most_current_value => 5,
										start_next_most_current_value and ret_dedup_flag_value => 4,
										start_next_most_current_value => 3,
										ret_dedup_flag_value => 2,
										1);
name_match_option := map(FNameMatch_value => 1,
											   LNameMatch_value => 2,
												 FNameLNameMatch_value => 3,
												 FullNameMatch_value => 4,
												 FInitialLNameMatch_value => 5,
												 0);
State_match_option := map(stateMatch_value => true,
                         false);												 

unserviceable_dedup_option := map(
															in_mod.ReturnUnServAddrIndicator and in_mod.UnServAddrDedup => 2,  // remove address but return flag
															~in_mod.ReturnUnServAddrIndicator and in_mod.UnServAddrDedup => 1, // remove address and flag
															0); 																															 // return address with or without flag

			 									
// ** this macro takes care of deduping like addresses and filtering based on input params
monitoring.Mac_Monitoring_Best_Addr(best_ready, did,tpl_best_ready, true, f_in,dedup_option,name_match_option,if(partial_addr_dup_value,1,0),true,
																		b_rollup_dtfirstseen, rollup_lastname, in_mod.ReturnUnServAddrIndicator, unserviceable_dedup_option, in_mod.ReturnFlipFlopIndicator, in_mod.HistoricMatchCodes,
																		NameMatch_value, StreetAddressMatch_value, cityMatch_value, stateMatch_value, zipMatch_value, ssnMatch_value, dobMatch_value, didMatch_value, 
																		rank_in, Max_records_per_address);

// 8. Using dids from the Best records arrived at in Mac_Monitoring_Best_Addr, get relative 
// dids and then append child dataset of Gong records.
rels := doxie.relative_dids(project(tpl_best_ready,transform(doxie.layout_references,self.did:=left.rid)));


//** bdid will serve as a holder field for the acctno since its not doing anything otherwise and did and rid are already being used
//** going into append_gong the did field holds a real did and the rid field holds a unique id

pre_gong := project(tpl_best_ready,transform(AddrBest.Layout_BestAddr.batch_presentation,self.did:=left.rid,self.bdid:=left.did,self.rid :=0, self:=left,
	self.dppa := dppa_purpose,self.glb := glb_purpose, self:=[]));


ut.MAC_Sequence_Records(pre_gong, rid, pre_gong_w_unique_rids);

best_w_gong := doxie.Append_Gong(pre_gong_w_unique_rids,rels);


//** do we want to prefer gong verified here?

// 9. Sort and dedup Best-with-Gong records according several criteria, including  
// there/not-there ('tnt') value (see doxie.MAC_getTNTValue for decoding the letters) and 
// date_last_seen. Rejoined to pre-gonged Best records.
dup_w_gong := dedup(sort(best_w_gong,rid,if(exists(phones),0,1),  map(tnt='B'=>0, tnt='V'=>1, tnt='P'=>2,tnt='C'=>3,4), -if(dt_last_seen=0,dt_first_seen,dt_last_seen),phone<>listed_phone,record),rid);

final_recs := join(dup_w_gong,pre_gong_w_unique_rids,
								left.rid=right.rid, transform(AddrBest.Layout_BestAddr.batch_presentation_phones,
								self.match_name := right.match_name;
								self.match_street_address := right.match_street_address;
								self.match_city := right.match_city;
								self.match_state := right.match_state;
								self.match_zip := right.match_zip;
								self.match_ssn := right.match_ssn;
								self.match_dob := right.match_dob;
								self.match_did := right.match_did;
								self.matches := right.matches;
								self.unserviceable := right.unserviceable;
								self.matchcodes := right.matchcodes;
								self.ff_mover := right.ff_mover;
								self.srcs :=dedup(right.srcs,all),
								self :=left),all);	

// 10. Join back to did-appended records and perform scoring of SSN, name, DOB; set flags.
AddrBest.Layout_BestAddr.service_Out_matchcodes get_outrc(final_recs l,f_in r) := transform
	self.name_first := l.fname;
	self.name_middle := l.mname;
	self.name_last := l.lname;
	self.name_dual := if(stringlib.stringfind(l.listed_name,' & ',1)>0,l.listed_name,'');


	self.phone10 := map(l.listed_phone<>''=>l.listed_phone,exists(l.phones)=>l.phones[1].phone10,l.phone);
	self.dob := if(l.dob=0,'',(string8)l.dob);	
	self.p_city_name := l.city_name;
	self.unit_desig := if(l.sec_range='', '', l.unit_desig);
	self.z5 := l.zip;
	self.addr_dt_last_seen := if(l.dt_last_seen=0,'',(string6)l.dt_last_seen);
	self.addr_dt_first_seen := if(l.dt_first_seen=0,'',(string6) l.dt_first_seen);
  self.srcs := l.srcs;
	self := l;
	self.dup_flag := if(l.rec_type in ['C','H'],l.rec_type,''); // use the rec type field because layout passed back from best_addr has no dup flag
	
	name_score_v1 := (string3)  ut.NameMatch100(l.fname, l.mname, l.lname,
	                                   r.name_first, r.name_middle, r.name_last);
	
	name_match_score := ut.NameMatch(l.fname,l.mname,l.lname,r.name_first,r.name_middle,r.name_last);
	name_score_v2 := (string3) map( r.name_first='' and r.name_middle='' and r.name_last=''=>255, // no input
																	l.fname='' and l.mname='' and l.lname=''=>255, 
																		name_match_score=0=>100, // perfect match
																		name_match_score=1=>90, // a close match
																		name_match_score=2=>80, // a good match
																		name_match_score=3=>70, // a so-so match
																		name_match_score<50=>50, // poor match
																		name_match_score>98=>0, //no match or exceptionally poor match
																		20); // default extremely poor match.		
	ssn_score_v1 :=(string3)  ut.SSNMatch100(l.ssn, r.ssn);
	ssn_score_v2 := (string3) IF(l.ssn<>'' and r.ssn<>'', ut.SSNMatch100(l.ssn, r.ssn), 255);	
	
	self.name_score := IF(in_mod.isV2Score, name_score_v2, name_score_v1);
	self.ssn_score 	:= IF(in_mod.isV2Score, ssn_score_v2, ssn_score_v1);	
	self.dob_score 	:= IF(in_mod.isV2Score, (string3) DID_Add.DOB_Match_Score((integer) l.dob, (integer) r.dob), '');
	self.acctno := r.Acctno;
	self.fips_county:=l.county;
	self.is_input := l.prim_name = r.prim_name and l.zip = r.z5 and l.prim_range = r.prim_range and
						(l.sec_range='' or r.sec_range<>'' and l.sec_range=r.sec_range);											
end;

out_recs := join(final_recs,f_in,
								 left.bdid=(unsigned6) right.Acctno,
								 get_outrc(left, right),nosort);

// 11. Join back to input records and set match codes, confidence flags, and indicator codes.
AddrBest.Layout_BestAddr.best_Out_common add_remaining_codes(out_recs l, f_in_raw r) := 
TRANSFORM
		SELF.acctno      := l.acctno; // sets acctno			
		// check empty records to detect deduped records
		deduped_record := l.name_last='' and l.name_first='' and l.prim_name='' and l.prim_range='' and l.p_city_name='' and l.addr_dt_last_seen='' and l.addr_dt_first_seen='';
		self.matchcodes := IF(~deduped_record, l.matchcodes, '');
		ssn_match := l.ssn='' or r.ssn='' or l.ssn=r.ssn or (unsigned)l.ssn % 10000 = (unsigned)r.ssn % 10000;
		// confidence set based on how old the record is and how close ssn matches (if any)
		self.conf_flag := MAP(
					~in_mod.ReturnConfidenceFlag or deduped_record => '', 
					l.name_last = r.name_last and l.name_first[1..3] = r.name_first[1..3] and
					ut.MonthsApart(todays_date, l.addr_dt_last_seen) <= 1 and
					ssn_match and ~l.unserviceable => 'H',
	        l.name_last <> r.name_last and l.name_first[1..3] <> r.name_first[1..3] or
					((integer) l.addr_dt_last_seen > 0 and ut.MonthsApart(todays_date, l.addr_dt_last_seen) > 3) or 
					~ssn_match or l.unserviceable => 'L',
					'M');
		// conf_addr_match_code is used to flag a match between input and returned address.
		addr_match_code := map(~in_mod.ReturnConfirmedMatchCode => false,
												   l.is_input => true,
													 // If address dedup and return dedup options are enabled, we no longer have the returned 
													 // address available here. For those cases, we check empty records with a valid dup_flag.
													 deduped_record and (l.dup_flag='C' or l.dup_flag='H') => true,
													 // Also checking for matches in case multiple input addresses have been provided (addr1, addr2, etc).
													 exists(f_inputs(did=(unsigned6)l.acctno,prim_range=l.prim_range, prim_name=l.prim_name, 
														   					   city_name=l.p_city_name, zip=l.z5,
																					 (l.sec_range='' or (sec_range<>'' and l.sec_range=sec_range)))) => true,
													 false);
		self.conf_addr_match_code	:= if(addr_match_code, 'Y', '');														 
		self.unserv_addr := IF(in_mod.ReturnUnServAddrIndicator and l.unserviceable, 'U', ''); 		
		self.ff_mover := IF(in_mod.ReturnFlipFlopIndicator and l.ff_mover, 'F', '');
		SELF := l;		
		SELF := [];																			
END;						

out_recs_w_codes := join(out_recs, f_in_raw, left.acctno = right.acctno,	add_remaining_codes(left, right), left outer)(matches = true);										

// 12. Set multiple count flag, make a choice, and return.
out_recs_w_adl_ind := join(out_recs_w_codes,did_append_recs,
													 left.did = right.did and left.acctno = right.acctno,
													 transform(AddrBest.Layout_BestAddr.best_Out_common, 		
														self.multiple_count_flag := IF(right.score>0 and right.score < Constants.unique_score_threshold,'M',''),
														self := left),
													 LEFT OUTER);

out_recs_final := if(in_mod.ReturnMultiADLIndicator, out_recs_w_adl_ind, out_recs_w_codes);
// OUTPUT(f_in_triple,NAMED('f_in_triple'));
// OUTPUT(tpl_best_prefilt_pre,NAMED('tpl_best_prefilt_pre'));
// OUTPUT(tpl_best0,NAMED('tpl_best0'));
// OUTPUT(rank_in,NAMED('rank_in'));
// OUTPUT(tpl_best,NAMED('tpl_best'));
// OUTPUT(best_ready,NAMED('best_ready'));
// OUTPUT(tpl_best_ready,NAMED('tpl_best_ready'));
// OUTPUT(out_recs,NAMED('out_recs'));
return out_recs_final;

END;