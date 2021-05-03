IMPORT SALT311,STD;
EXPORT Input_Delta(DATASET(Input_Layout_FCC)old_s, DATASET(Input_Layout_FCC) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['license_type','file_number','callsign_of_license','radio_service_code','licensees_name','licensees_attention_line','dba_name','licensees_street','licensees_city','licensees_state','licensees_zip','licensees_phone','date_application_received_at_fcc','date_license_issued','date_license_expires','date_of_last_change','type_of_last_change','latitude','longitude','transmitters_street','transmitters_city','transmitters_county','transmitters_state','transmitters_antenna_height','transmitters_height_above_avg_terra','transmitters_height_above_ground_le','power_of_this_frequency','frequency_mhz','class_of_station','number_of_units_authorized_on_freq','effective_radiated_power','emissions_codes','frequency_coordination_number','paging_license_status','control_point_for_the_system','pending_or_granted','firm_preparing_application','contact_firms_street_address','contact_firms_city','contact_firms_state','contact_firms_zipcode','contact_firms_phone_number','contact_firms_fax_number','unique_key','crlf'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Input_hygiene(old_s).Summary('Old') + Input_hygiene(new_s).Summary('New') + Input_hygiene(PROJECT(Differences(deleted), TRANSFORM(Input_Layout_FCC, SELF := LEFT.old_rec))).Summary('Deletions') + Input_hygiene(PROJECT(Differences(added), TRANSFORM(Input_Layout_FCC, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FCC, Input_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
 
    RETURN hygieneDiffOverall_Standard;
  END;
END;
