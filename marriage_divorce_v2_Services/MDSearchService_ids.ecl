import doxie,AutoHeaderI,AutoStandardI;

export dataset(layouts.search_ids)  MDSearchService_ids (boolean isAssetRpt = false, unsigned6 ldid = 0, boolean isFCRA = false):= function

it 							:= AutoStandardI.InterfaceTranslator;
gm 							:= input.gm(isFCRA);
l_id						:= layouts.expanded_id;//layouts.l_id;
l_did						:= layouts.l_did;
l_fnum					:= layouts.l_fnum;
maxraw					:= 500;
max_deepDIDs 		:= 100;




inner_params2 := interface(autokey_ids.Input_params,
	it.noDeepDive.params,
	it.did_value.params,
	it.FilingNumber_value.params,
	it.state_value.params,
	it.county_value.params)
	export unsigned6 id;
end;

inner_id_search (inner_params2 in_mod, boolean isAssetRpt = false, boolean isFCRA = false) := function
		temp_noDeepDive := it.noDeepDive.val(in_mod);
		temp_incDeepDive := not it.noDeepDive.val(in_mod);
		temp_id  := in_mod.id;
		temp_did := (unsigned6)it.did_value.val(in_mod);
		temp_fnum := if(it.FilingNumber_value.val(in_mod) <> '',it.FilingNumber_value.val(in_mod),input.fnum);
    temp_fnum_unformatted := stringlib.stringfilter(stringlib.stringtouppercase(temp_fnum), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		temp_state := it.state_value.val(in_mod);
		temp_county := it.county_value.val(in_mod); 
		// =========================================================
		//  Get seqs associated with various inputs...
		// =========================================================

		// autokeys
		by_auto	:= autokey_ids.val(in_mod,false,,temp_noDeepDive);

		// deep DIDs
		tempmod2 := module(project(in_mod,AutoheaderI.LIBIN.FetchI_Hdr_Indv.full,opt))
				export forceLocal := true;
				export noFail := not isAssetRpt;
			end;
		deep_dids	:= project( limit( AutoHeaderI.LIBCALL_FetchI_Hdr_Indv.do(tempmod2), max_deepDIDs, skip), l_did);
		by_deep 	:= if(temp_incDeepDive, MDRaw.get_id_from_did(deep_dids));

		// lookup by id
		by_id := if(temp_id > 0, dataset([{temp_id}], l_id));

		// lookup by DID
		dids := dataset([{temp_did}], l_did);
		by_did := if(temp_did > 0, MDRaw.get_id_from_did(dids,isFCRA));

		// lookup by FilingNumber
		// The raw data has been stripped of any non-alphanumeric chars,so perform the query with the unformatted
		// filing_number.
		fnums := dataset([{temp_fnum_unformatted, temp_state, temp_county}], l_fnum);
		by_fnum := if(temp_fnum <> '', MDRaw.get_id_from_fnum(fnums));
		
		// output(by_fnum, named('by_fnum'),overwrite);
		
		// ========================================
		//  assemble them into a single dataset...
		// ========================================

		// ...adding the deep dive flag 
		addFlag(dataset(l_id) ds, boolean flag) := project(
			ds,
			transform(layouts.search_ids, self.isDeepDive := flag, self := left)
		);
		ids_1 := map(
			temp_id<>0			=> addFlag(by_id, false),
			temp_fnum<>''	=> addFlag(by_fnum, false),
			temp_did<>0		=> addFlag(by_did, false),
			by_auto + addFlag(by_deep, true)
		);
    ids := if (isFCRA, addFlag(by_did, false),ids_1);
		// ...and shifting deep-dive-only to the end
				
		return dedup(sort(ids, record_id, if(isDeepDive, 1, 0)), record_id);
end;


temp_mod_one := module(project(gm,inner_params2,opt))
	export id := input.id;
	export forceLocal := true;
	export noFail := not isAssetRpt;
	export did := if (ldid <> 0,(string)ldid, gm.did);
end;
temp_mod_two := module(project(gm,inner_params2,opt))

  shared boolean has_2nd_subject := gm.entity2_firstname<>'' or gm.entity2_lastname<>'';
	
	export id := input.id;
	export forceLocal := true;
	export noFail := not isAssetRpt;
	export firstname := gm.entity2_firstname;
	export middlename := gm.entity2_middlename;
	export lastname := gm.entity2_lastname;
	export unparsedfullname := gm.entity2_unparsedfullname;
	export allownicknames := gm.entity2_allownicknames;
	export phoneticmatch := gm.entity2_phoneticmatch;
	export companyname := gm.entity2_companyname;
	export addr := if(has_2nd_subject,
	                if(gm.entity2_state<>'',gm.entity2_addr,gm.addr),
								 '');
	export city := if(has_2nd_subject,
	                if(gm.entity2_state<>'',gm.entity2_city,gm.city),
								 '');
	//map entity1_state into entity2_state due to the fact that the search only accepts a single state input
	//also seems that state_value is applicable to the filing_state, not the address state - so we should be okay to overlay(?)
	//impact to deep dive should also be extremely minimal - you can't even enter a full address in the search to begin with
	//blanking the other address fields so as to not collide entity1_state with remaining entity2 address fields.
	export state := if(has_2nd_subject,
	                 if(gm.entity2_state<>'',gm.entity2_state,gm.state),
								  '');
	export zip   := if(has_2nd_subject,
	                 if(gm.entity2_state<>'',gm.entity2_zip,gm.zip),
								  '');
	export zipradius := if(has_2nd_subject,
	                     if(gm.entity2_state<>'',gm.entity2_zipradius,gm.zipradius),
								      0);
	export phone := gm.entity2_phone;
	export fein := gm.entity2_fein;
	export bdid := gm.entity2_bdid;
	export did := gm.entity2_did;
	export ssn := gm.entity2_ssn;
end;
party_one_results := inner_id_search(temp_mod_one,isAssetRpt,isFCRA);
party_two_results := inner_id_search(temp_mod_two,isAssetRpt);
// output(party_one_results,named('MARRDIVParty1'));
// output(party_two_results,named('MARRDIVParty2'));

two_party_search_results := join(
	party_one_results,
	party_two_results,
	left.record_id= right.record_id,
	transform(left),
		keep(1),
		limit(0));
		
boolean pair_was_found := exists(two_party_search_results);

//TwoPartySearch requires both parties to be part of the search criteria
//Therefore setting it to TRUE globally for M&D is not appropriate
selected_results := if(~isFCRA and (gm.TwoPartySearch or pair_was_found),two_party_search_results,party_one_results);

// =============================================
//  Widen and apply filters as necessary...
// =============================================

// add fields from main key
wideRec := record
	selected_results;
	typeof(keys.main().marriage_filing_dt) filing_dt;
	typeof(keys.main().marriage_dt) event_dt;
end;
ids_wide := join(
	selected_results, keys.main(isFCRA),
	left.record_id = right.record_id,
	transform(wideRec, self:=left; self.filing_dt:=if(right.filing_type='3',right.marriage_filing_dt,right.divorce_filing_dt),
	                               self.event_dt:=if(right.filing_type='3',right.marriage_dt,right.divorce_dt)),
	limit(maxraw), keep(1)
);

// filing_date
string normDate(string in_date, boolean fillHigh) := function
	d 			:= (unsigned)in_date;
	result	:= map(
		d between 1000 and 9999					=> intformat(d,4,1) + if(fillHigh, '9999', '0000'),
		d between 100000 and 999999			=> intformat(d,6,1) + if(fillHigh, '99', 	'00'),
		d between 10000000 and 99999999 => intformat(d,8,1),
		if(fillHigh, '99999999', '00000000')
	);
	return result;
end;
dateBegin := normDate(input.fdBegin, false);
dateEnd		:= normDate(input.fdEnd, true);
ids_date := if(
	input.fdBegin <> '' or input.fdEnd <> '',
	// preserve records that have no dates populated, or if either date falls within the range
	ids_wide((filing_dt='' and event_dt='') or 
					 ((filing_dt<>'' and (filing_dt >= dateBegin and filing_dt <= dateEnd)) or 
					 (event_dt<>'' and (event_dt >= dateBegin and event_dt <= dateEnd)))),
	ids_wide
);

// narrow back down
result_ids := project(ids_date, layouts.search_ids);

return result_ids;

end;