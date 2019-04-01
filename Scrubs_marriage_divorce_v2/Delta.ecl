IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_Marriage_Divorce_V2_Profile)old_s, DATASET(Layout_Marriage_Divorce_V2_Profile) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_id','filing_type','filing_subtype','vendor','source_file','process_date','state_origin','party1_type','party1_name_format','party1_name','party1_alias','party1_dob','party1_birth_state','party1_age','party1_race','party1_addr1','party1_csz','party1_county','party1_previous_marital_status','party1_how_marriage_ended','party1_times_married','party1_last_marriage_end_dt','party2_type','party2_name_format','party2_name','party2_alias','party2_dob','party2_birth_state','party2_age','party2_race','party2_addr1','party2_csz','party2_county','party2_previous_marital_status','party2_how_marriage_ended','party2_times_married','party2_last_marriage_end_dt','number_of_children','marriage_filing_dt','marriage_dt','marriage_city','marriage_county','place_of_marriage','type_of_ceremony','marriage_filing_number','marriage_docket_volume','divorce_filing_dt','divorce_dt','divorce_docket_volume','divorce_filing_number','divorce_city','divorce_county','grounds_for_divorce','marriage_duration_cd','marriage_duration','persistent_record_id'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_Marriage_Divorce_V2_Profile, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_Marriage_Divorce_V2_Profile, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Marriage_Divorce_V2, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));


    RETURN hygieneDiffOverall_Standard;
  END;
END;
