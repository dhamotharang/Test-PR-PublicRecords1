/*2017-02-08T20:33:27Z (Andrea Koenen)
RR-10931: checking in since QA testing-  for FCRA to use score >= 80
*/

import didville, risk_indicators, doxie, gateway, riskwise, autokey, header_quick, dx_header, Suppress, data_services;

// this function will take the input data, append the DID and do all default values in layout output
export iid_getDID_prepOutput(DATASET(risk_indicators.layout_input) indata, unsigned1 dppa, unsigned1 glb, 
							boolean isFCRA=false,
							unsigned1 BSversion, string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
							unsigned1 append_best=0/*0-don't append best, 1-save best ssn, 2-append best ssn to input if missing*/,
							dataset(Gateway.Layouts.Config) gateways,
							unsigned8 BSOptions=0,	// this is initially being passed for the cap one riskview batch service so we dont call neutral roxie
							doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := function
	
	data_environment :=  IF(isFCRA, data_services.data_env.iFCRA, data_services.data_env.iNonFCRA);
	// used for Capital One's custom RiskView batch service so it doesn't call the neutral roxie.  DID is passed in as input
	// FCRAConsumerAtributes_service uses the same capone mechanism to skip the neutral roxie / using the passed in did
	CapOneBatch := isFCRA and ( ((BSOptions & iid_constants.BSOptions.IsCapOneBatch) > 0) or ((BSOptions & iid_constants.BSOptions.DIDRIDSearchOnly) > 0) );
	UseInputDidORRid := ~isFCRA AND (BSOptions & iid_constants.BSOptions.DIDRIDSearchOnly) > 0;
	IsInstantIDv1 := ~isFCRA AND (BSOptions & iid_constants.BSOptions.IsInstantIDv1) > 0;
	RetainInputDID := (BSOptions & risk_indicators.iid_constants.BSOptions.RetainInputDID) > 0;
	EnableEmergingID := (BSOptions & risk_indicators.iid_constants.BSOptions.EnableEmergingID) > 0;
	FCRAScoreCheck := isFCRA and bsVersion > 2 ; //FCRA versions > 2, can't give back score < 80

	// for 5.0, Brad wants us to do the did searching on all records, not just the 0 DID records
	didprep_pre50 := PROJECT(indata(did=0), TRANSFORM(didville.Layout_Did_OutBatch, SELF := LEFT));
	didprep_50 := PROJECT(indata, TRANSFORM(didville.Layout_Did_OutBatch, self.did := 0, self.score := 0, SELF := LEFT));  // setting the DID to 0, even if customer provided it on input
	didprep := if(bsversion>=50 and not RetainInputDID, didprep_50, didprep_pre50);
	
	
	// now calling the did append function rather than just calling the macro because name swapping needs to call this twice and it errors with 2 macros in here
	resuTemp := risk_indicators.DID_append_function(didprep, glb, dppa, isFCRA, bsversion);
	
	// Check to see if we need to swap the first and last names.  this will be done if DID=0 and name swap eligible (currently coded as 75% of total)
	layoutTemp := RECORD
		didville.Layout_Did_OutBatch;
		BOOLEAN swappedNames := FALSE;
	END;
	
	layoutTemp checkNameSwap(resuTemp le) := TRANSFORM
		checkSwap1 := CHOOSEN(risk_indicators.Key_NameFrequency(keyed(name=le.fname) AND isLastName),1);	// swap if first name is a last name
		checkSwap2 := CHOOSEN(risk_indicators.Key_NameFrequency(keyed(name=le.lname) AND isFirstName),1);	// swap if last name is a first name
		
		SELF.fname := if(checkSwap1[1].isLastName or checkSwap2[1].isFirstName, le.lname, le.fname);	// swap names if need be
		SELF.lname := if(checkSwap1[1].isLastName or checkSwap2[1].isFirstName, le.fname, le.lname);	// swap names if need be
		SELF.swappedNames := checkSwap1[1].isLastName or checkSwap2[1].isFirstName;
		SELF := le;
	END;
	possibleNameSwap := PROJECT(resuTemp(DID=0), checkNameSwap(LEFT));

	// make second call to did append for name swap candidates for CIID only
	resuTemp2 := risk_indicators.DID_append_function(UNGROUP(PROJECT(possibleNameSwap(swappedNames),didville.Layout_Did_OutBatch)), glb, dppa, isFCRA, bsversion);
	
	resu := if(IsInstantIDv1, PROJECT(resuTemp(DID<>0), layoutTemp) + possibleNameSwap(~swappedNames) + PROJECT(resuTemp2, TRANSFORM(layoutTemp, self.swappedNames:=left.did<>0, self := left)), 
														PROJECT(resuTemp, layoutTemp));		

	
 // ===============================
 // did_from_input
 // if the DIDRIDSearchOnly option is set, check if the did exists,
 // if not, check if a RID exists,
 // if not, set the did to 0 and do not do a did lookup for the record.
 
	didResolveRec := record
		boolean public_records_hit;
		unsigned6 new_did_from_rid;
		risk_indicators.layout_input;
	end;
 
	with_public_records_flag_unsuppressed := join(indata, risk_indicators.Key_ADL_Risk_Table_v4, 
		left.did<>0 and keyed(left.did=right.did),
		transform({didResolveRec, unsigned4 global_sid}, 
			self.global_sid := right.global_sid;
			self.public_records_hit := right.did<>0;
			self.new_did_from_rid := 0; // to be set later if public_records didn't get a hit
			self := left), atmost(riskwise.max_atmost), keep(1), left outer);
			
	with_public_records_flag_flagged := Suppress.MAC_FlagSuppressedSource(with_public_records_flag_unsuppressed, mod_access, data_env := data_environment);

	with_public_records_flag := PROJECT(with_public_records_flag_flagged, TRANSFORM(didResolveRec, 
		self.public_records_hit := IF(left.is_suppressed, (BOOLEAN)Suppress.OptOutMessage('BOOLEAN'), left.public_records_hit);
		SELF := LEFT;
	)); 

	with_new_did := join(with_public_records_flag, dx_header.key_did_rid(),
		left.did<>0 and ~left.public_records_hit and
		keyed(left.did=right.rid), // search for incoming did in the RID list to xreff to new did.
		transform(didResolveRec,
			self.new_did_from_rid := right.did,
			self := left),
			atmost(riskwise.max_atmost), keep(1), left outer);
 
 	risk_indicators.layout_output inputToOutLayout(didResolveRec le) := transform
		
		did := if(le.public_records_hit=true, le.did, 0);
		self.did := if(le.public_records_hit=false and le.new_did_from_rid<>0, le.new_did_from_rid, did);
		self.firstscore := 255;
		self.lastscore := 255;
		self.hphonescore := 255;
		self.wphonescore := 255;
		self.socsscore := 255;
		self.dobscore := 255;
		self.addrscore := 255;
		self.cmpyscore := 255;
		self.didcount := 1;
		self := le;
		self := [];	// chronology address flags
	end;

	did_from_input := project(with_new_did, inputToOutLayout(LEFT));
 // ===============================
 	
	// if the input has the DID already, don't send that input record through the didappend again
	already_has_did := PROJECT(indata(did<>0), TRANSFORM(layoutTemp, SELF := LEFT));
	all_dids1_pre50 := ungroup(resu + already_has_did);


	// for 5.0, if the DID append doesn't find a DID, use the DID provided by the customer
	all_dids1_50 := ungroup(
		join(resu, already_has_did, left.seq=right.seq, 
			transform(layoutTemp, 
				self.did := if(right.did<>0 and left.did=0, right.did, left.did), 
				self.score := if(right.did<>0 and left.did=0, right.score, left.score), 
				self := left), left outer, keep(1) ) );
				
	all_dids1 := if(bsversion>=50 and not RetainInputDID, all_dids1_50, all_dids1_pre50);
	
	
	// get a count of the DID's found if bsVersion>2
	did_slim := RECORD
		all_dids1.seq;
		did_ct := count(group);
	END;
	d_did := TABLE(all_dids1(did<>0), did_slim, seq, few);

	
	// add code to keep only 3 DID's if multiple are found - keep highest scoring DIDs and if a tie keep lowest numbered DID
	// all_dids := if(BSversion>2, dedup(sort(all_dids1, seq, -score, DID), seq, keep(3)), all_dids1);
	all_dids := map(BSversion >= 50	=> dedup(sort(all_dids1, seq, -score, DID), seq, keep(3)), 
									BSversion >  2	=> dedup(sort(all_dids1, seq), seq, keep(3)),
																     all_dids1);
	// make sure the DIDs are unique so that a batch of records with the same person doesn't cause memory limit error later
	unique_dids := dedup(sort(project(all_dids,transform(doxie.layout_references,self:=left)), did), did);
	
	// get best ssn from same function we use in the collection shell
	bestSSNandState := risk_indicators.collection_shell_mod.getBestCleaned(	unique_dids, 
																																					DataRestriction, 
																																					glb, 
																																					clean_address:=false); // don't need clean address, just the best SSN
	
	withBestSSN := join(all_dids, bestSSNandState, left.did<>0 and left.did=right.did,
														TRANSFORM(layoutTemp, 
																			SELF.best_ssn := if(append_best=0, left.ssn, right.ssn),  
																			SELF.best_state := right.st,
																			self := left), left outer, keep(1));
																	
																										
	// withBestSSN := if(append_best=0, all_dids,	bestSSNappended);
	
	soapcall_results := Risk_Indicators.Neutral_DID_Soapcall(indata, gateways, BSversion, append_best, DataRestriction, RetainInputDID);	// this has DID results and best ssn appended if needed
	
	// for cap one riskview batch service, dont call the neutral roxie because we already have the DID on input
	hasDID := project(indata, transform(Risk_Indicators.Layouts.Layout_Neutral_DID_Service, self.did_ct:=0, self := left));

	withNeutral := if(isFCRA, if(CapOneBatch, hasDID, soapcall_results), project(withBestSSN, transform(Risk_Indicators.Layouts.Layout_Neutral_DID_Service, self.did_ct:=0, self := left)));
	
	d_did2 := If(isFCRA, project(withNeutral, transform(did_slim, self := left)), d_did);
									
									
									
	risk_indicators.layout_output intoOutLayout(indata le, withNeutral ri) := transform
		self.seq := le.seq;
		self.did := ri.did;
		self.addrvalflag := IF(le.in_streetAddress<>'',iid_constants.addrvalflag(le.addr_status),'');
		self.dwelltype := iid_constants.dwelltype(le.addr_type);
		self.dl_number := le.dl_number;
		self.dl_state := le.dl_state;
		self.lat := le.lat;
		self.long := le.long;
		self.score := ri.score;
		
		self.firstscore := 255;
		self.lastscore := 255;
		self.hphonescore := 255;
		self.wphonescore := 255;
		self.socsscore := 255;
		self.dobscore := 255;
		self.addrscore := 255;
		self.cmpyscore := 255;
				
		self.BestSSN := ri.best_ssn;
		// for Riskview Prescreen or Lead Integrity, populate the input SSN with the best SSN when it isn't present on input
		self.ssn := if(append_best=2 and le.ssn='', ri.best_ssn, le.ssn); 
		
		self.bestState := ri.best_state;
		
		// check to see if we swapped names and if so, then swap them on the actual input as well
		self.fname := if(ri.swappedNames, ri.fname, le.fname);
		self.lname := if(ri.swappedNames, ri.lname, le.lname);
		self.swappedNames := ri.swappedNames; 
		
		self.errmsg := ri.errmsg;  // pass back the error message until we're outside the library code
		self := le;
		self := [];	// chronology address flags
	end;

	bestrecs := JOIN(withNeutral,indata,LEFT.seq=RIGHT.seq, intoOutLayout(RIGHT, LEFT), LOOKUP);	


	// join to table to get did count
	// **************************************************************************************************************
	// also TEMPORARILY until batch can pass ADLCount, I will say didcount=1 when populated and 0 when not !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	// **************************************************************************************************************
	risk_indicators.Layout_Output addDidCount(bestrecs le, d_did2 ri) := transform
		self.didcount := if(CapOneBatch, if(le.did<>0,1,0)/*(integer)le.in_country*/, ri.did_ct);		// didcount is being stored in the in_country field for cap one, however, it is not currently used, left here in case it ever needs to be
		self := le;
	end;
	wDidCount1 := join(bestrecs, d_did2, left.seq=right.seq, addDidCount(left,right), left outer, lookup);
	
	wDidCount := if(BSversion>2, wDidCount1, bestrecs);


	// add this here for cases where we found no did but can get one from the input social
	// this will produce two (same) transforms: for regular key and fcra-key
	MAC_getDID_transform (trans_name, key_ssntable) := MACRO
		risk_indicators.layout_output trans_name(risk_indicators.layout_output le, key_ssntable ri) := transform
		
				// determine which section of the table is permitted for use based on the data restriction mask
				header_version := map(DataRestriction[iid_constants.posEquifaxRestriction]=iid_constants.sFalse and
												DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse and
												((~isFCRA and DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse) or (isFCRA and DataRestriction[iid_constants.posExperianFCRARestriction]=iid_constants.sFalse)) => ri.combo,
												((~isFCRA and DataRestriction[iid_constants.posExperianRestriction]=iid_constants.sFalse) or (isFCRA and DataRestriction[iid_constants.posExperianFCRARestriction]=iid_constants.sFalse)) => ri.en,
												~isFCRA and DataRestriction[iid_constants.posTransUnionRestriction]=iid_constants.sFalse => ri.tn,
												ri.eq);  // default to the EQ version
												
			pre_history_date := header_version.header_first_seen <= le.historydate;
			self.did := if(header_version.bestCount=1 and pre_history_date, header_version.bestDID, le.did);
		
			self := le;
		end;
	ENDMACRO;
	MAC_getDID_transform (getDID, risk_indicators.key_ssn_table_v4_2);

	got_DIDbySSN_t1 := if(isFCRA, 
										wDidCount, //FCRA can't do SSN reverse lookup per Seth and project Juli
										join (wDidCount, risk_indicators.key_ssn_table_v4_2,
														left.ssn!='' and (left.did=0 OR left.score <= 1) and
														keyed(left.ssn=right.ssn), 
														getDID(left,right),left outer, ATMOST(keyed(left.ssn=right.ssn),10), keep(1))
								);
	
	//New for Emerging Identities - If still no DID, search wildcard SSN table by input SSN and name to see if we find one there

	wildcard_rec := record
		risk_indicators.Layout_Output;
		unsigned1	wildcard_name_score;
		unsigned6	wildcard_DID;
	end;
		
	//Only search records that don't have a DID and have an input SSN
	wildcard_dids := join(got_DIDbySSN_t1(ssn <> '' and DID=0), dx_header.key_wild_SSN(),
		keyed(right.s1=left.ssn[1]) and
		keyed(right.s2=left.ssn[2]) and
		keyed(right.s3=left.ssn[3]) and
		keyed(right.s4=left.ssn[4]) and
		keyed(right.s5=left.ssn[5]) and
		keyed(right.s6=left.ssn[6]) and
		keyed(right.s7=left.ssn[7]) and
		keyed(right.s8=left.ssn[8]) and
		keyed(right.s9=left.ssn[9]),
			transform(wildcard_rec, 
				lname_score := Risk_Indicators.LnameScore(left.lname,right.lname);
				fname_score := Risk_Indicators.FnameScore(left.fname,right.fname);
				wildcard_name_score := map(lname_score = 100 and fname_score = 100	=> 9, //assign index based on how well the name scores
																	 lname_score > 80 and fname_score = 100		=> 8,
																	 lname_score > 80 and fname_score > 80		=> 7,
																	 fname_score > 80													=> 6,
																	 lname_score > 80													=> 5,
																																							 0); //need at least a first or last name match
				self.wildcard_name_score := wildcard_name_score;
				self.wildcard_DID			   := right.DID;
				self 										 := left), 
		inner,
		atmost(riskwise.max_atmost), keep(100));

	wildcard_dids_best := dedup(sort(wildcard_dids(wildcard_name_score >= 5), seq, -wildcard_name_score), seq); //keep highest score

	ugRemoveVer2_wildcard := join(got_DIDbySSN_t1, wildcard_dids_best, 
													 left.seq = right.seq, 
													 transform(Risk_Indicators.Layout_Output, 
														 self.DID 	:= if(left.seq = right.seq and right.wildcard_DID <> 0, right.wildcard_DID, left.DID); 
														 self			:= left;),
											left outer,
											atmost(riskwise.max_atmost), keep(1));
		
	// Emerging Identities iteration 3 - if still no DID, search autokey.Key_SSN to get DIDs that are too new to be on the header

	SSN_qh := autokey.Key_SSN(header_quick.str_AutokeyName);

	ssn_qh_dids := JOIN(ugRemoveVer2_wildcard(ssn <> '' and DID=0), SSN_qh,
										keyed(right.s1=left.ssn[1]) and
										keyed(right.s2=left.ssn[2]) and
										keyed(right.s3=left.ssn[3]) and
										keyed(right.s4=left.ssn[4]) and
										keyed(right.s5=left.ssn[5]) and
										keyed(right.s6=left.ssn[6]) and
										keyed(right.s7=left.ssn[7]) and
										keyed(right.s8=left.ssn[8]) and
										keyed(right.s9=left.ssn[9]),
											transform(risk_indicators.Layout_Output, 
												lname_phn_value := metaphonelib.DMetaPhone1(left.lname)[1..6];
												lname_score 		:= Risk_Indicators.LnameScore(lname_phn_value,right.dph_lname);
												lname_match 		:= Risk_Indicators.iid_constants.g(lname_score);
												fname_score 		:= Risk_Indicators.FnameScore(left.fname,right.pfname);
												fname_match 		:= Risk_Indicators.iid_constants.g(fname_score);
												self.DID 				:= if(lname_match and fname_match, if(right.DID > Risk_Indicators.iid_constants.EmailFakeIds, Risk_Indicators.iid_constants.EmailFakeIds, right.DID), 0); 
												self						:= left), 
										inner,
										atmost(riskwise.max_atmost), keep(100));
										
	ssn_qh_dids_unique := dedup(sort(ssn_qh_dids(DID <> 0), seq, DID), seq, DID); //keep only the records that picked up a DID

	ssn_qh_dids_added := join(ugRemoveVer2_wildcard, ssn_qh_dids_unique, 
													 left.seq = right.seq, 
													 transform(Risk_Indicators.Layout_Output, 
														 self.DID 	:= if(left.seq = right.seq and right.DID <> 0, right.DID, left.DID); 
														 self			:= left;),
											left outer,
											atmost(riskwise.max_atmost), keep(1));	
											
	// Check the data against the Pull Id file.	
	// batch := false;
	// pass_use_le_val:=true;
	// b_use_le:=false;
	
	// ***** Do this line for iteration 2 *****
	// appended_DID := if(UseInputDidORRid, did_from_input, if(EnableEmergingID, ugRemoveVer2_wildcard, got_DIDbySSN_t1));
	
	// ***** Do this line for iteration 3 *****
	appended_DID := if(UseInputDidORRid, did_from_input, if(EnableEmergingID and ~isFCRA, ssn_qh_dids_added, got_DIDbySSN_t1));
	
	appType := Suppress.Constants.ApplicationTypes.DEFAULT;
	// search1_by_did := false;
	Suppress.MAC_Suppress(appended_DID,got_DIDbySSN_t1_pulled,appType,Suppress.Constants.LinkTypes.SSN,ssn, isFCRA := isFCRA);
	// search2_by_did := true;
	Suppress.MAC_Suppress(got_DIDbySSN_t1_pulled,got_DIDbySSN_t2,appType,Suppress.Constants.LinkTypes.DID,did, isFCRA := isFCRA);

	Risk_Indicators.layout_output CheckDIDorSSN(Risk_Indicators.layout_output le, Risk_Indicators.layout_output ri) := TRANSFORM
		SELF.did := ri.did;
		SELF.pullidflag := if(ri.did = 0 and le.did != 0, '1', '');
		SELF := le;
	END;
	got_DIDbySSN := GROUP(sort(join(appended_DID, got_DIDbySSN_t2, 
													left.seq = right.seq and left.did=right.did, 		
													CheckDIDorSSN(LEFT, RIGHT), LEFT OUTER, keep(1)),seq,did), seq,DID);	
	FCRAMin := got_DIDbySSN(score >= Risk_Indicators.iid_constants.min_FCRA_did_score);

	FCRAData := join(ungroup(got_DIDbySSN), FCRAMin,
		left.seq = right.seq,
		transform(layout_output, self.did := 0, self.score := 0, self := left, self := []),
		left only);
	//only return records >80 for FCRA, version >2 and no retaining did options set. Must keep a empty
	//record of did of 0 and score of 0 on row to be like we had it prior to change
	got_DIDbySSN2 := if(FCRAScoreCheck and 
		(UseInputDidORRid = false and RetainInputDID=false and CapOneBatch = false), 
		Group(Sort(FCRAData + FCRAMin, seq, did), seq, did), got_DIDbySSN);


with_optout_flag := join(got_DIDbySSN2, suppress.key_OptOutSrc(data_environment), 
													KEYED(LEFT.did = RIGHT.lexid),
														transform(Risk_Indicators.layout_output,
														self.skip_opt_out := RIGHT.lexid=0; // if the LexID isn't found at all, then we know we don't have to check on each record on every source in scope for CCPA
														self := left;
														self := [];
													),	
													LEFT OUTER, atmost(riskwise.max_atmost), keep(1));
													
	// output(resuTemp, named('resuTemp'));
	// output(all_dids, named('all_dids'));
	// output(BSversion, named('BSversion'));
	// output(FCRAMin, named('FCRAMin'));
	// output(FCRAData, named('FCRAData'));	
	// output(got_DIDbySSN, named('got_DIDbySSN'));
	// return got_DIDbySSN2;
	return with_optout_flag;
end;
