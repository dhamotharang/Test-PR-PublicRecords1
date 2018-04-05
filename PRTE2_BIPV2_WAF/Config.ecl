IMPORT SALT38;
EXPORT Config := MODULE,VIRTUAL
EXPORT DoSliceouts := TRUE; // If set to false slice-outs do not occur (saves time)
EXPORT CorrelateSampleSize := 100000000; // Size of sample used in hygiene.corelations
EXPORT ByPassCleave := FALSE; // If set to true Cleave process will not run in the next internal linking iteration.
EXPORT PersistExpire := 30; // PERSIST file expiration time in days.
EXPORT AttrValueType := SALT38.AttrValueType;
EXPORT MaxChildren := 100; // Maximum children allowed for a MULTIPLE(,LIST)
alg := ENUM(UNSIGNED1, Standard=0, NoTrailingHalfEdit);
EXPORT WithinEditN(SALT38.StrType l,UNSIGNED1 ll, SALT38.StrType r,UNSIGNED1 rl,UNSIGNED1 d, UNSIGNED1 edit_threshold=0,UNSIGNED1 mode=alg.Standard, BOOLEAN edFunction(SALT38.StrType l,UNSIGNED1 ll, SALT38.StrType r,UNSIGNED1 rl,UNSIGNED1 d,UNSIGNED1 mode) = SALT38.fn_EditDistance) := 
        SALT38.WithinEditNew(l, ll, r, rl, d, edit_threshold, mode, edFunction);
EXPORT MatchThreshold := 37;
EXPORT BasicMatchThreshold := MatchThreshold; // Possibly reduce by a little to give yourself wriggle room in the rather less precise basic match
EXPORT MeowPrefetch := 20; //Number of transforms called at once
EXPORT ExternalFilePrefetch := 30; //Number of transforms called at once
EXPORT LinkpathCandidateCount := 50; // Number of candidates to consider from each linkpath in batch. Higher = better result and slower execution.
EXPORT STRING meow_dedup := 'AUTO'; // Values: ALWAYS, NEVER, or anything else to automatically decide what to dedup from MEOW inputs
 
EXPORT MAC_MEOW_Biz_Batch_Wrapper(infile,Ref='',Input_proxid = '',Input_seleid = '',Input_orgid = '',Input_ultid = '',Input_parent_proxid = '',Input_ultimate_proxid = '',Input_has_lgid = '',Input_empid = '',Input_powid = '',Input_source = '',Input_source_record_id = '',Input_cnp_number = '',Input_cnp_btype = '',Input_cnp_lowv = '',Input_cnp_name = '',Input_company_phone = '',Input_company_fein = '',Input_company_sic_code1 = '',Input_prim_range = '',Input_prim_name = '',Input_sec_range = '',Input_p_city_name = '',Input_st = '',Input_zip = '',Input_company_url = '',Input_isContact = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_contact_email = '',Input_CONTACTNAME = '',Input_STREETADDRESS = '',OutFile,AsIndex = 'true',UpdateIDs = 'false',Stats = '',Input_bGetAllScores = 'true',DoClean = 'true') := MACRO
	PRTE2_BIPV2_WAF.MAC_MEOW_Biz_Batch(infile,Ref,Input_proxid,Input_seleid,Input_orgid,Input_ultid,Input_parent_proxid,Input_ultimate_proxid,Input_has_lgid,Input_empid,Input_powid,Input_source,Input_source_record_id,Input_cnp_number,Input_cnp_btype,Input_cnp_lowv,Input_cnp_name,Input_company_phone,Input_company_fein,Input_company_sic_code1,Input_prim_range,Input_prim_name,Input_sec_range,Input_p_city_name,Input_st,Input_zip,Input_company_url,Input_isContact,Input_title,Input_fname,Input_mname,Input_lname,Input_name_suffix,Input_contact_email,Input_CONTACTNAME,Input_STREETADDRESS,OutFile,AsIndex,UpdateIDs,Stats,Input_bGetAllScores,DoClean);
ENDMACRO;
EXPORT JoinLimit := 10000;
// Configuration of individual fields
EXPORT cnp_name_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
EXPORT company_url_Force := 0; // Wordbags have an implicit FORCE(0) when asking 'does it match'
// Configuration of external files
 
EXPORT EFRKeyName := '~'+'key::PRTE2_BIPV2_WAF::proxid::EFR';
d := DATASET([],Ext_Layouts.EFR_Layout);
 
EXPORT EFR := INDEX(d,{ultid,orgid,seleid,proxid},{d},EFRKeyName,OPT);
EXPORT MaxCorps := 0; //Default of 0 fetches all
EXPORT MaxUCC := 0; //Default of 0 fetches all
EXPORT MaxVehicle := 0; //Default of 0 fetches all
EXPORT MaxPropertyV2 := 0; //Default of 0 fetches all
EXPORT MaxBizContacts := 0; //Default of 0 fetches all
EXPORT SOURCE_Permit_Number := 10; // The number of permit bits for record access control; This number needs to be in sync with fn_sources!
END;

