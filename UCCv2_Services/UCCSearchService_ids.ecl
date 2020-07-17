IMPORT BIPV2, doxie, UCCV2, doxie_raw, business_header, UCCv2_Services, AutoStandardI, doxie_cbrs;

it := AutoStandardI.InterfaceTranslator;

outrec := UCCv2_Services.layout_search_ids;

empty_bids := DATASET([],BIPV2.IDlayouts.l_xlink_ids);

inner_params := INTERFACE(
  Get_ids.params,
  it.noDeepDive.params,
  it.filingnumber_value.params,
  it.filingjurisdiction_value.params,
  it.filingdatebegin_value.params,
  it.filingdateend_value.params,
  it.tmsid_value.params,
  it.rmsid_value.params,
  it.party_type.params)
END;

inner_id_search(inner_params in_mod,
                DATASET(BIPV2.IDlayouts.l_xlink_ids) linkIds = empty_bids,
                STRING1 businessIdFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID) := FUNCTION

  temp_incDeepDive := NOT it.noDeepDive.val(in_mod);
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

  BOOLEAN is_CompSearchL := temp_company_name_value <> '' OR temp_phone_value <> '' OR temp_fein_value > 0 OR temp_bdid_value > 0;
  BOOLEAN is_ContSearchL := temp_lname_value <> '';
  BOOLEAN ShouldMatchBoth := is_CompSearchL AND is_ContSearchL;

  // =========================================================
  // Get tmsid/rmsid pairs associated with various inputs...
  // =========================================================

  // if any direct key lookup indexes are input then don't fail through autokey lookup process.
  NO_FAIL_THROUGH_AUTOKEY_LOOKUP := IF (temp_FilingNumber_value <> '' OR temp_rmsid_value <> '' OR temp_tmsid_value <> '', TRUE,FALSE);



  // autokeys
  by_auto := UCCv2_services.Get_ids.val(in_mod,FALSE,NO_FAIL_THROUGH_AUTOKEY_LOOKUP, temp_noDeepDive, is_CompSearchL,temp_Party_Type);


  // filing_number and orig_filing_number
  ds_fnum := DATASET([{temp_FilingNumber_value}], UCCv2_Services.layout_filing_number);
  by_fnum := IF(temp_FilingNumber_value <> '',
  UCCv2_Services.UCCRaw.get_rmsids_from_Filing_Number(ds_fnum));

  // rmsid
  ds_rmsid := DATASET([{'',temp_rmsid_value}], UCCv2_Services.layout_rmsid);
  by_rmsid := IF(temp_rmsid_value <> '',
  UCCv2_Services.UCCRaw.get_tmsids_from_rmsids(ds_rmsid));

  // tmsid
  by_tmsid := IF(temp_tmsid_value <> '',
  DATASET([{temp_tmsid_value,''}], UCCv2_Services.layout_rmsid));

  // ========================================
  // assemble them into a single dataset...
  // ========================================

  // Here we have ids (tmsid, rmsid, IsDeepDive) records, some might be fetched by deepdive;
  // For deepdive only:
  // enforce matching by tmsids from 1) user input AND 2) (new feature) from payload;
  by_auto_deep := by_auto (isDeepDive);
  did_bdid_matched := JOIN (by_auto_deep, by_auto_deep, LEFT.tmsid = RIGHT.tmsid);
  by_auto_matched := by_auto(~isDeepDive) + did_bdid_matched;

  by_auto_adjusted := IF (ShouldMatchBoth, by_auto_matched, by_auto);

  did := (UNSIGNED6)temp_did_value;
  dids := DATASET([{did}], doxie.layout_references);
  bydid := UCCv2_Services.UCCRaw.get_tmsids_from_dids(dids,temp_Party_Type);

  bdid := temp_bdid_value;
  bdids := DATASET([{bdid}], doxie_cbrs.layout_references);
  bybdid := IF(~EXISTS(linkids), UCCv2_Services.UCCRaw.get_tmsids_from_bdids(bdids,,temp_Party_Type));
  
  bylinkid := IF(EXISTS(linkids), UCCv2_Services.UCCRaw.get_tmsids_from_linkIds(linkIds, businessIdFetchLevel,,temp_Party_Type));

  //***** ADD THE FLAG SO WE CAN SHOW IT ON SEARCH RESULTS
  msids := MAP(
  temp_tmsid_value <> '' => PROJECT(by_tmsid,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT)),
  temp_rmsid_value <> '' => PROJECT(by_rmsid,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT)),
  temp_FilingNumber_value <> '' => PROJECT(by_fnum,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT)),
  did > 0 => PROJECT(bydid,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT,SELF := [])),
  bdid > 0 AND ~EXISTS(linkids) => PROJECT(bybdid,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT,SELF := [])),
  EXISTS(linkIds) => PROJECT(bylinkid,TRANSFORM(outrec,SELF.isDeepDive := FALSE, SELF := LEFT, SELF := [])),
  by_auto_adjusted);


  // output(NO_fail_through_autokey_lookup, named('NO_FAIL_THROUGH_AUTOKEY_LOOKUP'), OVERWRITE);
  //output(by_auto, named('by_auto'), extend);
  RETURN DEDUP(SORT(msids, tmsid, rmsid, IF(isDeepDive, 1, 0)), tmsid, rmsid);

END;

EXPORT UCCSearchService_ids(BOOLEAN includeDeepDive = TRUE,
                            DATASET(BIPV2.IDlayouts.l_xlink_ids) linkIds = empty_bids,
                            STRING1 linkIdFetchLevel = BIPV2.IDconstants.Fetch_Level_SELEID):= FUNCTION

gm := AutoStandardI.GlobalModule();

