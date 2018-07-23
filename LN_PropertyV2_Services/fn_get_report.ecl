IMPORT doxie, LN_PropertyV2, ut, Codes, suppress, fcra , FFD, LN_PropertyV2_Services;

l_sid		:= LN_PropertyV2_Services.layouts.search_fid;
l_fid		:= LN_PropertyV2_Services.layouts.fid;
l_out		:= LN_PropertyV2_Services.layouts.combined.tmp;

max_raw			:= LN_PropertyV2_Services.consts.max_raw;
max_parties	:= LN_PropertyV2_Services.consts.max_parties;

export dataset(l_out) fn_get_report(
  dataset(l_sid) in_fids,
	boolean skipPenaltyFilter = false,
	unsigned inMaxProperties = 0, // 0 = USE MaxResults and MaxResultsThisTime values
	boolean inTrimBySortBy = false,
	integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	boolean isFCRA = false,
	dataset (FFD.Layouts.PersonContextBatchSlim) slim_pc_recs = FFD.Constants.BlankPersonContextBatchSlim,
	integer8 inFFDOptionsMask = 0,
	dataset (FCRA.Layout_override_flag) ds_flags = FCRA.compliance.blank_flagfile
	) := function
																							
 isCNSMR := ut.IndustryClass.is_Knowx;
	doxie.MAC_Header_Field_Declare(isFCRA);
	// Apply FaresID-based restrictions
	fids1 := in_fids(ln_fares_id[1] not in LN_PropertyV2_Services.input.srcRestrict);	// blacklist FARES, Fidelity, or LnBranded as needed
	Suppress.MAC_Suppress(fids1,fids2a,application_type_value,,,Suppress.Constants.DocTypes.FaresID,ln_fares_id);
	
	// Now, if TRIM_BY_SORTBY is true, get only the MAX_TRIM_BY_SORTBY records needed to fulfill the request
	early_fid_rec := record
		recordof(fids2a);
		string8 sortby_date;
	end;
	
	deeds_raw_early		:= project(LN_PropertyV2_Services.fn_get_deeds_raw(fids2a,isFCRA,ds_flags,slim_pc_recs,inFFDOptionsMask,isCNSMR),early_fid_rec);
	assess_raw_early	:= project(LN_PropertyV2_Services.fn_get_assessments_raw(fids2a,isFCRA,ds_flags,slim_pc_recs,inFFDOptionsMask,isCNSMR),early_fid_rec);
	
	fids2 := if(inTrimBySortBy,project(topn(
		dedup(sort(deeds_raw_early + assess_raw_early,ln_fares_id,search_did,-sortby_date),ln_fares_id,search_did),
		consts.MAX_TRIM_BY_SORTBY,
		-sortby_date,ln_fares_id),recordof(fids2a)),fids2a);
	
	// Get raw parties based on fid suppression so far
	parties_extraRaw := LN_PropertyV2_Services.fn_get_parties_raw(fids2,nonSS,isFCRA,ds_flags,slim_pc_recs,inFFDOptionsMask,isCNSMR);
	
	// Pull records (fids) and parties based on DID/SSN
	Suppress.MAC_Suppress_Child.keyLinked(fids2,parties_extraRaw,fids2RemoveDID, application_type_value,
											Suppress.Constants.LinkTypes.DID,did,ln_fares_id,'',false);

	Suppress.MAC_Suppress_Child.keyLinked(fids2RemoveDID,parties_extraRaw,fids3, application_type_value,
											Suppress.Constants.LinkTypes.SSN,app_ssn,ln_fares_id,'',false);

	// retrieve raw results with minimal processing (just the JOINs)
	deeds_raw		:= LN_PropertyV2_Services.fn_get_deeds_raw(fids3,isFCRA,ds_flags,slim_pc_recs,inFFDOptionsMask,isCNSMR);
	assess_raw	:= LN_PropertyV2_Services.fn_get_assessments_raw(fids3,isFCRA,ds_flags,slim_pc_recs,inFFDOptionsMask,isCNSMR);
	
	aNames_raw	:= join(
		fids3, keys.addl_names(isFCRA),
		keyed(left.ln_fares_id=right.ln_fares_id),
		keep(consts.max_names * 4) // the x4 boost covers sellers+buyers, and the possibility of key growth
	);
	
	// Restrict to CurrentOnly or CurrentByVendor (if requested);
	currHash(string apn, string fid, string vflag='') := function
		return hash(LN_PropertyV2.fn_strip_pnum(apn,true), LN_PropertyV2.fn_fid_type(fid), fn_vendor_source_obscure(vflag));
	end;
	deeds_curOK := map(
		LN_PropertyV2_Services.input.currentVend => dedup(
				sort(deeds_raw(apnt_or_pin_number<>''), currHash(apnt_or_pin_number,ln_fares_id,vendor_source_flag), -sortby_date, ln_fares_id),
				currHash(apnt_or_pin_number,ln_fares_id,vendor_source_flag)
			),
		LN_PropertyV2_Services.input.currentOnly => dedup(
				sort(deeds_raw(apnt_or_pin_number<>''), currHash(apnt_or_pin_number,ln_fares_id), -sortby_date, vendor_source_flag, ln_fares_id),
				currHash(apnt_or_pin_number,ln_fares_id)
			),
		deeds_raw
	);
	assess_curOK := map(
		LN_PropertyV2_Services.input.currentVend => dedup(
				sort(assess_raw(apna_or_pin_number<>''), currHash(apna_or_pin_number,ln_fares_id,vendor_source_flag), -sortby_date, ln_fares_id),
				currHash(apna_or_pin_number,ln_fares_id,vendor_source_flag)
			),
		LN_PropertyV2_Services.input.currentOnly => dedup(
				sort(assess_raw(apna_or_pin_number<>''), currHash(apna_or_pin_number,ln_fares_id), -sortby_date, vendor_source_flag, ln_fares_id),
				currHash(apna_or_pin_number,ln_fares_id)
			),
		assess_raw
	);
	
	// We need to process parties early (to get their penalty)
  parties := LN_PropertyV2_Services.fn_get_parties(parties_extraRaw,isFCRA);
	

	// If we're marshalling early, pare down raw deeds & assessments to the page we care about
	// NOTE: When input.currentVend is true, we delay marshalling both because code below
	//       would break it and because it would offer no improvement in efficiency.
	forceDelay		:= LN_PropertyV2_Services.input.currentVend or LN_PropertyV2_Services.input.RobustnessScoreSorting;
	paged1				:= Marshall.page(deeds_curOK, assess_curOK, parties, skipPenaltyFilter, forceDelay);
	paged2				:= Marshall.page(deeds_curOK, assess_curOK, parties, skipPenaltyFilter, forceDelay, inMaxProperties, inMaxProperties);
	deeds_paged		:= if(inMaxProperties = 0,paged1.deeds,paged2.deeds);
	assess_paged	:= if(inMaxProperties = 0,paged1.assess,paged2.assess);
	num_recs			:= if(inMaxProperties = 0,paged1.numRecs,paged2.numRecs);
	num_deeds			:= if(inMaxProperties = 0,paged1.numdeeds,paged2.numdeeds);
	num_assess		:= if(inMaxProperties = 0,paged1.numassess,paged2.numassess);
	
	// --------------------------------------------------------------------------------
	// WARNING: You're not allowed to change sort order or pare down records after this
	//          point, unless that behavior is triggered by an option reflected in the
	//          "forceDelay" flag above.  Early marshalling works by making sort and
	//          selection decisions _before_ we get to the bulk of the processing.
	// --------------------------------------------------------------------------------
	
	// process the results
	deeds		:= fn_get_deeds(deeds_paged);
	// output(deeds,named('deeds2'));

