IMPORT SALT44;
// @param MultiRec - if set to true then multiple records may have the same Reference and a consolidated result will be produced
// @param ButNot - set of IDs that will NOT be considered as part of the result

EXPORT MEOW_Biz(DATASET(Process_Biz_Layouts.InputLayout) in, BOOLEAN MultiRec = FALSE,SET OF SALT44.UIDType ButNot=[]) := MODULE
  Process_Biz_Layouts.OutputLayout GetResults(Process_Biz_Layouts.InputLayout le) := TRANSFORM
  // Need to annotate wordbags with specificities
  SALT44.mac_wordbag_appendspecs_rx(le.cnp_name,Specificities(File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec)


  SALT44.mac_wordbag_appendspecs_rx(le.company_url,Specificities(File_BizHead).company_url_values_key,company_url,company_url_spec)

  // Need to calculate lengths for EDIT fields
  UNSIGNED1 company_fein_len := LENGTH(TRIM(le.company_fein));
  UNSIGNED1 prim_range_len := LENGTH(TRIM(le.prim_range));
  UNSIGNED1 prim_name_len := LENGTH(TRIM(le.prim_name));
  UNSIGNED1 sec_range_len := LENGTH(TRIM(le.sec_range));
  UNSIGNED1 city_len := LENGTH(TRIM(le.city));
  UNSIGNED1 fname_len := LENGTH(TRIM(le.fname));
  UNSIGNED1 mname_len := LENGTH(TRIM(le.mname));
  UNSIGNED1 lname_len := LENGTH(TRIM(le.lname));
  In_disableForce := le.disableForce;
  In_bGetAllScores := le.bGetAllScores;
  SELF.keys_tried := IF (Key_BizHead_L_CNPNAME_ZIP.CanSearch(le),1 << 1,0) + IF (Key_BizHead_L_CNPNAME_ST.CanSearch(le),1 << 2,0) + IF (Key_BizHead_L_CNPNAME.CanSearch(le),1 << 3,0) + IF (Key_BizHead_L_CNPNAME_FUZZY.CanSearch(le),1 << 4,0) + IF (Key_BizHead_L_ADDRESS1.CanSearch(le),1 << 5,0) + IF (Key_BizHead_L_ADDRESS2.CanSearch(le),1 << 6,0) + IF (Key_BizHead_L_ADDRESS3.CanSearch(le),1 << 7,0) + IF (Key_BizHead_L_PHONE.CanSearch(le),1 << 8,0) + IF (Key_BizHead_L_FEIN.CanSearch(le),1 << 9,0) + IF (Key_BizHead_L_URL.CanSearch(le),1 << 10,0) + IF (Key_BizHead_L_CONTACT_ZIP.CanSearch(le),1 << 11,0) + IF (Key_BizHead_L_CONTACT_ST.CanSearch(le),1 << 12,0) + IF (Key_BizHead_L_CONTACT_SSN.CanSearch(le),1 << 13,0) + IF (Key_BizHead_L_EMAIL.CanSearch(le),1 << 14,0) + IF (Key_BizHead_L_SIC.CanSearch(le),1 << 15,0) + IF (Key_BizHead_L_SOURCE.CanSearch(le),1 << 16,0) + IF (Key_BizHead_L_CONTACT_DID.CanSearch(le),1 << 17,0);
  fetchResults0 := ROLLUP(
    MERGE(
  SORTED(IF(BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(le),Key_BizHead_L_CNPNAME_ZIP.ScoredproxidFetch(param_cnp_name := cnp_name_spec,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_st := le.st,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF((~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CNPNAME_ST.CanSearch(le),Key_BizHead_L_CNPNAME_ST.ScoredproxidFetch(param_cnp_name := cnp_name_spec,param_st := le.st,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_zip := le.zip_cases,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid)
  ,SORTED(IF((~BizLinkFull.Key_BizHead_L_CNPNAME_ST.CanSearch(le) AND ~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CNPNAME.CanSearch(le),Key_BizHead_L_CNPNAME.ScoredproxidFetch(param_cnp_name := cnp_name_spec,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_zip := le.zip_cases,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.CanSearch(le),Key_BizHead_L_CNPNAME_FUZZY.ScoredproxidFetch(param_company_name_prefix := le.company_name_prefix,param_cnp_name := cnp_name_spec,param_st := le.st,param_zip := le.zip_cases,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_ADDRESS1.CanSearch(le),Key_BizHead_L_ADDRESS1.ScoredproxidFetch(param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_cnp_name := cnp_name_spec,param_zip := le.zip_cases,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_ADDRESS2.CanSearch(le),Key_BizHead_L_ADDRESS2.ScoredproxidFetch(param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_zip := le.zip_cases,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_cnp_name := cnp_name_spec,param_st := le.st,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_ADDRESS3.CanSearch(le),Key_BizHead_L_ADDRESS3.ScoredproxidFetch(param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_zip := le.zip_cases,param_cnp_name := cnp_name_spec,param_st := le.st,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_PHONE.CanSearch(le),Key_BizHead_L_PHONE.ScoredproxidFetch(param_company_phone_7 := le.company_phone_7,param_cnp_name := cnp_name_spec,param_company_phone_3 := le.company_phone_3,param_company_phone_3_ex := le.company_phone_3_ex,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_FEIN.CanSearch(le),Key_BizHead_L_FEIN.ScoredproxidFetch(param_company_fein := le.company_fein,param_company_fein_len := company_fein_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_URL.CanSearch(le),Key_BizHead_L_URL.ScoredproxidFetch(param_company_url := company_url_spec,param_st := le.st,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_CONTACT_ZIP.CanSearch(le),Key_BizHead_L_CONTACT_ZIP.ScoredproxidFetch(param_fname_preferred := le.fname_preferred,param_lname := le.lname,param_lname_len := lname_len,param_zip := le.zip_cases,param_mname := le.mname,param_mname_len := mname_len,param_cnp_name := cnp_name_spec,param_st := le.st,param_fname := le.fname,param_fname_len := fname_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF((~BizLinkFull.Key_BizHead_L_CONTACT_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CONTACT_ST.CanSearch(le),Key_BizHead_L_CONTACT_ST.ScoredproxidFetch(param_fname_preferred := le.fname_preferred,param_lname := le.lname,param_lname_len := lname_len,param_st := le.st,param_mname := le.mname,param_mname_len := mname_len,param_cnp_name := cnp_name_spec,param_fname := le.fname,param_fname_len := fname_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_CONTACT_SSN.CanSearch(le),Key_BizHead_L_CONTACT_SSN.ScoredproxidFetch(param_contact_ssn := le.contact_ssn,param_contact_email := le.contact_email,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_EMAIL.CanSearch(le),Key_BizHead_L_EMAIL.ScoredproxidFetch(param_contact_email := le.contact_email,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_SIC.CanSearch(le),Key_BizHead_L_SIC.ScoredproxidFetch(param_company_sic_code1 := le.company_sic_code1,param_zip := le.zip_cases,param_cnp_name := cnp_name_spec,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_SOURCE.CanSearch(le),Key_BizHead_L_SOURCE.ScoredproxidFetch(param_source_record_id := le.source_record_id,param_source := le.source,param_cnp_name := cnp_name_spec,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_zip := le.zip_cases,param_city := le.city,param_city_len := city_len,param_st := le.st,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid)
  ,SORTED(IF(BizLinkFull.Key_BizHead_L_CONTACT_DID.CanSearch(le),Key_BizHead_L_CONTACT_DID.ScoredproxidFetch(param_contact_did := le.contact_did,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),SORTED(ultid,orgid,seleid,proxid)) /* Merged */
    , RIGHT.proxid > 0  AND LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid, Process_Biz_Layouts.Combine_Scores(LEFT, RIGHT, In_disableForce))((proxid NOT IN ButNot) AND (SALT44.DebugMode OR ~ForceFailed OR ButNot <> [])); // Warning - is a fetch to keys etc
  fetchResults := TOPN(fetchResults0(proxid > 0),le.MaxIDs + 1,-Weight) & fetchResults0(proxid = 0);
    SELF.Results := PROJECT(CHOOSEN(Process_Biz_Layouts.AdjustKeysUsedAndFailed(fetchResults), le.MaxIDs), TRANSFORM(RECORDOF(LEFT), SELF.reference := le.UniqueId, SELF := LEFT));
    SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
    SELF.Results_seleid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results,-seleid),LEFT.seleid=RIGHT.seleid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(proxid=SELF.Results[1].proxid),-proxid));
    SELF.Results_orgid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_seleid,-orgid),LEFT.orgid=RIGHT.orgid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(seleid=SELF.Results[1].seleid),-seleid));
    SELF.Results_ultid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_orgid,-ultid),LEFT.ultid=RIGHT.ultid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(orgid=SELF.Results[1].orgid),-orgid));
    SELF.Results_powid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results,-powid),LEFT.powid=RIGHT.powid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(proxid=SELF.Results[1].proxid),-proxid));

    Process_Biz_Layouts.MAC_Add_ResolutionFlags()
    SELF := le;
  END;
  RR0 := PROJECT(in(Entered_rcid=0 AND Entered_proxid=0 AND Entered_seleid=0 AND Entered_orgid=0 AND Entered_ultid=0 AND Entered_powid=0),GetResults(left),PREFETCH(Config_BIP.MeowPrefetch,PARALLEL));
  Process_Biz_Layouts.OutputLayout rl(RR0 le,RR0 ri) := TRANSFORM
    In_disableForce := le.disableForce;
    SELF.keys_tried := le.keys_tried | ri.keys_tried; // If either tried it was tried
    mergedResults := TOPN(ROLLUP( SORT( le.Results+ri.Results, proxid )
    , RIGHT.proxid > 0  AND LEFT.proxid = RIGHT.proxid AND LEFT.seleid = RIGHT.seleid AND LEFT.orgid = RIGHT.orgid AND LEFT.ultid = RIGHT.ultid, Process_Biz_Layouts.Combine_Scores(LEFT, RIGHT, In_disableForce))((proxid NOT IN ButNot) AND (SALT44.DebugMode OR ~ForceFailed OR ButNot <> [])),le.MaxIds + 1,-Weight);
    SELF.Results := CHOOSEN(mergedResults, le.MaxIds);
    SELF.IsTruncated := ((le.IsTruncated OR ri.IsTruncated) AND COUNT(mergedResults) = le.MaxIds) OR COUNT(mergedResults) > le.MaxIds;
    SELF := le;
  END;
  RR1 := ROLLUP( SORT( RR0, UniqueId ), LEFT.UniqueId=RIGHT.UniqueId, rl(LEFT,RIGHT));
  RR20 := IF ( MultiRec, RR1, RR0 );
  Process_Biz_Layouts.OutputLayout AdjustScores(RR0 le) := TRANSFORM // Adjust scores for non-exact matches if needed
    SELF.Results := UNGROUP(Process_Biz_Layouts.AdjustScoresForNonExactMatches(le.Results));
    SELF.Results_seleid := UNGROUP(Process_Biz_Layouts.AdjustScoresForNonExactMatches(le.Results_seleid));
    SELF.Results_orgid := UNGROUP(Process_Biz_Layouts.AdjustScoresForNonExactMatches(le.Results_orgid));
    SELF.Results_ultid := UNGROUP(Process_Biz_Layouts.AdjustScoresForNonExactMatches(le.Results_ultid));
    SELF := le;
  END;
  RR2 := PROJECT(RR20,AdjustScores(LEFT));
  Process_Biz_Layouts.OutputLayout PruneByLead(RR0 le) := TRANSFORM // Prune out the weak results if good ones exist
    SELF.Results := le.Results(weight >= MAX(le.Results,weight)-le.LeadThreshold);
    SELF.Results_seleid := le.Results_seleid(weight >= MAX(le.Results_seleid,weight)-le.LeadThreshold);
    SELF.Results_orgid := le.Results_orgid(weight >= MAX(le.Results_orgid,weight)-le.LeadThreshold);
    SELF.Results_ultid := le.Results_ultid(weight >= MAX(le.Results_ultid,weight)-le.LeadThreshold);
    SELF.IsTruncated := le.IsTruncated AND COUNT(SELF.Results) = le.MaxIds;
    SELF := le;
  END;
  RR3 := RR2(LeadThreshold=0)+PROJECT(RR2(LeadThreshold<>0),PruneByLead(LEFT));
  SALT44.MAC_External_AddPcnt(RR3,Process_Biz_Layouts.LayoutScoredFetch,Results,Process_Biz_Layouts.OutputLayout,27,RR4);
  SALT44.MAC_External_AddPcnt(RR4,Process_Biz_Layouts.LayoutScoredFetch,Results_seleid,Process_Biz_Layouts.OutputLayout,27,RR5);
  SALT44.MAC_External_AddPcnt(RR5,Process_Biz_Layouts.LayoutScoredFetch,Results_orgid,Process_Biz_Layouts.OutputLayout,27,RR6);
  SALT44.MAC_External_AddPcnt(RR6,Process_Biz_Layouts.LayoutScoredFetch,Results_ultid,Process_Biz_Layouts.OutputLayout,27,RR7);
  SALT44.MAC_External_AddPcnt(RR7,Process_Biz_Layouts.LayoutScoredFetch,Results_powid,Process_Biz_Layouts.OutputLayout,27,RR8);
  EXPORT Raw_Results := IF(EXISTS(RR0),RR8);
  // Pass-thru any records which already had the proxid on them
    Process_Biz_Layouts.id_stream_layout ptt(in le) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.IsTruncated := FALSE;
    SELF.seleid := le.Entered_seleid;
    SELF.orgid := le.Entered_orgid;
    SELF.ultid := le.Entered_ultid;
    SELF.powid := le.Entered_powid;
    SELF.proxid := le.Entered_proxid;
    SELF.rcid := le.Entered_rcid;
    SELF.seleid_Weight := Config_BIP.MatchThreshold;
    SELF.seleid_Score := 100;
    SELF.orgid_Weight := Config_BIP.MatchThreshold;
    SELF.orgid_Score := 100;
    SELF.ultid_Weight := Config_BIP.MatchThreshold;
    SELF.ultid_Score := 100;
    SELF.Weight := Config_BIP.MatchThreshold; // Assume at least 'threshold' met
    SELF.Score := 100;
    SELF.powid_Weight := Config_BIP.MatchThreshold;
    SELF.powid_Score := 100;
  END;
  SHARED pass_thru0 := PROJECT(in(~(Entered_rcid=0 AND Entered_proxid=0 AND Entered_seleid=0 AND Entered_orgid=0 AND Entered_ultid=0 AND Entered_powid=0)),ptt(LEFT));
  SHARED pass_thru := Process_Biz_Layouts.id_stream_complete(pass_thru0);
// Transform to process 'real' results
  Process_Biz_Layouts.id_stream_layout n(Raw_Results le,UNSIGNED c) := TRANSFORM
    SELF.UniqueId := le.UniqueId;
    SELF.IsTruncated := le.IsTruncated;
    SELF.KeysUsed := le.Results[c].keys_used;
    SELF.KeysFailed := le.Results[c].keys_failed;
    SELF := le.Results[c];
    SELF.seleid_Weight := le.Results_seleid(seleid = le.Results[c].seleid)[1].weight;
    SELF.seleid_Score := le.Results_seleid(seleid = le.Results[c].seleid)[1].score;
    SELF.orgid_Weight := le.Results_orgid(orgid = le.Results[c].orgid)[1].weight;
    SELF.orgid_Score := le.Results_orgid(orgid = le.Results[c].orgid)[1].score;
    SELF.ultid_Weight := le.Results_ultid(ultid = le.Results[c].ultid)[1].weight;
    SELF.ultid_Score := le.Results_ultid(ultid = le.Results[c].ultid)[1].score;
    SELF.powid_Weight := le.Results_powid(powid = le.Results[c].powid)[1].weight;
    SELF.powid_Score := le.Results_powid(powid = le.Results[c].powid)[1].score;
  END;
  EXPORT Uid_Results0 := NORMALIZE(Raw_Results,COUNT(LEFT.Results),n(LEFT,COUNTER));
  EXPORT Uid_Results := Uid_Results0+pass_thru;
  EXPORT Raw_Data := Process_Biz_Layouts.Fetch_Stream_Expanded(Uid_Results);
  // This macro can be used to score any data with field names matching the header standard to the input criteria
  EXPORT ScoreData(RD,Inv) := FUNCTIONMACRO
    Layout_Matched_Data := RECORD
      RD;
      BOOLEAN FullMatch_Required; // If the input enquiry is insisting upon full record match
      BOOLEAN Has_Fullmatch; // This UID has a fully matching record
      BOOLEAN RecordsOnly; // If the input enquiry only wants matching records returned
      BOOLEAN Is_Fullmatch; // This record matches completely
      INTEGER2 Record_Score; // Score for this particular record
      INTEGER2 Match_parent_proxid;
      INTEGER2 Match_sele_proxid;
      INTEGER2 Match_org_proxid;
      INTEGER2 Match_ultimate_proxid;
      INTEGER2 Match_has_lgid;
      INTEGER2 Match_empid;
      INTEGER2 Match_source;
      INTEGER2 Match_source_record_id;
      INTEGER2 Match_source_docid;
      INTEGER2 Match_company_name;
      INTEGER2 Match_company_name_prefix;
      INTEGER2 Match_cnp_name;
      INTEGER2 Match_cnp_number;
      INTEGER2 Match_cnp_btype;
      INTEGER2 Match_cnp_lowv;
      INTEGER2 Match_company_phone;
      INTEGER2 Match_company_phone_3;
      INTEGER2 Match_company_phone_3_ex;
      INTEGER2 Match_company_phone_7;
      INTEGER2 Match_company_fein;
      INTEGER2 Match_company_sic_code1;
      INTEGER2 Match_active_duns_number;
      INTEGER2 Match_prim_range;
      INTEGER2 Match_prim_name;
      INTEGER2 Match_sec_range;
      INTEGER2 Match_city;
      INTEGER2 Match_city_clean;
      INTEGER2 Match_st;
      INTEGER2 Match_zip;
      INTEGER2 Match_company_url;
      INTEGER2 Match_isContact;
      INTEGER2 Match_contact_did;
      INTEGER2 Match_title;
      INTEGER2 Match_fname;
      INTEGER2 Match_fname_preferred;
      INTEGER2 Match_mname;
      INTEGER2 Match_lname;
      INTEGER2 Match_name_suffix;
      INTEGER2 Match_contact_ssn;
      INTEGER2 Match_contact_email;
      INTEGER2 Match_sele_flag;
      INTEGER2 Match_org_flag;
      INTEGER2 Match_ult_flag;
      INTEGER2 Match_fallback_value;
      INTEGER2 Match_CONTACTNAME;
      INTEGER2 Match_STREETADDRESS;
    END;
    IMPORT SALT44,BizLinkFull;
    Layout_Matched_Data score_fields(RD le,Inv ri) := TRANSFORM

    SELF.Match_parent_proxid := MAP ( ri.parent_proxid = (TYPEOF(ri.parent_proxid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.parent_proxid = (TYPEOF(ri.parent_proxid))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_parent_proxid(le.parent_proxid,ri.parent_proxid,FALSE)));

    SELF.Match_sele_proxid := MAP ( ri.sele_proxid = (TYPEOF(ri.sele_proxid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.sele_proxid = (TYPEOF(ri.sele_proxid))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_sele_proxid(le.sele_proxid,ri.sele_proxid,FALSE)));

    SELF.Match_org_proxid := MAP ( ri.org_proxid = (TYPEOF(ri.org_proxid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.org_proxid = (TYPEOF(ri.org_proxid))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_org_proxid(le.org_proxid,ri.org_proxid,FALSE)));

    SELF.Match_ultimate_proxid := MAP ( ri.ultimate_proxid = (TYPEOF(ri.ultimate_proxid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.ultimate_proxid = (TYPEOF(ri.ultimate_proxid))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_ultimate_proxid(le.ultimate_proxid,ri.ultimate_proxid,FALSE)));

    SELF.Match_has_lgid := MAP ( ri.has_lgid = (TYPEOF(ri.has_lgid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.has_lgid = (TYPEOF(ri.has_lgid))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.has_lgid = le.has_lgid => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_empid := MAP ( ri.empid = (TYPEOF(ri.empid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.empid = (TYPEOF(ri.empid))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.empid = le.empid => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_source := MAP ( ri.source = (TYPEOF(ri.source))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.source = (TYPEOF(ri.source))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_source(le.source,ri.source,FALSE)));

    SELF.Match_source_record_id := MAP ( ri.source_record_id = (TYPEOF(ri.source_record_id))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.source_record_id = (TYPEOF(ri.source_record_id))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_source_record_id(le.source_record_id,ri.source_record_id,FALSE)));

    SELF.Match_source_docid := MAP ( ri.source_docid = (TYPEOF(ri.source_docid))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.source_docid = (TYPEOF(ri.source_docid))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.source_docid = le.source_docid => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_company_name := MAP ( ri.company_name = (TYPEOF(ri.company_name))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_name = (TYPEOF(ri.company_name))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_name(le.company_name,ri.company_name,FALSE)));

    SELF.Match_company_name_prefix := MAP ( ri.company_name_prefix = (TYPEOF(ri.company_name_prefix))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_name_prefix = (TYPEOF(ri.company_name_prefix))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_name_prefix(le.company_name_prefix,ri.company_name_prefix,FALSE)));

    le_cnp_name := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)le.cnp_name);//For later scoring
    ri_cnp_name := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)ri.cnp_name);//For later scoring
    SELF.Match_cnp_name := MAP ( ri.cnp_name = (TYPEOF(ri.cnp_name))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.cnp_name = (TYPEOF(ri.cnp_name))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_cnp_name(le.cnp_name,ri.cnp_name,FALSE)));

    SELF.Match_cnp_number := MAP ( ri.cnp_number = (TYPEOF(ri.cnp_number))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.cnp_number = (TYPEOF(ri.cnp_number))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_cnp_number(le.cnp_number,ri.cnp_number,FALSE)));

    SELF.Match_cnp_btype := MAP ( ri.cnp_btype = (TYPEOF(ri.cnp_btype))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.cnp_btype = (TYPEOF(ri.cnp_btype))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_cnp_btype(le.cnp_btype,ri.cnp_btype,FALSE)));

    SELF.Match_cnp_lowv := MAP ( ri.cnp_lowv = (TYPEOF(ri.cnp_lowv))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.cnp_lowv = (TYPEOF(ri.cnp_lowv))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_cnp_lowv(le.cnp_lowv,ri.cnp_lowv,FALSE)));

    SELF.Match_company_phone := MAP ( ri.company_phone = (TYPEOF(ri.company_phone))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_phone = (TYPEOF(ri.company_phone))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.company_phone = le.company_phone => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_company_phone_3 := MAP ( ri.company_phone_3 = (TYPEOF(ri.company_phone_3))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_phone_3 = (TYPEOF(ri.company_phone_3))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_phone_3(le.company_phone_3,ri.company_phone_3,FALSE)));

    SELF.Match_company_phone_3_ex := MAP ( ri.company_phone_3_ex = (TYPEOF(ri.company_phone_3_ex))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_phone_3_ex = (TYPEOF(ri.company_phone_3_ex))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_phone_3_ex(le.company_phone_3_ex,ri.company_phone_3_ex,FALSE)));

    SELF.Match_company_phone_7 := MAP ( ri.company_phone_7 = (TYPEOF(ri.company_phone_7))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_phone_7 = (TYPEOF(ri.company_phone_7))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_phone_7(le.company_phone_7,ri.company_phone_7,FALSE)));

    SELF.Match_company_fein := MAP ( ri.company_fein = (TYPEOF(ri.company_fein))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_fein = (TYPEOF(ri.company_fein))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_fein(le.company_fein,ri.company_fein,0,0,FALSE)));

    SELF.Match_company_sic_code1 := MAP ( ri.company_sic_code1 = (TYPEOF(ri.company_sic_code1))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_sic_code1 = (TYPEOF(ri.company_sic_code1))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_sic_code1(le.company_sic_code1,ri.company_sic_code1,FALSE)));

    SELF.Match_active_duns_number := MAP ( ri.active_duns_number = (TYPEOF(ri.active_duns_number))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.active_duns_number = (TYPEOF(ri.active_duns_number))'' => SALT44.HeaderSearchMatchCode.BlankField,ri.active_duns_number = le.active_duns_number => SALT44.HeaderSearchMatchCode.Match,SALT44.HeaderSearchMatchCode.NoMatch);

    SELF.Match_prim_range := MAP ( ri.prim_range = (TYPEOF(ri.prim_range))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.prim_range = (TYPEOF(ri.prim_range))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_prim_range(le.prim_range,ri.prim_range,0,0,FALSE)));

    SELF.Match_prim_name := MAP ( ri.prim_name = (TYPEOF(ri.prim_name))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.prim_name = (TYPEOF(ri.prim_name))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_prim_name(le.prim_name,ri.prim_name,0,0,FALSE)));

    SELF.Match_sec_range := MAP ( ri.sec_range = (TYPEOF(ri.sec_range))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.sec_range = (TYPEOF(ri.sec_range))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_sec_range(le.sec_range,ri.sec_range,0,0,FALSE)));

    SELF.Match_city := MAP ( ri.city = (TYPEOF(ri.city))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.city = (TYPEOF(ri.city))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_city(le.city,ri.city,0,0,FALSE)));

    SELF.Match_city_clean := MAP ( ri.city_clean = (TYPEOF(ri.city_clean))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.city_clean = (TYPEOF(ri.city_clean))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_city_clean(le.city_clean,ri.city_clean,FALSE)));

    SELF.Match_st := MAP ( ri.st = (TYPEOF(ri.st))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.st = (TYPEOF(ri.st))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_st(le.st,ri.st,FALSE)));

    SELF.Match_zip := MAP ( ~EXISTS(ri.zip_cases) => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.zip = (TYPEOF(le.zip))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_zip_el(le.zip,SET(ri.zip_cases,zip),FALSE)));

    le_company_url := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)le.company_url);//For later scoring
    ri_company_url := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)ri.company_url);//For later scoring
    SELF.Match_company_url := MAP ( ri.company_url = (TYPEOF(ri.company_url))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.company_url = (TYPEOF(ri.company_url))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_company_url(le.company_url,ri.company_url,FALSE)));

    SELF.Match_isContact := MAP ( ri.isContact = (TYPEOF(ri.isContact))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.isContact = (TYPEOF(ri.isContact))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_isContact(le.isContact,ri.isContact,FALSE)));

    SELF.Match_contact_did := MAP ( ri.contact_did = (TYPEOF(ri.contact_did))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.contact_did = (TYPEOF(ri.contact_did))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_contact_did(le.contact_did,ri.contact_did,FALSE)));

    SELF.Match_title := MAP ( ri.title = (TYPEOF(ri.title))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.title = (TYPEOF(ri.title))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_title(le.title,ri.title,FALSE)));

    SELF.Match_fname := MAP ( ri.fname = (TYPEOF(ri.fname))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.fname = (TYPEOF(ri.fname))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_fname(le.fname,ri.fname,0,0,FALSE)));

    SELF.Match_fname_preferred := MAP ( ri.fname_preferred = (TYPEOF(ri.fname_preferred))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.fname_preferred = (TYPEOF(ri.fname_preferred))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_fname_preferred(le.fname_preferred,ri.fname_preferred,FALSE)));

    SELF.Match_mname := MAP ( ri.mname = (TYPEOF(ri.mname))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.mname = (TYPEOF(ri.mname))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_mname(le.mname,ri.mname,0,0,FALSE)));

    SELF.Match_lname := MAP ( ri.lname = (TYPEOF(ri.lname))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.lname = (TYPEOF(ri.lname))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_lname(le.lname,ri.lname,0,0,FALSE)));

    SELF.Match_name_suffix := MAP ( ri.name_suffix = (TYPEOF(ri.name_suffix))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.name_suffix = (TYPEOF(ri.name_suffix))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_name_suffix(le.name_suffix,ri.name_suffix,FALSE)));

    SELF.Match_contact_ssn := MAP ( ri.contact_ssn = (TYPEOF(ri.contact_ssn))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.contact_ssn = (TYPEOF(ri.contact_ssn))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_contact_ssn(le.contact_ssn,ri.contact_ssn,FALSE)));

    SELF.Match_contact_email := MAP ( ri.contact_email = (TYPEOF(ri.contact_email))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.contact_email = (TYPEOF(ri.contact_email))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_contact_email(le.contact_email,ri.contact_email,FALSE)));

    SELF.Match_sele_flag := MAP ( ri.sele_flag = (TYPEOF(ri.sele_flag))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.sele_flag = (TYPEOF(ri.sele_flag))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_sele_flag(le.sele_flag,ri.sele_flag,FALSE)));

    SELF.Match_org_flag := MAP ( ri.org_flag = (TYPEOF(ri.org_flag))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.org_flag = (TYPEOF(ri.org_flag))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_org_flag(le.org_flag,ri.org_flag,FALSE)));

    SELF.Match_ult_flag := MAP ( ri.ult_flag = (TYPEOF(ri.ult_flag))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.ult_flag = (TYPEOF(ri.ult_flag))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_ult_flag(le.ult_flag,ri.ult_flag,FALSE)));

    SELF.Match_fallback_value := MAP ( ri.fallback_value = (TYPEOF(ri.fallback_value))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le.fallback_value = (TYPEOF(ri.fallback_value))'' => SALT44.HeaderSearchMatchCode.BlankField,SALT44.MatchCode.GroupHeaderSearchCodes(BizLinkFull.match_methods(BizLinkFull.File_BizHead).match_fallback_value(le.fallback_value,ri.fallback_value,FALSE)));
    ri_CONTACTNAME := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)ri.CONTACTNAME);//For later scoring
    le_CONTACTNAME := SALT44.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT44.StrType)le.fname) + ' ' + TRIM((SALT44.StrType)le.mname) + ' ' + TRIM((SALT44.StrType)le.lname));//For later scoring
    SELF.Match_CONTACTNAME := MAP ( ri.CONTACTNAME = (typeof(ri.CONTACTNAME))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le_CONTACTNAME = (typeof(ri.CONTACTNAME))'' => SALT44.HeaderSearchMatchCode.BlankField, ri_CONTACTNAME = le_CONTACTNAME => SALT44.HeaderSearchMatchCode.Match, SALT44.HeaderSearchMatchCode.NoMatch);
    ri_STREETADDRESS := SALT44.Fn_WordBag_AppendSpecs_Fake((SALT44.StrType)ri.STREETADDRESS);//For later scoring
    le_STREETADDRESS := SALT44.Fn_WordBag_AppendSpecs_Fake(TRIM((SALT44.StrType)le.prim_range) + ' ' + TRIM((SALT44.StrType)le.prim_name) + ' ' + TRIM((SALT44.StrType)le.sec_range));//For later scoring
    SELF.Match_STREETADDRESS := MAP ( ri.STREETADDRESS = (typeof(ri.STREETADDRESS))'' => SALT44.HeaderSearchMatchCode.NoSearchCriteria, le_STREETADDRESS = (typeof(ri.STREETADDRESS))'' => SALT44.HeaderSearchMatchCode.BlankField, ri_STREETADDRESS = le_STREETADDRESS => SALT44.HeaderSearchMatchCode.Match, SALT44.HeaderSearchMatchCode.NoMatch);

      SELF.Record_Score := SELF.Match_parent_proxid + SELF.Match_sele_proxid + SELF.Match_org_proxid + SELF.Match_ultimate_proxid + SELF.Match_has_lgid + SELF.Match_empid + SELF.Match_source + SELF.Match_source_record_id + SELF.Match_source_docid + SELF.Match_company_name + SELF.Match_company_name_prefix + SELF.Match_cnp_name + SELF.Match_cnp_number + SELF.Match_cnp_btype + SELF.Match_cnp_lowv + SELF.Match_company_phone + SELF.Match_company_phone_3 + SELF.Match_company_phone_3_ex + SELF.Match_company_phone_7 + SELF.Match_company_fein + SELF.Match_company_sic_code1 + SELF.Match_active_duns_number + SELF.Match_prim_range + SELF.Match_prim_name + SELF.Match_sec_range + SELF.Match_city + SELF.Match_city_clean + SELF.Match_st + SELF.Match_zip + SELF.Match_company_url + SELF.Match_isContact + SELF.Match_contact_did + SELF.Match_title + SELF.Match_fname + SELF.Match_fname_preferred + SELF.Match_mname + SELF.Match_lname + SELF.Match_name_suffix + SELF.Match_contact_ssn + SELF.Match_contact_email + SELF.Match_sele_flag + SELF.Match_org_flag + SELF.Match_ult_flag + SELF.Match_fallback_value + SELF.Match_CONTACTNAME + SELF.Match_STREETADDRESS;
      SELF.Is_FullMatch := SELF.Match_parent_proxid>=0 AND SELF.Match_sele_proxid>=0 AND SELF.Match_org_proxid>=0 AND SELF.Match_ultimate_proxid>=0 AND SELF.Match_has_lgid>=0 AND SELF.Match_empid>=0 AND SELF.Match_source>=0 AND SELF.Match_source_record_id>=0 AND SELF.Match_source_docid>=0 AND SELF.Match_company_name>=0 AND SELF.Match_company_name_prefix>=0 AND SELF.Match_cnp_name>=0 AND SELF.Match_cnp_number>=0 AND SELF.Match_cnp_btype>=0 AND SELF.Match_cnp_lowv>=0 AND SELF.Match_company_phone>=0 AND SELF.Match_company_phone_3>=0 AND SELF.Match_company_phone_3_ex>=0 AND SELF.Match_company_phone_7>=0 AND SELF.Match_company_fein>=0 AND SELF.Match_company_sic_code1>=0 AND SELF.Match_active_duns_number>=0 AND SELF.Match_prim_range>=0 AND SELF.Match_prim_name>=0 AND SELF.Match_sec_range>=0 AND SELF.Match_city>=0 AND SELF.Match_city_clean>=0 AND SELF.Match_st>=0 AND SELF.Match_zip>=0 AND SELF.Match_company_url>=0 AND SELF.Match_isContact>=0 AND SELF.Match_contact_did>=0 AND SELF.Match_title>=0 AND SELF.Match_fname>=0 AND SELF.Match_fname_preferred>=0 AND SELF.Match_mname>=0 AND SELF.Match_lname>=0 AND SELF.Match_name_suffix>=0 AND SELF.Match_contact_ssn>=0 AND SELF.Match_contact_email>=0 AND SELF.Match_sele_flag>=0 AND SELF.Match_org_flag>=0 AND SELF.Match_ult_flag>=0 AND SELF.Match_fallback_value>=0 AND SELF.Match_CONTACTNAME>=0 AND SELF.Match_STREETADDRESS>=0;
      SELF.Has_FullMatch := SELF.Is_FullMatch; // Filled in later using iterate
      SELF.FullMatch_Required := ri.FullMatch;
      SELF.RecordsOnly := ri.MatchRecords;
      SELF := le;
    END;
    ScoredData := JOIN(RD,Inv,LEFT.UniqueId=RIGHT.UniqueId,score_fields(LEFT,RIGHT));
    Layout_Matched_Data prop_full(ScoredData le,ScoredData ri) := TRANSFORM
          SELF.Has_FullMatch := ri.Has_FullMatch OR le.Has_FullMatch AND le.proxid=ri.proxid AND le.UniqueId=ri.UniqueId;
      SELF := ri;
    END;
    RETURN ITERATE( SORT( ScoredData,UniqueId,-Has_FullMatch ),prop_full(LEFT,RIGHT) );
  ENDMACRO;


  i := ScoreData(Raw_Data,In);
  // Now narrow down to the required records - note this can be switched per UniqueId
  i1 := i(Has_FullMatch OR ~FullMatch_Required,~RecordsOnly OR Is_FullMatch OR ~FullMatch_Required AND Record_Score>0);
  W1 := IF ( i1.RecordsOnly,i1.Record_Score,i1.Weight );
  EXPORT Data_ := DEDUP(SORT(i1,UniqueId,-W1,proxid,-(Record_Score+Weight-W1)),WHOLE RECORD)(rcid>0 OR KeysFailed<>0); /*HACK20 KeysFailed added*/
  // Now create 'data bombs' suitable for a remote deep dive search
  // We might want to reduce the number of results 'cleverly' over time - for now slap it all in there
  Process_Biz_Layouts.InputLayout tr(Raw_Data le) := TRANSFORM
    SELF.Entered_rcid := 0;
    SELF.Entered_proxid := 0; // Blank out the specific IDs
    SELF.Entered_seleid := 0; // Blank out the specific IDs
    SELF.Entered_orgid := 0; // Blank out the specific IDs
    SELF.Entered_ultid := 0; // Blank out the specific IDs
    SELF.Entered_powid := 0; // Blank out the specific IDs
    SELF := le;
    SELF.LeadThreshold := 0;
    SELF.MaxIds := 50;
    SELF := [];
  END;
  // If there are any simple prop fields; they can be applied here
  DSAfter_cnp_btype := SALT44.MAC_Field_Prop_Do(Raw_Data,cnp_btype,proxid);


  DSAfter_company_fein := SALT44.MAC_Field_Prop_Do(DSAfter_cnp_btype,company_fein,proxid);


  DSAfter_company_sic_code1 := SALT44.MAC_Field_Prop_Do(DSAfter_company_fein,company_sic_code1,proxid);

  ds := PROJECT(DSAfter_company_sic_code1,tr(LEFT));
  EXPORT DataToSearch := DEDUP(ds,WHOLE RECORD,ALL);
  Process_Biz_Layouts.OutputLayout GetResultsSpecific(Process_Biz_Layouts.InputLayout le,STRING LinkPathName) := TRANSFORM
  // Need to annotate wordbags with specificities
  SALT44.mac_wordbag_appendspecs_rx(le.cnp_name,Specificities(File_BizHead).cnp_name_values_key,cnp_name,cnp_name_spec)


  SALT44.mac_wordbag_appendspecs_rx(le.company_url,Specificities(File_BizHead).company_url_values_key,company_url,company_url_spec)

  // Need to calculate lengths for EDIT fields
  UNSIGNED1 company_fein_len := LENGTH(TRIM(le.company_fein));
  UNSIGNED1 prim_range_len := LENGTH(TRIM(le.prim_range));
  UNSIGNED1 prim_name_len := LENGTH(TRIM(le.prim_name));
  UNSIGNED1 sec_range_len := LENGTH(TRIM(le.sec_range));
  UNSIGNED1 city_len := LENGTH(TRIM(le.city));
  UNSIGNED1 fname_len := LENGTH(TRIM(le.fname));
  UNSIGNED1 mname_len := LENGTH(TRIM(le.mname));
  UNSIGNED1 lname_len := LENGTH(TRIM(le.lname));
  In_disableForce := le.disableForce;
  In_bGetAllScores := le.bGetAllScores;
  SELF.keys_tried := MAP(
        LinkPathName = 'L_CNPNAME_ZIP' =>  + IF (Key_BizHead_L_CNPNAME_ZIP.CanSearch(le),1 << 1,0),
        LinkPathName = 'L_CNPNAME_ST' =>  + IF (Key_BizHead_L_CNPNAME_ST.CanSearch(le),1 << 2,0),
        LinkPathName = 'L_CNPNAME' =>  + IF (Key_BizHead_L_CNPNAME.CanSearch(le),1 << 3,0),
        LinkPathName = 'L_CNPNAME_FUZZY' =>  + IF (Key_BizHead_L_CNPNAME_FUZZY.CanSearch(le),1 << 4,0),
        LinkPathName = 'L_ADDRESS1' =>  + IF (Key_BizHead_L_ADDRESS1.CanSearch(le),1 << 5,0),
        LinkPathName = 'L_ADDRESS2' =>  + IF (Key_BizHead_L_ADDRESS2.CanSearch(le),1 << 6,0),
        LinkPathName = 'L_ADDRESS3' =>  + IF (Key_BizHead_L_ADDRESS3.CanSearch(le),1 << 7,0),
        LinkPathName = 'L_PHONE' =>  + IF (Key_BizHead_L_PHONE.CanSearch(le),1 << 8,0),
        LinkPathName = 'L_FEIN' =>  + IF (Key_BizHead_L_FEIN.CanSearch(le),1 << 9,0),
        LinkPathName = 'L_URL' =>  + IF (Key_BizHead_L_URL.CanSearch(le),1 << 10,0),
        LinkPathName = 'L_CONTACT_ZIP' =>  + IF (Key_BizHead_L_CONTACT_ZIP.CanSearch(le),1 << 11,0),
        LinkPathName = 'L_CONTACT_ST' =>  + IF (Key_BizHead_L_CONTACT_ST.CanSearch(le),1 << 12,0),
        LinkPathName = 'L_CONTACT_SSN' =>  + IF (Key_BizHead_L_CONTACT_SSN.CanSearch(le),1 << 13,0),
        LinkPathName = 'L_EMAIL' =>  + IF (Key_BizHead_L_EMAIL.CanSearch(le),1 << 14,0),
        LinkPathName = 'L_SIC' =>  + IF (Key_BizHead_L_SIC.CanSearch(le),1 << 15,0),
        LinkPathName = 'L_SOURCE' =>  + IF (Key_BizHead_L_SOURCE.CanSearch(le),1 << 16,0),
        LinkPathName = 'L_CONTACT_DID' =>  + IF (Key_BizHead_L_CONTACT_DID.CanSearch(le),1 << 17,0),0);

  fetchResults := MAP(
        LinkPathName = 'L_CNPNAME_ZIP' => IF(Key_BizHead_L_CNPNAME_ZIP.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(le),Key_BizHead_L_CNPNAME_ZIP.ScoredproxidFetch(param_cnp_name := cnp_name_spec,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_st := le.st,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_CNPNAME_ST' => IF(Key_BizHead_L_CNPNAME_ST.CanSearch(le),SORTED(IF((~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CNPNAME_ST.CanSearch(le),Key_BizHead_L_CNPNAME_ST.ScoredproxidFetch(param_cnp_name := cnp_name_spec,param_st := le.st,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_zip := le.zip_cases,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_CNPNAME' => IF(Key_BizHead_L_CNPNAME.CanSearch(le),SORTED(IF((~BizLinkFull.Key_BizHead_L_CNPNAME_ST.CanSearch(le) AND ~BizLinkFull.Key_BizHead_L_CNPNAME_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CNPNAME.CanSearch(le),Key_BizHead_L_CNPNAME.ScoredproxidFetch(param_cnp_name := cnp_name_spec,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_zip := le.zip_cases,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_CNPNAME_FUZZY' => IF(Key_BizHead_L_CNPNAME_FUZZY.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_CNPNAME_FUZZY.CanSearch(le),Key_BizHead_L_CNPNAME_FUZZY.ScoredproxidFetch(param_company_name_prefix := le.company_name_prefix,param_cnp_name := cnp_name_spec,param_st := le.st,param_zip := le.zip_cases,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_ADDRESS1' => IF(Key_BizHead_L_ADDRESS1.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_ADDRESS1.CanSearch(le),Key_BizHead_L_ADDRESS1.ScoredproxidFetch(param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_cnp_name := cnp_name_spec,param_zip := le.zip_cases,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_ADDRESS2' => IF(Key_BizHead_L_ADDRESS2.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_ADDRESS2.CanSearch(le),Key_BizHead_L_ADDRESS2.ScoredproxidFetch(param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_zip := le.zip_cases,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_cnp_name := cnp_name_spec,param_st := le.st,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_ADDRESS3' => IF(Key_BizHead_L_ADDRESS3.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_ADDRESS3.CanSearch(le),Key_BizHead_L_ADDRESS3.ScoredproxidFetch(param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_zip := le.zip_cases,param_cnp_name := cnp_name_spec,param_st := le.st,param_city := le.city,param_city_len := city_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_PHONE' => IF(Key_BizHead_L_PHONE.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_PHONE.CanSearch(le),Key_BizHead_L_PHONE.ScoredproxidFetch(param_company_phone_7 := le.company_phone_7,param_cnp_name := cnp_name_spec,param_company_phone_3 := le.company_phone_3,param_company_phone_3_ex := le.company_phone_3_ex,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_FEIN' => IF(Key_BizHead_L_FEIN.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_FEIN.CanSearch(le),Key_BizHead_L_FEIN.ScoredproxidFetch(param_company_fein := le.company_fein,param_company_fein_len := company_fein_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_URL' => IF(Key_BizHead_L_URL.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_URL.CanSearch(le),Key_BizHead_L_URL.ScoredproxidFetch(param_company_url := company_url_spec,param_st := le.st,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_CONTACT_ZIP' => IF(Key_BizHead_L_CONTACT_ZIP.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_CONTACT_ZIP.CanSearch(le),Key_BizHead_L_CONTACT_ZIP.ScoredproxidFetch(param_fname_preferred := le.fname_preferred,param_lname := le.lname,param_lname_len := lname_len,param_zip := le.zip_cases,param_mname := le.mname,param_mname_len := mname_len,param_cnp_name := cnp_name_spec,param_st := le.st,param_fname := le.fname,param_fname_len := fname_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_CONTACT_ST' => IF(Key_BizHead_L_CONTACT_ST.CanSearch(le),SORTED(IF((~BizLinkFull.Key_BizHead_L_CONTACT_ZIP.CanSearch(le)),IF(BizLinkFull.Key_BizHead_L_CONTACT_ST.CanSearch(le),Key_BizHead_L_CONTACT_ST.ScoredproxidFetch(param_fname_preferred := le.fname_preferred,param_lname := le.lname,param_lname_len := lname_len,param_st := le.st,param_mname := le.mname,param_mname_len := mname_len,param_cnp_name := cnp_name_spec,param_fname := le.fname,param_fname_len := fname_len,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce))),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_CONTACT_SSN' => IF(Key_BizHead_L_CONTACT_SSN.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_CONTACT_SSN.CanSearch(le),Key_BizHead_L_CONTACT_SSN.ScoredproxidFetch(param_contact_ssn := le.contact_ssn,param_contact_email := le.contact_email,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_EMAIL' => IF(Key_BizHead_L_EMAIL.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_EMAIL.CanSearch(le),Key_BizHead_L_EMAIL.ScoredproxidFetch(param_contact_email := le.contact_email,param_company_sic_code1 := le.company_sic_code1,param_cnp_name := cnp_name_spec,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_zip := le.zip_cases,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_city := le.city,param_city_len := city_len,param_st := le.st,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_SIC' => IF(Key_BizHead_L_SIC.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_SIC.CanSearch(le),Key_BizHead_L_SIC.ScoredproxidFetch(param_company_sic_code1 := le.company_sic_code1,param_zip := le.zip_cases,param_cnp_name := cnp_name_spec,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_SOURCE' => IF(Key_BizHead_L_SOURCE.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_SOURCE.CanSearch(le),Key_BizHead_L_SOURCE.ScoredproxidFetch(param_source_record_id := le.source_record_id,param_source := le.source,param_cnp_name := cnp_name_spec,param_prim_name := le.prim_name,param_prim_name_len := prim_name_len,param_zip := le.zip_cases,param_city := le.city,param_city_len := city_len,param_st := le.st,param_company_sic_code1 := le.company_sic_code1,param_cnp_number := le.cnp_number,param_cnp_btype := le.cnp_btype,param_cnp_lowv := le.cnp_lowv,param_prim_range := le.prim_range,param_prim_range_len := prim_range_len,param_sec_range := le.sec_range,param_sec_range_len := sec_range_len,param_parent_proxid := le.parent_proxid,param_sele_proxid := le.sele_proxid,param_org_proxid := le.org_proxid,param_ultimate_proxid := le.ultimate_proxid,param_sele_flag := le.sele_flag,param_org_flag := le.org_flag,param_ult_flag := le.ult_flag,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),
        LinkPathName = 'L_CONTACT_DID' => IF(Key_BizHead_L_CONTACT_DID.CanSearch(le),SORTED(IF(BizLinkFull.Key_BizHead_L_CONTACT_DID.CanSearch(le),Key_BizHead_L_CONTACT_DID.ScoredproxidFetch(param_contact_did := le.contact_did,param_fallback_value := le.fallback_value,param_efr_bitmap := (UNSIGNED4)le.efr_bitmap,param_disableForce := In_disableForce)),ultid,orgid,seleid,proxid),DATASET([],Process_Biz_Layouts.LayoutScoredFetch)),DATASET([],Process_Biz_Layouts.LayoutScoredFetch) );
  SELF.Results := PROJECT(CHOOSEN(fetchResults, le.MaxIDs), TRANSFORM(RECORDOF(LEFT), SELF.reference := le.UniqueId, SELF := LEFT));
  SELF.IsTruncated := COUNT(fetchResults) > le.MaxIDs;
  SELF.Results_seleid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results,-seleid),LEFT.seleid=RIGHT.seleid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(proxid=SELF.Results[1].proxid),-proxid));
  SELF.Results_orgid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_seleid,-orgid),LEFT.orgid=RIGHT.orgid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(seleid=SELF.Results[1].seleid),-seleid));
  SELF.Results_ultid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results_orgid,-ultid),LEFT.ultid=RIGHT.ultid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(orgid=SELF.Results[1].orgid),-orgid));
  SELF.Results_powid := IF(In_bGetAllScores,SORT( ROLLUP( SORT( SELF.Results,-powid),LEFT.powid=RIGHT.powid,Process_Biz_Layouts.Combine_Scores(LEFT,RIGHT, In_disableForce)),-Weight,-(proxid=SELF.Results[1].proxid),-proxid));

  Process_Biz_Layouts.MAC_Add_ResolutionFlags()
  SELF := le;
  END;
    EXPORT DirectproxidFetch(STRING LpName):= PROJECT(in(Entered_rcid=0 AND Entered_proxid=0 AND Entered_seleid=0 AND Entered_orgid=0 AND Entered_ultid=0 AND Entered_powid=0),GetResultsSpecific(left,LpName),PREFETCH(Config_BIP.MeowPrefetch,PARALLEL));
END;
