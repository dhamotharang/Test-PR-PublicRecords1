IMPORT _Control, LN_PropertyV2, suppress, fcra, LN_propertyV2_Services, STD;
onThor := _Control.Environment.OnThor;

l_sid		:= LN_PropertyV2_Services.layouts.search_fid;
l_fid		:= LN_PropertyV2_Services.layouts.fid;
l_out		:= LN_PropertyV2_Services.layouts.combined.tmp;

max_raw			:= LN_PropertyV2_Services.consts.max_raw;
max_parties	:= LN_PropertyV2_Services.consts.max_parties;

export dataset(l_out) fn_get_report_2(
  dataset(l_sid) in_fids,
	boolean skipPenaltyFilter = false,
	unsigned inMaxProperties = 0, // 0 = USE MaxResults and MaxResultsThisTime values
	boolean inTrimBySortBy = false,
	integer1 nonSS = suppress.constants.NonSubjectSuppression.doNothing,
	boolean isFCRA = false,
	LN_PropertyV2_Services.interfaces.Iinput_report in_mod,
	dataset(fcra.Layout_override_flag) ds_flags  // accept this from the calling function instead of searching flag file again
) := function
 

	// ---------- Main ----------
	// Apply FaresID-based restrictions
	fids1_orig := in_fids(ln_fares_id[1] not in in_mod.srcRestrict);	// blacklist FARES, Fidelity, or LnBranded as needed
	fids1 := dedup(sort(fids1_orig, ln_fares_id, search_did, isdeepdive), ln_fares_id, search_did, isdeepdive);  // added this dedup to handle cases where search_did exists more than once in the same batch of relatives
  
	parties_extraRaw := LN_PropertyV2_Services.fn_get_parties_raw(fids1,nonSS,isFCRA,ds_flags);	
	deeds_raw		:= LN_PropertyV2_Services.fn_get_deeds_raw_2(fids1,isFCRA,ds_flags,in_mod);
	assess_raw	:= LN_PropertyV2_Services.fn_get_assessments_raw_2(fids1,isFCRA,ds_flags,in_mod);
	
  parties := LN_PropertyV2_Services.fn_get_parties_2(parties_extraRaw,isFCRA,in_mod);
	deeds		:= LN_PropertyV2_Services.fn_get_deeds_2(deeds_raw,in_mod);
	assess	:= LN_PropertyV2_Services.fn_get_assessments_2(assess_raw,in_mod);
	
	num_recs	 := -1;
	num_deeds	 := -1;
	num_assess := -1;
	
	// assimilate deeds & assessments
	l_out fromDeed(deeds L) := transform
		self.penalt	      := 0;
		self							:= L;
		self.assessments	:= [];
		self.details			:= [];
		self.parties			:= [];
		self.matched_party:= [];
	end;
	
	l_out fromAssess(assess L) := transform
		self.penalt	      := 0;
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
	

/*  *************************************************************************************************************************

this section of code is very latent, especially in the THOR version of code when we're running the entire US population

working around this code to avoid all of that sorting in thor job.  
needed to put this code back in for the roxie query to work within bocashell for relatives to get same answer

// ***************************************************************************************************************************/

	base_grpd := GROUP( SORT( base, search_did, ln_fares_id, RECORD ), search_did );
	partied_grpd := GROUP( SORT( parties, search_did, ln_fares_id, RECORD ), search_did );
	
	partied := join(base_grpd, partied_grpd,
								left.search_did = right.search_did and left.ln_fares_id = right.ln_fares_id,
								addParties(left,right),	left outer,	atmost(max_raw), PARALLEL
							);



	// apply penalty threshhold
	partied_thresh := partied(penalt<=in_mod.pThresh or skipPenaltyFilter);
	// apply DID threshold
	partied_xadl2_thresh := partied_thresh((matched_party.xadl2_weight >= in_mod.xadl2_weight_threshold_value or matched_party.xadl2_weight = 0) 
																					or in_mod.xadl2_weight_threshold_value = 0 
																					or ~in_mod.DisplayMatchedParty_val);

	// If CurrentByVendor is set, only keep APNs if _all_ of their records have a perfect sec_range match in the property address
	sec_clean(string s) := STD.str.Filter(STD.str.ToUpperCase(s),'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	apns_bad := project(partied_xadl2_thresh(sec_clean(parties(party_type='P')[1].sec_range)<>sec_clean(in_mod.entity1.sec_range)), transform({partied_xadl2_thresh.apn},self.apn:=LN_PropertyV2.fn_strip_pnum(left.apn)));
	apns_set := set(table(apns_bad, {apn}, apn), apn);
	partied_out := if(in_mod.currentVend, partied_xadl2_thresh(LN_PropertyV2.fn_strip_pnum(apn) not in apns_set), partied_xadl2_thresh);
	// NOTE: This logic would break "Early Marshalling", so we have to disable it above.

	// If CurrentByVendor is set, limit to just a single APN (best match, favoring deeds, then most recent)
	curr_apn := nofold(LN_PropertyV2.fn_strip_pnum(
		sort(partied_out,penalt,-fid_type,-sortby_date,-apn,ln_fares_id)[1].apn,
		true));
	recs_cbv := partied_out(LN_PropertyV2.fn_strip_pnum(apn,true)=curr_apn);
	recs_limited := if(in_mod.currentVend, recs_cbv, partied_out);

	// final sort
	results_final :=
		sort(
			recs_limited,
			if(isDeepDive, 1, 0),
			LN_PropertyV2_Services.Raw_2(in_mod.lookupVal, in_mod.partyType, in_mod.faresID).fid_match(ln_fares_id),
			penalt,
			cPenalt,
			-sortby_date,
			ln_fares_id, // "record" isn't needed for determinism since fid is unique
			search_did
		);

	partied_new := join(base, parties,
								left.search_did = right.search_did and left.ln_fares_id = right.ln_fares_id,
								addParties(left,right),	left outer,	atmost(max_raw), PARALLEL
							);

// output(count(fids1_orig), named('fids1_orig_count'));
// output(count(fids1), named('fids1_count'));
// output(choosen(fids1, 100), named('fids1'));
// output(deeds_raw, named('deeds_raw'));
// output(assess_raw, named('assess_raw'));
// output(parties, named('parties'));
// output(deeds, named('deeds'));
// output(assess, named('assess'));
// output(partied_new, named('new_fn_get_report_2'));	
	
	#IF(onThor)
    return partied_new;
  #ELSE
    return results_final;
  #END
end;
	