assess	:= fn_get_assessments(assess_paged);

	// assimilate deeds & assessments
	l_out fromDeed(deeds L) := transform
		self.penalt				:= doxie.FN_Tra_Penalty_County(L.deeds[1].county_name); // assimilated below
		self							:= L;
		self.assessments	:= [];
		self.details			:= [];
		self.parties			:= [];
		self.matched_party:= [];
	end;
	l_out fromAssess(assess L) := transform
		self.penalt				:= doxie.FN_Tra_Penalty_County(L.assessments[1].county_name); // assimilated below
		self							:= L;
		self.deeds				:= [];
		self.details			:= [];
		self.parties			:= [];
		self.matched_party:= [];
	end;
	base_d	:= project(deeds,		fromDeed(left));
	base_a	:= project(assess,	fromAssess(left));
	base		:= base_d + base_a;
	
	l_plusAPN := record(l_out)
		string45 apn;
	end;
	
	// add in the party data (and its penalty)
	l_plusAPN addParties(base L, parties R) := transform
		county_pen					:= min(L.penalt,R.county_pen);
		self.penalt					:= R.penalt + county_pen;
		
		self.cPenalt				:= R.cPenalt;
		self.num_recs				:= num_recs;
		self.num_deeds			:= num_deeds;
		self.num_assess			:= num_assess;
		self.parties				:= R.parties;
		self.matched_party	:= if(L.isDeepDive=false, R.matched_party);
		self.apn						:= if(L.fid_type='D', L.deeds[1].apnt_or_pin_number, L.assessments[1].apna_or_pin_number);
		self := L;
	end;
	partied := join(base, parties,
								left.ln_fares_id = right.ln_fares_id and left.search_did = right.search_did,
								addParties(left,right),	left outer,	limit(max_raw)
							);

	// apply penalty threshhold
	partied_thresh := partied(penalt<=LN_PropertyV2_Services.input.pThresh or skipPenaltyFilter);
	// apply DID threshold
	partied_xadl2_thresh := partied_thresh((matched_party.xadl2_weight >= xadl2_weight_threshold_value or matched_party.xadl2_weight = 0) 
																					or xadl2_weight_threshold_value = 0 
																					or ~LN_PropertyV2_Services.input.DisplayMatchedParty_val);

	// If CurrentByVendor is set, only keep APNs if _all_ of their records have a perfect sec_range match in the property address
	sec_clean(string s) := StringLib.StringFilter(Stringlib.StringToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	apns_bad := project(partied_xadl2_thresh(sec_clean(parties(party_type='P')[1].sec_range)<>sec_clean(LN_PropertyV2_Services.input.sec_range)), transform({partied_xadl2_thresh.apn},self.apn:=LN_PropertyV2.fn_strip_pnum(left.apn)));
	apns_set := set(table(apns_bad, {apn}, apn), apn);
	partied_out := if(LN_PropertyV2_Services.input.currentVend, partied_xadl2_thresh(LN_PropertyV2.fn_strip_pnum(apn) not in apns_set), partied_xadl2_thresh);
	// NOTE: This logic would break "Early Marshalling", so we have to disable it above.

	// If CurrentByVendor is set, limit to just a single APN (best match, favoring deeds, then most recent)
	curr_apn := nofold(LN_PropertyV2.fn_strip_pnum(
		sort(partied_out,penalt,-fid_type,-sortby_date,-apn,ln_fares_id)[1].apn,
		true));
	recs_cbv := partied_out(LN_PropertyV2.fn_strip_pnum(apn,true)=curr_apn);
	recs_limited := if(LN_PropertyV2_Services.input.currentVend, recs_cbv, partied_out);
	// NOTE: This logic would break "Early Marshalling", so we have to disable it above.
	
	// add "details" (conditionally needed for high-value searches)
	details := if(LN_PropertyV2_Services.input.incDetails, fn_get_details(deeds,assess,parties));
	detailed := join(
		recs_limited, details,
		left.ln_fares_id = right.ln_fares_id and left.search_did = right.search_did,   
		transform( l_out, self.details:=right.details; self:=left ),
		left outer,
		limit(max_raw)
	);
	
	// fill in orig names
	/*
			ft='A' and pt='O' => 'Assessee',
			ft='A' and pt='C' => 'Care Of',
			ft='A' and pt='S' => 'Seller',
			
			ft='D' and pt='O' => 'Buyer',
			ft='D' and pt='S' => 'Seller',
			ft='D' and pt='C' => 'Care Of',
			ft='D' and pt='B' => 'Borrower',
	*/
	
	LN_PropertyV2_Services.layouts.parties.pparty fill_parties(LN_PropertyV2_Services.layouts.parties.pparty le, l_out main) := transform
		a := main.assessments[1];
		d := main.deeds[1];
		
		isOwnerA		:= main.fid_type='A' and le.party_type='O';
		isCareOfA		:= main.fid_type='A' and le.party_type='C';
		isSellerA		:= main.fid_type='A' and le.party_type='S';
		isPropertyA	:= main.fid_type='A' and le.party_type='P';
		
		isOwnerD		:= main.fid_type='D' and le.party_type='O';
		isBorrowerD	:= main.fid_type='D' and le.party_type='B';
		isCareOfD		:= main.fid_type='D' and le.party_type='C';
		isSellerD		:= main.fid_type='D' and le.party_type='S';
		isPropertyD	:= main.fid_type='D' and le.party_type='P';
		
		self.orig_addr := if (nonSS = suppress.constants.NonSubjectSuppression.doNothing,map(
			isOwnerA	or isCareOfA		=> a.mailing_full_street_address,
			isSellerA									=> '', // no seller address available in assessments
			isPropertyA								=> a.property_full_street_address,
			isOwnerD or isCareOfD or isBorrowerD => d.mailing_street,
			isSellerD									=> d.seller_mailing_full_street_address,
			isPropertyD								=> d.property_full_street_address,
			''
		),'');
		self.orig_unit := if (nonSS = suppress.constants.NonSubjectSuppression.doNothing,map(
			isOwnerA	or isCareOfA		=> a.mailing_unit_number,
			isSellerA									=> '',
			isPropertyA								=> a.property_unit_number,
			isOwnerD or isCareOfD or isBorrowerD => d.mailing_unit_number,
			isSellerD									=> d.seller_mailing_address_unit_number,
			isPropertyD								=> d.property_address_unit_number,
			''
		),'');
		self.orig_csz := if (nonSS = suppress.constants.NonSubjectSuppression.doNothing,map(
			isOwnerA	or isCareOfA		=> a.mailing_city_state_zip,
			isSellerA									=> '',
			isPropertyA								=> a.property_city_state_zip,
			isOwnerD or isCareOfD or isBorrowerD => d.mailing_csz,
			isSellerD									=> d.seller_mailing_address_citystatezip,
			isPropertyD								=> d.property_address_citystatezip,
			''
		),'');
		
		addl_names	:= choosen(sort(aNames_raw(ln_fares_id=main.ln_fares_id  and search_did = main.search_did, buyer_or_seller=le.party_type), (unsigned2)name_seq, record), consts.max_names);
		addl_offset	:= if(isOwnerA,2,0); // for some reason, name_seq starts at 1 for additional assessees rather than 3
		addl_fmt		:= project(addl_names, transform(
			LN_PropertyV2_Services.layouts.parties.orig,
			self.name_seq		:= (unsigned2)left.name_seq+addl_offset;
			self.orig_name	:= if(nonSS = suppress.constants.NonSubjectSuppression.doNothing,left.name,'');
			self.id_code		:= left.id_code;
			self.id_desc		:= Codes.KeyCodes(consts.deeds_codefile, 'BUYER1_ID_CODE', '', left.id_code);
			));
		all_names		:= map(
			isOwnerA	=> dataset([
												{1, a.assessee_name, a.assessee_name_type_code, a.assessee_name_type_desc},
												{2, a.second_assessee_name, a.second_assessee_name_type_code, a.second_assessee_name_type_desc}
											], LN_PropertyV2_Services.layouts.parties.orig),
			isCareOfA	=> dataset([
												{1, a.mailing_care_of_name, a.mail_care_of_name_type_code, a.mail_care_of_name_type_desc}
											], LN_PropertyV2_Services.layouts.parties.orig),
			isSellerA	and ~isFCRA => project(
											choosen(ln_propertyv2.key_addl_fares_tax_fid(keyed(ln_fares_id=main.ln_fares_id)),1),
											transform(LN_PropertyV2_Services.layouts.parties.orig, self.name_seq:=counter, self.orig_name:=left.fares_seller_name, self:=[])),
			isOwnerD	=> dataset([
												{1, d.name1, d.buyer1_id_code, d.buyer1_id_desc},
												{2, d.name2, d.buyer2_id_code, d.buyer2_id_desc}
											], LN_PropertyV2_Services.layouts.parties.orig),
			isBorrowerD	=> dataset([
												{1, d.name1, d.borrower1_id_code, d.borrower1_id_desc},
												{2, d.name2, d.borrower2_id_code, d.borrower2_id_desc}
											], LN_PropertyV2_Services.layouts.parties.orig),
			isSellerD	=> dataset([
												{1,d.seller1, d.seller1_id_code, d.seller1_id_desc},
												{2,d.seller2, d.seller2_id_code, d.seller2_id_desc}
											], LN_PropertyV2_Services.layouts.parties.orig),
			isCareOfD	=> dataset([{1, d.mailing_care_of, '', ''}], LN_PropertyV2_Services.layouts.parties.orig)
		) & addl_fmt;
		self.orig_names := if(nonSS = suppress.constants.NonSubjectSuppression.doNothing,
													choosen( sort(all_names(orig_name<>''), name_seq, record), consts.max_names));
		
		self := le;
	end;
	
	LN_PropertyV2_Services.layouts.parties.pparty create_blank(STRING1 src, STRING1 ptype) :=
	TRANSFORM
		SELF.party_type := ptype;
		SELF.party_type_name := party_type_named(src,ptype);
		SELF := [];
	END;
	
	l_out fill_names(l_out le) :=
	TRANSFORM
	
		// When names or addresses don't parse we can end up with missing parties.  In such cases, this code looks
		// to the unparsed data to see if we can at least come up with an orig_name for the major party types.
		missing_dsellers	:= le.fid_type='D' AND ~EXISTS(le.parties(party_type='S')) AND le.deeds[1].seller1<>'';
		missing_downers		:= le.fid_type='D' AND ~EXISTS(le.parties(party_type in ['B','O'])) AND le.deeds[1].name1<>'';
		missing_dproperty	:= le.fid_type='D' AND ~EXISTS(le.parties(party_type='P')) AND le.deeds[1].property_address_citystatezip<>'';
		missing_aproperty	:= le.fid_type='A' AND ~EXISTS(le.parties(party_type='P')) AND le.assessments[1].property_city_state_zip<>'';
		missing_aowners		:= le.fid_type='A' AND ~EXISTS(le.parties(party_type='O')) AND le.assessments[1].assessee_name<>'';
		
		all_parties := CHOOSEN(
					IF(missing_dproperty, DATASET([create_blank('D','P')]))&
						IF(missing_aproperty, DATASET([create_blank('A','P')]))&
						le.parties&
						IF(missing_dsellers, DATASET([create_blank('D','S')]))&
						IF(missing_downers, DATASET([create_blank('D',le.deeds[1].buyer_or_borrower_ind)]))&
						IF(missing_aowners, DATASET([create_blank('A','O')])), consts.max_parties);
		
		SELF.parties := PROJECT(all_parties, fill_parties(LEFT,le));	
		
		SELF := le;
	END;
	names_filled := PROJECT(detailed, fill_names(LEFT));

	// final sort
	results := Raw.final_sort(names_filled);
	
	//Re Sort results based on Scoring method
	results_final := if(LN_PropertyV2_Services.input.RobustnessScoreSorting,fn_robustness_scoring(results),results);

	// DEBUG...
			  //output(slim_pc_recs);
	      // output(deeds_raw_early, named('deeds_raw_early'));
	      //output(deeds_raw, named('deeds_raw'),EXTEND);
	      // output(assess_raw_early, named('assess_raw_early'));
	      //output(assess_raw, named('assess_raw'),EXTEND);
			  // output(parties_extraRaw, 		named('parties_extraRaw'));  // Has source_code in output- 
	      //output(parties, 		named('parties'),EXTEND);  // Has source_code in output- 
	     
			 
				// output(recs_limited, 		named('recs_limited'));  // Has source_code in output- 
	     
			
	                                                  // output for QA
	
	return results_final;

end;