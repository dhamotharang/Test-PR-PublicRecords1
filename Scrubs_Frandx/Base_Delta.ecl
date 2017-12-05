IMPORT SALT38,STD;
EXPORT Base_Delta(DATASET(Base_Layout_Frandx)old_s, DATASET(Base_Layout_Frandx) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','bdid','bdid_score','did','did_score','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','franchisee_id','brand_name','fruns','company_name','exec_full_name','address1','address2','city','state','zip_code','zip_code4','phone','phone_extension','secondary_phone','unit_flag','relationship_code','f_units','website_url','email','industry','sector','industry_type','sic_code','frn_start_date','record_id','unit_flag_exp','relationship_code_exp','clean_phone','clean_secondary_phone','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Base_hygiene(old_s).Summary('Old') + Base_hygiene(new_s).Summary('New') + Base_hygiene(PROJECT(Differences(deleted), TRANSFORM(Base_Layout_Frandx, SELF := LEFT.old_rec))).Summary('Deletions') + Base_hygiene(PROJECT(Differences(added), TRANSFORM(Base_Layout_Frandx, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Frandx, Base_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
