IMPORT SALT38,STD;
EXPORT Base_Delta(DATASET(Base_Layout_Credit_Unions)old_s, DATASET(Base_Layout_Credit_Unions) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['powid','proxid','seleid','orgid','ultid','source_rec_id','bdid','record_type','raw_aid','ace_aid','dt_vendor_first_reported','dt_vendor_last_reported','charter','cycle_date','join_number','siteid','cu_name','sitename','sitetypename','mainoffice','addrtype','address1','address2','city','state','statename','zip_code','countyname','country','phone','contact_name','assets','loans','networthratio','perc_sharegrowth','perc_loangrowth','loantoassetsratio','investassetsratio','nummem','numfull','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','prep_addr_line1','prep_addr_line_last'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_Credit_Unions, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_Credit_Unions, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Credit_Unions, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
