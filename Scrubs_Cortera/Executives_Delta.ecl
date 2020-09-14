IMPORT SALT311,STD;
EXPORT Executives_Delta(DATASET(Executives_Layout_Cortera)old_s, DATASET(Executives_Layout_Cortera) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['link_id','name','alternate_business_name','address','address2','city','state','country','postalcode','phone','fax','latitude','longitude','url','fein','position_type','ultimate_linkid','ultimate_name','loc_date_last_seen','primary_sic','sic_desc','primary_naics','naics_desc','segment_id','segment_desc','year_start','ownership','total_employees','employee_range','total_sales','sales_range','executive_name1','title1','executive_name2','title2','executive_name3','title3','executive_name4','title4','executive_name5','title5','executive_name6','title6','executive_name7','title7','executive_name8','title8','executive_name9','title9','executive_name10','title10','status','is_closed','closed_date','processdate','version','persistent_record_id','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','prim_name','p_city_name','v_city_name','executive_name','executive_title'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Executives_hygiene(old_s).Summary('Old') + Executives_hygiene(new_s).Summary('New') + Executives_hygiene(PROJECT(Differences(deleted), TRANSFORM(Executives_Layout_Cortera, SELF := LEFT.old_rec))).Summary('Deletions') + Executives_hygiene(PROJECT(Differences(added), TRANSFORM(Executives_Layout_Cortera, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Cortera, Executives_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
