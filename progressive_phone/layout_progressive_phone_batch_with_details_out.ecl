IMPORT BatchServices, progressive_phone;

EXPORT layout_progressive_phone_batch_with_details_out := RECORD
  progressive_phone.layout_progressive_batch_out_with_did AND NOT [did, p_did, subj_phone_date_last];
  STRING12	did;
  STRING12	p_did;
  BatchServices.Layouts.RTPhones.rec_output_internal AND NOT [acctno, ssn, DID, phone, name, city, state, responseStatus, dt_first_seen, dt_last_seen, sec_range];
  UNSIGNED1 qsent_sort_order := 0;
  STRING17  phone_line_type_desc := '';
  UNSIGNED1 Phone_StarRating := 0;
END;
