IMPORT SALT39,STD;
EXPORT Delta(DATASET(Layout_File)old_s, DATASET(Layout_File) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['type','confidence','did1','did2','cohabit_score','cohabit_cnt','coapt_score','coapt_cnt','copobox_score','copobox_cnt','cossn_score','cossn_cnt','copolicy_score','copolicy_cnt','coclaim_score','coclaim_cnt','coproperty_score','coproperty_cnt','bcoproperty_score','bcoproperty_cnt','coforeclosure_score','coforeclosure_cnt','bcoforeclosure_score','bcoforeclosure_cnt','colien_score','colien_cnt','bcolien_score','bcolien_cnt','cobankruptcy_score','cobankruptcy_cnt','bcobankruptcy_score','bcobankruptcy_cnt','covehicle_score','covehicle_cnt','coexperian_score','coexperian_cnt','cotransunion_score','cotransunion_cnt','coenclarity_score','coenclarity_cnt','coecrash_score','coecrash_cnt','bcoecrash_score','bcoecrash_cnt','cowatercraft_score','cowatercraft_cnt','coaircraft_score','coaircraft_cnt','comarriagedivorce_score','comarriagedivorce_cnt','coucc_score','coucc_cnt','lname_score','phone_score','dl_nbr_score','total_cnt','total_score','cluster','generation','gender','lname_cnt','rel_dt_first_seen','rel_dt_last_seen','overlap_months','hdr_dt_first_seen','hdr_dt_last_seen','age_first_seen','isanylnamematch','isanyphonematch','isearlylnamematch','iscurrlnamematch','ismixedlnamematch','ssn1','ssn2','dob1','dob2','current_lname1','current_lname2','early_lname1','early_lname2','addr_ind1','addr_ind2','r2rdid','r2cnt','personal','business','other','title'];
  EXPORT Differences := SALT39.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_File, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_File, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FileRelative_Monthly, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
