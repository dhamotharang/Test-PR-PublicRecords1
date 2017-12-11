IMPORT SALT38,STD;
EXPORT party_Delta(DATASET(party_Layout_SANCTNKeys)old_s, DATASET(party_Layout_SANCTNKeys) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['batch_number','incident_number','party_number','record_type','order_number','party_name','party_position','party_vocation','party_firm','inaddress','incity','instate','inzip','ssnumber','fines_levied','restitution','ok_for_fcr','party_text','title','fname','mname','lname','name_suffix','name_score','cname','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','fips_state','fips_county','addr_rec_type','geo_lat','geo_long','cbsa','geo_blk','geo_match','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','err_stat','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','did','did_score','bdid','bdid_score','ssn_appended','dba_name','contact_name','enh_did_src'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := party_hygiene(old_s).Summary('Old') + party_hygiene(new_s).Summary('New') + party_hygiene(PROJECT(Differences(deleted), TRANSFORM(party_Layout_SANCTNKeys, SELF := LEFT.old_rec))).Summary('Deletions') + party_hygiene(PROJECT(Differences(added), TRANSFORM(party_Layout_SANCTNKeys, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTNKeys, party_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
