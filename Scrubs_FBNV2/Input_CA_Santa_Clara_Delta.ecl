IMPORT SALT311,STD;
EXPORT Input_CA_Santa_Clara_Delta(DATASET(Input_CA_Santa_Clara_Layout_FBNV2)old_s, DATASET(Input_CA_Santa_Clara_Layout_FBNV2) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['status','process_date','FIlED_DATE','FBN_TYPE','FILING_TYPE','BUSINESS_NAME','BUSINESS_TYPE','ORIG_FILED_DATE','ORIG_FBN_NUM','RECORD_CODE1','FBN_NUM','BUSINESS_ADDR1','RECORD_CODE2','BUSINESS_ADDR2','RECORD_CODE3','BUS_CITY','BUS_ST','BUS_ZIP','RECORD_CODE4','ADDTL_BUSINESS','RECORD_CODE5','owner_name','OWNER_TYPE','RECORD_CODE6','OWNER_ADDR1','OWNER_CITY','OWNER_ST','OWNER_ZIP','Owner_title','Owner_fname','Owner_mname','Owner_lname','Owner_name_suffix','Owner_name_score','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Input_CA_Santa_Clara_hygiene(old_s).Summary('Old') + Input_CA_Santa_Clara_hygiene(new_s).Summary('New') + Input_CA_Santa_Clara_hygiene(PROJECT(Differences(deleted), TRANSFORM(Input_CA_Santa_Clara_Layout_FBNV2, SELF := LEFT.old_rec))).Summary('Deletions') + Input_CA_Santa_Clara_hygiene(PROJECT(Differences(added), TRANSFORM(Input_CA_Santa_Clara_Layout_FBNV2, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FBNV2, Input_CA_Santa_Clara_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
