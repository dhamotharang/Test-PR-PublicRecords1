IMPORT SALT38,STD;
EXPORT Base_Delta(DATASET(Base_Layout_DNB_FEIN)old_s, DATASET(Base_Layout_DNB_FEIN) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['tmsid','bdid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','orig_company_name','clean_cname','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_county','fein','source_duns_number','case_duns_number','duns_orig_source','confidence_code','indirect_direct_source_ind','best_fein_indicator','company_name','trade_style','sic_code','telephone_number','top_contact_name','top_contact_title','hdqtr_parent_duns_number','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_DNB_FEIN, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_DNB_FEIN, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DNB_FEIN, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
