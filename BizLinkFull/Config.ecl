IMPORT SALT33;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT33.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
EXPORT MatchThreshold := 38;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT LinkpathCandidateCount := 50; // Number of candidates to consider from each linkpath in batch. Higher = better result and slower execution.
EXPORT meow_dedup := 'AUTO'; // Values: ALWAYS, NEVER, or anything else to automatically decide what to dedup from MEOW inputs
 
EXPORT MAC_MEOW_Biz_Batch_Wrapper(infile,Ref='',Input_parent_proxid = '',Input_sele_proxid = '',Input_org_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_source = '',Input_source_record_id = '',Input_source_docid = '',Input_company_name = '',Input_company_name_prefix = '',Input_cnp_name = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_company_phone = '',Input_company_phone_3 = '',Input_company_phone_3_ex = '',Input_company_phone_7 = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_active_duns_number = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_city = '',Input_city_clean = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_contact_did = '',Input_title = '',Input_fname = '',Input_fname_preferred = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_contact_ssn = '',Input_contact_email = '',Input_sele_flag = '',Input_org_flag = '',Input_ult_flag = '',Input_fallback_value = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',OutFile,AsIndex='true',Stats='') := MACRO
  BizLinkFull.MAC_MEOW_Biz_Batch(infile,Ref,Input_parent_proxid,Input_sele_proxid,Input_org_proxid,Input_ultimate_proxid,Input_has_lgid,Input_empid,Input_source,Input_source_record_id,Input_source_docid,Input_company_name,Input_company_name_prefix,Input_cnp_name,Input_cnp_number,Input_cnp_btype,Input_cnp_lowv,Input_company_phone,Input_company_phone_3,Input_company_phone_3_ex,Input_company_phone_7,Input_company_fein,Input_company_sic_code1,Input_active_duns_number,Input_prim_range,Input_prim_name,Input_sec_range,Input_city,Input_city_clean,Input_st,Input_zip,Input_company_url,Input_isContact,Input_contact_did,Input_title,Input_fname,Input_fname_preferred,Input_mname,Input_lname,Input_name_suffix,Input_contact_ssn,Input_contact_email,Input_sele_flag,Input_org_flag,Input_ult_flag,Input_fallback_value,Input_CONTACTNAME,Input_STREETADDRESS,OutFile,AsIndex,Stats);
ENDMACRO;
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT cnp_name_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT prim_range_Force := 0; 
EXPORT city_clean_WheelThreshold := 2000;
EXPORT company_url_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
// Configuration of external files
END;
