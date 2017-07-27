import BIPV2, doxie, UCCV2, doxie_raw, business_header, UCCv2_Services, AutoStandardI, doxie_cbrs;

it := AutoStandardI.InterfaceTranslator;

outrec := UCCv2_Services.layout_search_ids;

empty_bids := dataset([],BIPV2.IDlayouts.l_xlink_ids);

inner_params := interface(
	Get_ids.params,
	it.noDeepDive.params,
	it.filingnumber_value.params,
	it.filingjurisdiction_value.params,
	it.filingdatebegin_value.params,
	it.filingdateend_value.params,
	it.tmsid_value.params,
	it.rmsid_value.params,
	it.party_type.params)
end;

inner_id_search(inner_params in_mod,  
							  DATASET(BIPV2.IDlayouts.l_xlink_ids) linkIds = empty_bids, 
								STRING1 businessIdFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID) := function

	temp_incDeepDive := not it.noDeepDive.val(in_mod);
	temp_noDeepDive := it.noDeepDive.val(in_mod);
	temp_company_name_value := it.company_name_value.val(in_mod);
	temp_phone_value := it.phone_value.val(in_mod);
	temp_fein_value := it.fein_value.val(in_mod);
	temp_bdid_value := it.bdid_value.val(in_mod);
	temp_did_value := it.did_value.val(in_mod);
	temp_lname_value := it.lname_value.val(in_mod);
	temp_filingnumber_value := it.filingnumber_value.val(in_mod);
	temp_rmsid_value := it.rmsid_value.val(in_mod);
	temp_tmsid_value := it.tmsid_value.val(in_mod);
	temp_party_type := it.party_type.val(in_mod);

	boolean is_CompSearchL := temp_company_name_value <> '' or temp_phone_value <> '' or temp_fein_value > 0 or temp_bdid_value > 0;
	boolean is_ContSearchL := temp_lname_value <> '';
	boolean ShouldMatchBoth := is_CompSearchL and is_ContSearchL;

	// =========================================================
	//  Get tmsid/rmsid pairs associated with various inputs...
	// =========================================================

	// if any direct key lookup indexes are input then don't fail through autokey lookup process.
	NO_FAIL_THROUGH_AUTOKEY_LOOKUP := if (temp_FilingNumber_value <> '' OR temp_rmsid_value <> '' OR temp_tmsid_value <> '', TRUE,FALSE);



	// autokeys
	by_auto	:= UCCv2_services.Get_ids.val(in_mod,false,NO_FAIL_THROUGH_AUTOKEY_LOOKUP, temp_noDeepDive, is_CompSearchL,temp_Party_Type);


	// filing_number and orig_filing_number
	ds_fnum := dataset([{temp_FilingNumber_value}], UCCv2_Services.layout_filing_number);
	by_fnum := if(temp_FilingNumber_value <> '',
	UCCv2_Services.UCCRaw.get_rmsids_from_Filing_Number(ds_fnum));

	// rmsid
	ds_rmsid := dataset([{'',temp_rmsid_value}], UCCv2_Services.layout_rmsid);
	by_rmsid := if(temp_rmsid_value <> '',
	UCCv2_Services.UCCRaw.get_tmsids_from_rmsids(ds_rmsid));

	// tmsid
	by_tmsid := if(temp_tmsid_value <> '',
	dataset([{temp_tmsid_value,''}], UCCv2_Services.layout_rmsid));

	// ========================================
	//  assemble them into a single dataset...
	// ========================================

	// Here we have ids (tmsid, rmsid, IsDeepDive) records, some might be fetched by deepdive;
	// For deepdive only:
	// enforce matching by tmsids from 1) user input AND 2) (new feature) from payload;
	by_auto_deep := by_auto (isDeepDive);
	did_bdid_matched := join (by_auto_deep, by_auto_deep, left.tmsid = right.tmsid);
	by_auto_matched := by_auto(~isDeepDive) + did_bdid_matched;

	by_auto_adjusted := IF (ShouldMatchBoth, by_auto_matched, by_auto);

	did := (unsigned6)temp_did_value;
	dids := dataset([{did}], doxie.layout_references);
	bydid := UCCv2_Services.UCCRaw.get_tmsids_from_dids(dids,temp_Party_Type);

	bdid := temp_bdid_value;
	bdids := dataset([{bdid}], doxie_cbrs.layout_references);
	bybdid := IF(~EXISTS(linkids), UCCv2_Services.UCCRaw.get_tmsids_from_bdids(bdids,,temp_Party_Type));
	
	bylinkid := IF(EXISTS(linkids), UCCv2_Services.UCCRaw.get_tmsids_from_linkIds(linkIds, businessIdFetchLevel,,temp_Party_Type));

	//***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS
	msids := map(
  temp_tmsid_value <> '' => project(by_tmsid,transform(outrec,self.isDeepDive := FALSE, self := left)),
  temp_rmsid_value <> '' => project(by_rmsid,transform(outrec,self.isDeepDive := FALSE, self := left)),
  temp_FilingNumber_value <> '' => project(by_fnum,transform(outrec,self.isDeepDive := FALSE, self := left)),
  did > 0 => project(bydid,transform(outrec,self.isDeepDive := FALSE, self := left,self := [])),
  bdid > 0 AND ~EXISTS(linkids) => project(bybdid,transform(outrec,self.isDeepDive := FALSE, self := left,self := [])),
	EXISTS(linkIds) => project(bylinkid,transform(outrec,self.isDeepDive := FALSE, self := left, self := [])),
  by_auto_adjusted);


	// output(NO_fail_through_autokey_lookup, named('NO_FAIL_THROUGH_AUTOKEY_LOOKUP'), OVERWRITE);
	//output(by_auto, named('by_auto'), extend);
	return dedup(sort(msids, tmsid, rmsid, if(isDeepDive, 1, 0)), tmsid, rmsid);

