IMPORT BatchServices;
EXPORT layout_progressive_phone_batch_with_details_out := RECORD
    progressive_phone.layout_progressive_batch_out_with_did and not [did,p_did,subj_phone_date_last];
    string12	did;
    string12	p_did;
    BatchServices.Layouts.RTPhones.rec_output_internal and not [acctno, ssn, DID, phone, name, city, state, responseStatus, dt_first_seen, dt_last_seen, sec_range];
    unsigned1 qsent_sort_order := 0;
    string17  phone_line_type_desc := '';
  END;