temp_mod_one := MODULE(PROJECT(gm,inner_params,opt))
  EXPORT nofail := TRUE;
  EXPORT noDeepDive := ~includeDeepDive;
END;
temp_mod_two := MODULE(PROJECT(gm,inner_params,opt))
  EXPORT nofail := TRUE;
  EXPORT noDeepDive := ~includeDeepDive;
  EXPORT firstname := gm.entity2_firstname;
  EXPORT middlename := gm.entity2_middlename;
  EXPORT lastname := gm.entity2_lastname;
  EXPORT unparsedfullname := gm.entity2_unparsedfullname;
  EXPORT allownicknames := gm.entity2_allownicknames;
  EXPORT phoneticmatch := gm.entity2_phoneticmatch;
  EXPORT companyname := gm.entity2_companyname;
  EXPORT addr := gm.entity2_addr;
  EXPORT city := gm.entity2_city;
  EXPORT state := gm.entity2_state;
  EXPORT zip := gm.entity2_zip;
  EXPORT zipradius := gm.entity2_zipradius;
  EXPORT phone := gm.entity2_phone;
  EXPORT fein := gm.entity2_fein;
  EXPORT bdid := gm.entity2_bdid;
  EXPORT did := gm.entity2_did;
  EXPORT ssn := gm.entity2_ssn;
END;

party_one_results := inner_id_search(temp_mod_one, linkIds, linkIdFetchLevel);
party_two_results := inner_id_search(temp_mod_two, linkIds, linkIdFetchLevel);
// output(party_one_results,named('UCCParty1'));
// output(party_two_results,named('UCCParty2'));

two_party_search_results := JOIN(
    party_one_results,
    party_two_results,
    LEFT.tmsid = RIGHT.tmsid,
    TRANSFORM(LEFT),
      KEEP(1),
      LIMIT(0));

selected_results := IF(gm.TwoPartySearch,two_party_search_results,party_one_results);

// =============================================
// then widen and filter it back down again...
// =============================================

// add fields from main key
key_main := UCCV2.Key_Rmsid_Main();
wideRec := RECORD
  selected_results;
  key_main.filing_jurisdiction;
  key_main.orig_filing_date;
  key_main.filing_date;
  key_main.orig_filing_number;
  key_main.filing_number;
END;

tmsids_wide := JOIN(
  selected_results, key_main,
  LEFT.tmsid = RIGHT.tmsid,
  TRANSFORM(wideRec, SELF:=LEFT; SELF:=RIGHT),
  LIMIT(UCCv2_Services.Constants.MAIN_JOIN_LIMIT,SKIP)
);
// output(tmsids_wide, named('tmsids_wide')); // DEBUG

temp_filingnumber_value := it.filingnumber_value.val(PROJECT(gm,it.filingnumber_value.params));
temp_filingjurisdiction_value := it.filingjurisdiction_value.val(PROJECT(gm,it.filingjurisdiction_value.params));
temp_filingdatebegin_value := it.filingdatebegin_value.val(PROJECT(gm,it.filingdatebegin_value.params));
temp_filingdateend_value := it.filingdateend_value.val(PROJECT(gm,it.filingdateend_value.params));

// filing_jurisdiction
tmsids_jur := IF(
  temp_FilingJurisdiction_value <> '',
  tmsids_wide(filing_jurisdiction[1..LENGTH(TRIM((STRING3)temp_FilingJurisdiction_value))] = (STRING3)temp_FilingJurisdiction_value),
  tmsids_wide
);
// output(tmsids_jur, named('tmsids_jur')); // DEBUG

// filing_date
STRING normDate(STRING in_date, BOOLEAN fillHigh) := FUNCTION
d := (UNSIGNED)in_date;
result := MAP(
  d BETWEEN 1000 AND 9999 => INTFORMAT(d,4,1) + IF(fillHigh, '9999', '0000'),
  d BETWEEN 100000 AND 999999 => INTFORMAT(d,6,1) + IF(fillHigh, '99', '00'),
  d BETWEEN 10000000 AND 99999999 => INTFORMAT(d,8,1),
  IF(fillHigh, '99999999', '00000000')
);
RETURN result;
END;

dateBegin := normDate(temp_FilingDateBegin_value, FALSE);
dateEnd := normDate(temp_FilingDateEnd_value, TRUE);
tmsids_date := IF(
  temp_FilingDateBegin_value <> '' OR temp_FilingDateEnd_value <> '',
  tmsids_jur(
  (
    filing_date >= dateBegin AND
    filing_date <= dateEnd
    ) OR
    (
    orig_filing_date >= dateBegin AND
    orig_filing_date <= dateEnd
    )
    ),
    tmsids_jur
  );
// output(tmsids_date, named('tmsids_date')); // DEBUG

// filing_number and orig_filing_number filtering (mandatory when supplied)
BOOLEAN searchOrigFilingOnly := FALSE : STORED('SearchOrigFilingOnly');
tmsids_ofnum := IF(
      temp_FilingNumber_value = '',
        tmsids_date,
        IF(
          searchOrigFilingOnly,
          tmsids_date(orig_filing_number=temp_FilingNumber_value),
          tmsids_date(orig_filing_number=temp_FilingNumber_value OR filing_number=temp_FilingNumber_value)
          )
        );

// narrow back and dedup
result_ids := DEDUP(SORT(PROJECT(tmsids_ofnum, outrec), tmsid, rmsid, isDeepDive), tmsid, rmsid,isDeepDive);
// result_ids := dedup(project(tmsids_ofnum, outrec));

//output(result_ids, named('result_ids'), EXTEND); // DEBUG
// c_result_ids := count(result_ids);
//output(c_result_ids, named('c_count_result_ids'));
RETURN result_ids;

END;
