IMPORT SALT311,STD;
EXPORT Base_Delta(DATASET(Base_Layout_PAW)old_s, DATASET(Base_Layout_PAW) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['contact_id','company_phone','company_name','active_phone_flag','source_count','source','record_type','record_sid','global_sid','GLB','lname','fname','dt_last_seen','dt_first_seen','RawAid','zip','state','bdid','zip4','geo_long','geo_lat','county','company_zip','company_state','Company_RawAid','company_zip4','msa','did','ssn','phone','predir','company_predir','company_postdir','postdir','from_hdr','dead_flag'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_PAW, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_PAW, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PAW, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