end;

export UCCSearchService_ids(boolean includeDeepDive = true,
														DATASET(BIPV2.IDlayouts.l_xlink_ids) linkIds = empty_bids, 
														STRING1 linkIdFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID):= function

gm := AutoStandardI.GlobalModule();

temp_mod_one := module(project(gm,inner_params,opt))
	export nofail := true;
	export noDeepDive := ~includeDeepDive;
end;
temp_mod_two := module(project(gm,inner_params,opt))
	export nofail := true;
	export noDeepDive := ~includeDeepDive;
	export firstname := gm.entity2_firstname;
	export middlename := gm.entity2_middlename;
	export lastname := gm.entity2_lastname;
	export unparsedfullname := gm.entity2_unparsedfullname;
	export allownicknames := gm.entity2_allownicknames;
	export phoneticmatch := gm.entity2_phoneticmatch;
	export companyname := gm.entity2_companyname;
	export addr := gm.entity2_addr;
	export city := gm.entity2_city;
	export state := gm.entity2_state;
	export zip := gm.entity2_zip;
	export zipradius := gm.entity2_zipradius;
	export phone := gm.entity2_phone;
	export fein := gm.entity2_fein;
	export bdid := gm.entity2_bdid;
	export did := gm.entity2_did;
	export ssn := gm.entity2_ssn;
end;

party_one_results := inner_id_search(temp_mod_one, linkIds, linkIdFetchLevel);
party_two_results := inner_id_search(temp_mod_two, linkIds, linkIdFetchLevel);
// output(party_one_results,named('UCCParty1'));
// output(party_two_results,named('UCCParty2'));

two_party_search_results := join(
		party_one_results,
		party_two_results,
		left.tmsid = right.tmsid,
		transform(left),
			keep(1),
			limit(0));

selected_results := if(gm.TwoPartySearch,two_party_search_results,party_one_results);

// =============================================
//  then widen and filter it back down again...
// =============================================

// add fields from main key
key_main := UCCV2.Key_Rmsid_Main();
wideRec := record
	selected_results;
	key_main.filing_jurisdiction;
	key_main.orig_filing_date;
	key_main.filing_date;
	key_main.orig_filing_number;
	key_main.filing_number;
end;

tmsids_wide := join(
	selected_results, key_main,
	left.tmsid = right.tmsid,
	transform(wideRec, self:=left; self:=right),
	limit(UCCv2_Services.Constants.MAIN_JOIN_LIMIT,skip)
);
// output(tmsids_wide, named('tmsids_wide')); // DEBUG

temp_filingnumber_value := it.filingnumber_value.val(project(gm,it.filingnumber_value.params));
temp_filingjurisdiction_value := it.filingjurisdiction_value.val(project(gm,it.filingjurisdiction_value.params));
temp_filingdatebegin_value := it.filingdatebegin_value.val(project(gm,it.filingdatebegin_value.params));
temp_filingdateend_value := it.filingdateend_value.val(project(gm,it.filingdateend_value.params));

// filing_jurisdiction
tmsids_jur := if(
	temp_FilingJurisdiction_value <> '',
	tmsids_wide(filing_jurisdiction[1..length(trim((string3)temp_FilingJurisdiction_value))] = (string3)temp_FilingJurisdiction_value),
	tmsids_wide
);
// output(tmsids_jur, named('tmsids_jur')); // DEBUG

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

dateBegin := normDate(temp_FilingDateBegin_value, false);
dateEnd		:= normDate(temp_FilingDateEnd_value, true);
tmsids_date := if(
	temp_FilingDateBegin_value <> '' or temp_FilingDateEnd_value <> '',
	tmsids_jur(
	(
		filing_date >= dateBegin and
		filing_date <= dateEnd
		) or
		(
		orig_filing_date >= dateBegin and
		orig_filing_date <= dateEnd
		)
		),
		tmsids_jur
	);
// output(tmsids_date, named('tmsids_date')); // DEBUG

// filing_number and orig_filing_number filtering (mandatory when supplied)
boolean searchOrigFilingOnly := false : stored('SearchOrigFilingOnly');
tmsids_ofnum := if(
			temp_FilingNumber_value = '',
				tmsids_date,
				if(
					searchOrigFilingOnly,
					tmsids_date(orig_filing_number=temp_FilingNumber_value),
					tmsids_date(orig_filing_number=temp_FilingNumber_value or filing_number=temp_FilingNumber_value)
					)
				);

// narrow back and dedup
result_ids := dedup(sort(project(tmsids_ofnum, outrec), tmsid, rmsid, isDeepDive), tmsid, rmsid,isDeepDive);
// result_ids := dedup(project(tmsids_ofnum, outrec));

//output(result_ids, named('result_ids'), EXTEND); // DEBUG
// c_result_ids := count(result_ids);
//output(c_result_ids, named('c_count_result_ids'));
return result_ids;

end;