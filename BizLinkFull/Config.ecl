IMPORT SALT37;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT37.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT37.StrType l,UNSIGNED1 ll, SALT37.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT37.StrType l,UNSIGNED1 ll, SALT37.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT37.fn_EditDistance) := 
        SALT37.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT MatchThreshold := 38;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT MeowPrefetch := 20; //Number of transforms called at once
EXPORT ExternalFilePrefetch := 30; //Number of transforms called at once
EXPORT LinkpathCandidateCount := 50; // Number of candidates to consider from each linkpath in batch. Higher = better result and slower execution.
EXPORT meow_dedup := 'AUTO'; // Values: ALWAYS, NEVER, or anything else to automatically decide what to dedup from MEOW inputs
 
EXPORT MAC_MEOW_Biz_Batch_Wrapper(infile,Ref='',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_parent_proxid = '',Input_sele_proxid = '',Input_org_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_source = '',Input_source_record_id = '',Input_source_docid = '',Input_company_name = '',Input_company_name_prefix = '',Input_cnp_name = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_company_phone = '',Input_company_phone_3 = '',Input_company_phone_3_ex = '',Input_company_phone_7 = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_active_duns_number = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_city = '',Input_city_clean = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_contact_did = '',Input_title = '',Input_fname = '',Input_fname_preferred = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_contact_ssn = '',Input_contact_email = '',Input_sele_flag = '',Input_org_flag = '',Input_ult_flag = '',Input_fallback_value = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',OutFile,AsIndex='true',UpdateIDs='false',Stats='', Input_bGetAllScores = 'true', Input_disableForce = 'false') := MACRO
	BizLinkFull.MAC_MEOW_Biz_Batch(infile,Ref,Input_proxid,Input_seleid,Input_orgid,Input_ultid,Input_parent_proxid,Input_sele_proxid,Input_org_proxid,Input_ultimate_proxid,Input_has_lgid,Input_empid,Input_source,Input_source_record_id,Input_source_docid,Input_company_name,Input_company_name_prefix,Input_cnp_name,Input_cnp_number,Input_cnp_btype,Input_cnp_lowv,Input_company_phone,Input_company_phone_3,Input_company_phone_3_ex,Input_company_phone_7,Input_company_fein,Input_company_sic_code1,Input_active_duns_number,Input_prim_range,Input_prim_name,Input_sec_range,Input_city,Input_city_clean,Input_st,Input_zip,Input_company_url,Input_isContact,Input_contact_did,Input_title,Input_fname,Input_fname_preferred,Input_mname,Input_lname,Input_name_suffix,Input_contact_ssn,Input_contact_email,Input_sele_flag,Input_org_flag,Input_ult_flag,Input_fallback_value,Input_CONTACTNAME,Input_STREETADDRESS,OutFile,AsIndex,UpdateIDs,Stats, Input_bGetAllScores, Input_disableForce);
ENDMACRO;
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT cnp_name_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT prim_range_Force := 0; 
EXPORT city_clean_WheelThreshold := 2000;
EXPORT company_url_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
// Configuration of linkpath atmost/limit thresholds
EXPORT L_CNPNAME_ZIP_MAXBLOCKSIZE:=10000;
EXPORT L_CNPNAME_ZIP_MAXBLOCKLIMIT:=10000;
EXPORT L_CNPNAME_ST_MAXBLOCKSIZE:=10000;
EXPORT L_CNPNAME_ST_MAXBLOCKLIMIT:=10000;
EXPORT L_CNPNAME_MAXBLOCKSIZE:=10000;
EXPORT L_CNPNAME_MAXBLOCKLIMIT:=10000;
EXPORT L_CNPNAME_FUZZY_MAXBLOCKSIZE:=10000;
EXPORT L_CNPNAME_FUZZY_MAXBLOCKLIMIT:=10000;
EXPORT L_ADDRESS1_MAXBLOCKSIZE:=10000;
EXPORT L_ADDRESS1_MAXBLOCKLIMIT:=10000;
EXPORT L_ADDRESS2_MAXBLOCKSIZE:=10000;
EXPORT L_ADDRESS2_MAXBLOCKLIMIT:=10000;
EXPORT L_ADDRESS3_MAXBLOCKSIZE:=10000;
EXPORT L_ADDRESS3_MAXBLOCKLIMIT:=10000;
EXPORT L_PHONE_MAXBLOCKSIZE:=10000;
EXPORT L_PHONE_MAXBLOCKLIMIT:=10000;
EXPORT L_FEIN_MAXBLOCKSIZE:=10000;
EXPORT L_FEIN_MAXBLOCKLIMIT:=10000;
EXPORT L_URL_MAXBLOCKSIZE:=10000;
EXPORT L_URL_MAXBLOCKLIMIT:=10000;
EXPORT L_CONTACT_MAXBLOCKSIZE:=10000;
EXPORT L_CONTACT_MAXBLOCKLIMIT:=10000;
EXPORT L_CONTACT_SSN_MAXBLOCKSIZE:=10000;
EXPORT L_CONTACT_SSN_MAXBLOCKLIMIT:=10000;
EXPORT L_EMAIL_MAXBLOCKSIZE:=10000;
EXPORT L_EMAIL_MAXBLOCKLIMIT:=10000;
EXPORT L_SIC_MAXBLOCKSIZE:=2000;
EXPORT L_SIC_MAXBLOCKLIMIT:=10000;
EXPORT L_SOURCE_MAXBLOCKSIZE:=10000;
EXPORT L_SOURCE_MAXBLOCKLIMIT:=10000;
EXPORT L_CONTACT_DID_MAXBLOCKSIZE:=10000;
EXPORT L_CONTACT_DID_MAXBLOCKLIMIT:=10000;
END;
