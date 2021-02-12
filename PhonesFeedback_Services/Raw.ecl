IMPORT AutoStandardI, PhonesFeedback_services, doxie, PhonesFeedback, Suppress, ut;

EXPORT Raw := MODULE
  SHARED mod_access := doxie.compliance.GetGlobalDataAccessModuleTranslated (AutoStandardI.GlobalModule());
  EXPORT Layouts.Layout_PhonesFeedback_base byPhoneNumber(DATASET(Layouts.rec_in_request) in_PhoneNumber) := FUNCTION
    deduped := DEDUP(SORT(in_PhoneNumber,Phone_number,in_DID),Phone_number,in_DID);
    joinup := JOIN(deduped, PhonesFeedback.Key_PhonesFeedback_phone,
      ((LEFT.Phone_number = RIGHT.Phone_number) AND 
      ((UNSIGNED) LEFT.in_did= (UNSIGNED) RIGHT.did OR (UNSIGNED) LEFT.in_did=0)),
      TRANSFORM(Layouts.Layout_PhonesFeedback_base, SELF := RIGHT), 
      LIMIT(ut.limits.FEEDBACK_PER_PHONE, SKIP));
      
    deduped_recs := DEDUP(SORT(joinup, RECORD), RECORD);
    suppressed_recs := suppress.MAC_SuppressSource(deduped_recs,mod_access);
      
    RETURN suppressed_recs;
  END;
   
  EXPORT feedback_rpt (DATASET(Layouts.rec_in_request) in_rec):=FUNCTION
  
    deduped := DEDUP(SORT(in_rec,Phone_number,in_DID),Phone_number,in_DID);
    skip_set:=['7','8'];

    joinup := 
      JOIN(deduped,PhonesFeedback.Key_PhonesFeedback_phone,
        ((LEFT.Phone_number = RIGHT.Phone_number) AND
        ((UNSIGNED) LEFT.in_did= (UNSIGNED) RIGHT.did OR (UNSIGNED) LEFT.in_did=0)) AND
        (RIGHT.phone_contact_type NOT IN skip_set),
        TRANSFORM(Layouts.Layout_PhonesFeedback_base, SELF := RIGHT), 
      LIMIT(ut.limits.FEEDBACK_PER_PHONE, SKIP));

    deduped_recs := DEDUP(SORT(joinup, RECORD), RECORD);
    suppressed_recs := suppress.MAC_SuppressSource(deduped_recs,mod_access);
    result_tmp:=IF(EXISTS(suppressed_recs),
      PhonesFeedback_Services.Functions.GetReport(suppressed_recs),
      DATASET([],PhonesFeedback_Services.Layouts.feedback_report));
    
    RETURN CHOOSEN(result_tmp, 1);
  END;

END;
