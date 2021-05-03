IMPORT SALT311,STD;
EXPORT Delta(DATASET(Layout_LitigiousDebtor)old_s, DATASET(Layout_LitigiousDebtor) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','recid','courtstate','courtid','courtname','docketnumber','officename','asofdate','classcode','casecaption','datefiled','judgetitle','judgename','referredtojudgetitle','referredtojudge','jurydemand','demandamount','suitnaturecode','suitnaturedesc','leaddocketnumber','jurisdiction','cause','statute','ca','caseclosed','dateretrieved','otherdocketnumber','litigantname','litigantlabel','layoutcode','terminationdate','attorneyname','attorneylabel','firmname','address','city','state','zipcode','country','addtlinfo','termdate','bdid','did','causecode','judge_title','judge_fname','judge_mname','judge_lname','judge_suffix','judge_score','business_person','debtor','debtor_title','debtor_fname','debtor_mname','debtor_lname','debtor_suffix','debtor_score','attorney_title','attorney_fname','attorney_mname','attorney_lname','attorney_suffix','attorney_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(Layout_LitigiousDebtor, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(Layout_LitigiousDebtor, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_LitigiousDebtor, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
