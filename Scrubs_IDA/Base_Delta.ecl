IMPORT SALT311,STD;
EXPORT Base_Delta(DATASET(Base_Layout_IDA)old_s, DATASET(Base_Layout_IDA) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['persistent_record_id','src','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','did','did_score','orig_first_name','orig_middle_name','orig_last_name','orig_suffix','orig_address1','orig_address2','orig_city','orig_state_province','orig_zip4','orig_zip5','orig_dob','orig_ssn','orig_dl','orig_dlstate','orig_phone','clientassigneduniquerecordid','adl_ind','orig_email','orig_ipaddress','orig_filecategory','title','fname','mname','lname','name_suffix','nid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','clean_phone','clean_dob'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_IDA, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_IDA, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_IDA, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));


    RETURN hygieneDiffOverall_Standard;
  END;
END;
