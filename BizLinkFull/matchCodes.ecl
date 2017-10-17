EXPORT matchCodes := module
    EXPORT onlineMatchLayout := record      
      INTEGER2 Match_parent_proxid;
      INTEGER2 Match_sele_proxid;
      INTEGER2 Match_org_proxid;
      INTEGER2 Match_ultimate_proxid;
      INTEGER2 Match_has_lgid;
      INTEGER2 Match_empid;
      INTEGER2 Match_source;
      INTEGER2 Match_source_record_id;
      INTEGER2 Match_source_docid;
      INTEGER2 Match_company_name_prefix;
      INTEGER2 Match_cnp_name;
      INTEGER2 Match_cnp_number;
      INTEGER2 Match_cnp_btype;
      INTEGER2 Match_cnp_lowv;
      INTEGER2 Match_company_phone;
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
    end;
    
    EXPORT STRING online_MatchCode(onlineMatchLayout rec, BizLinkFull.lBatchInput dsInput) := 
      // IF (rec.Match_parent_proxid = 2, 'PARENT_PROXID,', '') +
      // IF (rec.Match_sele_proxid = 2, 'SELE_PROXID,', '') +
      // IF (rec.Match_org_proxid = 2, 'ORG_PROXID,', '') +
      // IF (rec.Match_ultimate_proxid = 2, 'ULTIMATE_PROXID,', '') +
      // IF (rec.Match_has_lgid = 2, 'HAS_LGID,', '') +
      // IF (rec.Match_empid = 2, 'EMPID,', '') +
      IF (rec.Match_source = 2 and dsInput.source <> '', 'SOURCE,', '') +
      IF (rec.Match_source_record_id = 2 and dsInput.source_record_id <> 0, 'SOURCE_RECORD_ID,', '') +
      // IF (rec.Match_source_docid = 2, 'SOURCE_DOCID,', '') +
      // IF (rec.Match_company_name_prefix = 2, 'COMPANY_NAME_PREFIX,', '') + 
      IF (rec.Match_cnp_name = 2 and dsInput.company_name <> '', 'CNP_NAME,', '') + 
      // IF (rec.Match_cnp_number = 2, 'CNP_NUMBER,', '') + 
      // IF (rec.Match_cnp_btype = 2, 'CNP_BTYPE,', '') + 
      // IF (rec.Match_cnp_lowv = 2, 'CNP_LOWV,', '') + 
      IF (rec.Match_company_phone = 2 and dsInput.company_phone <> '', 'PHONE,', '') +       
      IF (rec.Match_company_fein = 2 and dsInput.company_fein <> '', 'FEIN,', '') + 
      IF (rec.Match_company_sic_code1 = 2 and dsInput.company_sic_code1 <> '', 'COMPANY_SIC_CODE,', '') + 
      // IF (rec.Match_active_duns_number = 2, 'ACTIVE_DUNS_NUMBER,', '') + 
      IF (rec.Match_prim_range = 2 and dsInput.prim_range <> '', 'PRIM_RANGE,', '') + 
      IF (rec.Match_prim_name = 2 and dsInput.prim_name <> '' , 'PRIM_NAME,', '') + 
      IF (rec.Match_sec_range = 2 and dsInput.sec_range <> '', 'SEC_RANGE,', '') + 
      IF ((rec.Match_city = 2 or rec.Match_city_clean = 2) and dsInput.city <> '' , 'CITY,', '') + 
      IF (rec.Match_st = 2 and dsInput.st <> '', 'STATE,', '') + 
      IF (rec.Match_zip = 2 and dsInput.zip <> '', 'ZIP,', '') + 
      IF (rec.Match_company_url = 2 and dsInput.company_url <> '', 'URL,', '') + 
      // IF (rec.Match_contact_did = 2, 'CONTACT_DID,', '') + 
      // IF (rec.Match_title = 2, 'TITLE,', '') + 
      IF (rec.Match_fname = 2 and dsInput.fname <> '', 'FIRSTNAME,', '') + 
      // IF (rec.Match_fname_preferred = 2, 'NICKNAME,', '') + 
      IF (rec.Match_mname = 2 and dsInput.mname <> '', 'MIDDLENAME,', '') + 
      IF (rec.Match_lname = 2 and dsInput.lname <> '', 'LASTNAME,', '') + 
      // IF (rec.Match_name_suffix = 2, 'NAME_SUFFIX,', '') + 
      IF (rec.Match_contact_ssn = 2 and dsInput.contact_ssn <> '', 'SSN,', '') + 
      IF (rec.Match_contact_email = 2 and dsInput.contact_email <> '', 'EMAIL,', '') ;
      // IF (rec.Match_sele_flag = 2, 'SELE_FLAG,', '') + 
      // IF (rec.Match_sele_flag = 2, 'SELE_FLAG,', '') + 
      // IF (rec.Match_org_flag = 2, 'ORG_FLAG,', '') + 
      // IF (rec.Match_ult_flag = 2, 'ULT_FLAG,', '') ;   
    
    
    SHARED no_match := [0,1,99];
    EXPORT batch_MatchCode(BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch rec) := 
        IF(rec.parent_proxid_match_code not in no_match , 'PARENT_PROXID,', '') + 
        IF (rec.sele_proxid_match_code not in no_match, 'SELE_PROXID,', '') +
      IF (rec.org_proxid_match_code not in no_match, 'ORG_PROXID,', '') +
      IF (rec.ultimate_proxid_match_code not in no_match, 'ULTIMATE_PROXID,', '') +
      IF (rec.has_lgid_match_code not in no_match, 'HAS_LGID,', '') +
      IF (rec.empid_match_code not in no_match, 'EMPID,', '') +
      IF (rec.source_match_code not in no_match, 'SOURCE,', '') +
      IF (rec.source_record_id_match_code  not in no_match, 'SOURCE_RECORD_ID,', '') +
      IF (rec.source_docid_match_code not in no_match, 'SOURCE_DOCID,', '') +
      IF (rec.company_name_prefix_match_code not in no_match, 'COMPANY_NAME_PREFIX,', '') + 
      IF (rec.cnp_name_match_code not in no_match, 'CNP_NAME,', '') + 
      IF (rec.cnp_number_match_code not in no_match, 'CNP_NUMBER,', '') + 
      IF (rec.cnp_btype_match_code not in no_match, 'CNP_BTYPE,', '') + 
      IF (rec.cnp_lowv_match_code not in no_match, 'CNP_LOWV,', '') + 
      IF (rec.company_phone_3_match_code not in no_match, 'PHONE_3,', '') + 
      IF (rec.company_phone_7_match_code not in no_match, 'PHONE_7,', '') + 
      IF (rec.company_fein_match_code not in no_match, 'FEIN,', '') + 
      IF (rec.company_sic_code1_match_code not in no_match, 'COMPANY_SIC_CODE,', '') + 
      IF (rec.active_duns_number_match_code not in no_match, 'ACTIVE_DUNS_NUMBER,', '') + 
      IF (rec.prim_range_match_code not in no_match, 'PRIM_RANGE,', '') + 
      IF (rec.prim_name_match_code not in no_match, 'PRIM_NAME,', '') + 
      IF (rec.sec_range_match_code not in no_match, 'SEC_RANGE,', '') + 
      IF (rec.city_match_code not in no_match or rec.city_clean_match_code not in no_match, 'CITY,', '') + 
      IF (rec.st_match_code not in no_match, 'STATE,', '') + 
      IF (rec.zip_match_code not in no_match, 'ZIP,', '') +   
      IF (rec.company_url_match_code not in no_match, 'URL,', '') + 
      IF (rec.contact_did_match_code not in no_match, 'CONTACT_DID,', '') + 
      IF (rec.title_match_code not in no_match, 'TITLE,', '') + 
      IF (rec.fname_match_code not in no_match, 'FIRSTNAME,', '') + 
      IF (rec.fname_preferred_match_code not in no_match, 'NICKNAME,', '') + 
      IF (rec.mname_match_code not in no_match, 'MIDDLENAME,', '') + 
      IF (rec.lname_match_code not in no_match, 'LASTNAME,', '') + 
      IF (rec.name_suffix_match_code not in no_match, 'NAME_SUFFIX,', '') + 
      IF (rec.contact_ssn_match_code not in no_match, 'SSN,', '') + 
      IF (rec.contact_email_match_code not in no_match, 'EMAIL,', '') + 
      IF (rec.sele_flag_match_code not in no_match, 'SELE_FLAG,', '') + 
      IF (rec.org_flag_match_code not in no_match, 'ORG_FLAG,', '') + 
      IF (rec.ult_flag_match_code not in no_match, 'ULT_FLAG,', '')   ;
end;

