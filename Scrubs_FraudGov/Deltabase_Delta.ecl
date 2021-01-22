IMPORT SALT311,STD;
EXPORT Deltabase_Delta(DATASET(Deltabase_Layout_Deltabase)old_s, DATASET(Deltabase_Layout_Deltabase) new_s) := MODULE//Routines to compute the differences between two instances of a file
  SHARED inFieldList := ['inqlog_id','customer_id','transaction_id','date_of_transaction','household_id','customer_person_id','customer_program','reason_for_transaction_activity','inquiry_source','customer_county','customer_state','customer_agency_vertical_type','ssn','dob','rawlinkid','raw_full_name','raw_title','raw_first_name','raw_middle_name','raw_last_name','raw_orig_suffix','full_address','street_1','city','state','zip','county','mailing_street_1','mailing_city','mailing_state','mailing_zip','mailing_county','phone_number','ultid','orgid','seleid','tin','email_address','appended_provider_id','lnpid','npi','ip_address','device_id','professional_id','bank_routing_number_1','bank_account_number_1','drivers_license_state','drivers_license','geo_lat','geo_long','reported_date','file_type','deceitful_confidence','reported_by','reason_description','event_type_1','event_entity_1'];
  EXPORT Differences := SALT311.mod_Delta.mac_DifferencesByFieldList(old_s, new_s, inFieldList);
  EXPORT DifferenceSummary := Deltabase_hygiene(old_s).Summary('Old') + Deltabase_hygiene(new_s).Summary('New') + Deltabase_hygiene(PROJECT(Differences(deleted), TRANSFORM(Deltabase_Layout_Deltabase, SELF := LEFT.old_rec))).Summary('Deletions') + Deltabase_hygiene(PROJECT(Differences(added), TRANSFORM(Deltabase_Layout_Deltabase, SELF := LEFT.new_rec))).Summary('Additions');
  EXPORT StandardStats(BOOLEAN doHygieneSummaryGlobal = TRUE) := FUNCTION
    myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
    hygieneDiffOverall := DifferenceSummary;
    SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, Deltabase_Fields, 'RECORDOF(hygieneDiffOverall)', FALSE);
    hygieneDiffOverall_Standard := IF(doHygieneSummaryGlobal, NORMALIZE(hygieneDiffOverall, COUNT(inFieldList) * 6, xSummary(LEFT, COUNTER, myTimeStamp, LEFT.txt + '_all', LEFT.txt + '_all')));
    RETURN hygieneDiffOverall_Standard;
  END;
END;
