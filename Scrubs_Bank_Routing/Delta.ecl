IMPORT SALT38,STD;
EXPORT Delta(DATASET(layout_bank_routing)old_s, DATASET(layout_bank_routing) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['file_key','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','date_updated','type_instituon_code','head_office_branch_codes','routing_number_micr','routing_number_fractional','institution_name_full','institution_name_abbreviated','street_address','city_town','state','zip_code','zip_4','mail_address','mail_city_town','mail_state','mail_zip_code','mail_zip_4','branch_office_name','head_office_routing_number','phone_number_area_code','phone_number','phone_number_extension','fax_area_code','fax_number','fax_extension','head_office_asset_size','federal_reserve_district_code','year_2000_date_last_updated','head_office_file_key','routing_number_type','routing_number_status','employer_tax_id','institution_identifier'];
  EXPORT Differences := SALT38.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := hygiene(old_s).Summary('Old') + hygiene(new_s).Summary('New') + hygiene(PROJECT(Differences(deleted), TRANSFORM(layout_bank_routing, SELF := LEFT.old_rec))).Summary('Deletions') + hygiene(PROJECT(Differences(added), TRANSFORM(layout_bank_routing, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(scrubs_bank_routing, Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
