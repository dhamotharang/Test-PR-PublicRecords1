IMPORT SALT38,STD;
EXPORT raw_file_Delta(DATASET(raw_file_Layout_Certegy)old_s, DATASET(raw_file_Layout_Certegy) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dl_state','dl_num','ssn','dl_issue_dte','dl_expire_dte','house_bldg_num','street_suffix','apt_num','unit_desc','street_post_dir','street_pre_dir','state','zip','zip4','dob','deceased_dte','home_tel_area','home_tel_num','work_tel_area','work_tel_num','work_tel_ext','upd_dte_time','first_name','mid_name','last_name','gen_delivery','street_name','city','foreign_cntry'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := raw_file_hygiene(old_s).Summary('Old') + raw_file_hygiene(new_s).Summary('New') + raw_file_hygiene(PROJECT(Differences(deleted), TRANSFORM(raw_file_Layout_Certegy, SELF := LEFT.old_rec))).Summary('Deletions') + raw_file_hygiene(PROJECT(Differences(added), TRANSFORM(raw_file_Layout_Certegy, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Certegy, raw_file_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
