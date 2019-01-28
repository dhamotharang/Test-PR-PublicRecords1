IMPORT dx_Email;

EXPORT Raw := MODULE


  EXPORT getIdsByLexID(DATASET(Email_Services.Layouts.batch_in_rec) ds_batch_in) := FUNCTION

    ids_from_did := join(ds_batch_in,dx_Email.Key_Did(), 
                          KEYED(LEFT.DID = RIGHT.DID), 
                            TRANSFORM(Email_Services.Layouts.email_ids_rec,
                              SELF.acctno        := LEFT.acctno;
                              SELF.seq           := LEFT.seq;
                              SELF.email_rec_key := RIGHT.email_rec_key,                                
                              SELF := LEFT,
                              SELF := []),
                              LIMIT(Email_Services.Constants.SEARCH_JOIN_LIMIT, SKIP));
    RETURN ids_from_did;                                           
  END;          

  EXPORT getIdsByInputEmail(DATASET(Email_Services.Layouts.batch_in_rec) ds_batch_in) := FUNCTION
    
    email_lookup := JOIN(ds_batch_in,dx_Email.Key_Email_Address, 
                          KEYED(LEFT.email_username+'@'+LEFT.email_domain = RIGHT.clean_email), 
                            TRANSFORM(Email_Services.Layouts.email_ids_rec,
                              SELF.acctno        := LEFT.acctno;
                              SELF.seq           := LEFT.seq;
                              SELF.email_rec_key := RIGHT.email_rec_key,                                
                              SELF := LEFT,
                              SELF := []),
                              LIMIT(Email_Services.Constants.SEARCH_JOIN_LIMIT, SKIP));
    RETURN email_lookup;                                           
  END;  
  
  EXPORT getEmailPayload(DATASET(Email_Services.Layouts.email_ids_rec) ids_batch_in) := FUNCTION
    
    email_payload := JOIN(ids_batch_in,dx_Email.Key_email_payload(), 
                          KEYED(LEFT.email_rec_key = RIGHT.email_rec_key), 
                            TRANSFORM(Email_Services.Layouts.email_raw_rec,
                              SELF.acctno         := LEFT.acctno,
                              SELF.seq            := LEFT.seq,
                              SELF.email_id       := RIGHT.email_rec_key,
                              SELF.is_current     := RIGHT.current_rec,
                              SELF.email_username := RIGHT.append_email_username,
                              SELF.email_domain   := RIGHT.append_domain,
                              SELF.original.first_name  := RIGHT.orig_first_name;
                              SELF.original.last_name   := RIGHT.orig_last_name;
                              SELF.original.middle_name := RIGHT.orig_middle_name;
                              SELF.original.name_suffix := RIGHT.orig_name_suffix;
                              SELF.original.address     := RIGHT.orig_address;
                              SELF.original.city        := RIGHT.orig_city;
                              SELF.original.state       := RIGHT.orig_state;
                              SELF.original.zip         := RIGHT.orig_zip;
                              SELF.original.zip4        := RIGHT.orig_zip4;
                              SELF.original.email       := RIGHT.orig_email;
                              SELF.original.ip          := RIGHT.orig_ip;
                              SELF.original.login_date  := RIGHT.orig_login_date;
                              SELF.original.site        := RIGHT.orig_site;
                              SELF.original.phone       := RIGHT.orig_phone;
                              SELF.original.ssn         := RIGHT.orig_ssn;
                              SELF.original.dob         := RIGHT.orig_dob;
                              SELF.cleaned.Name   := RIGHT.Clean_Name,
                              SELF.cleaned.Address := RIGHT.clean_address,
                              SELF.cleaned := RIGHT;
                              SELF := RIGHT,
                              SELF := []),
                              KEEP(1),LIMIT(0));
    RETURN email_payload;                                           
  END;  
  
  EXPORT getEmailRawData(DATASET(Email_Services.Layouts.batch_in_rec) batch_in,
                         Email_Services.IParams.EmailParams in_mod) := FUNCTION

    search_by_email := getIdsByInputEmail(batch_in);
    search_by_lexid := getIdsByLexID(batch_in);
    //   search_by_autokeys := getIdsByAutokeys(batch_in);
    
    id_recs := CASE(in_mod.SearchType,
                 Email_Services.Constants.SearchType.EIA => search_by_email,
                 Email_Services.Constants.SearchType.EAA => search_by_lexid,
                 DATASET([], Email_Services.Layouts.email_ids_rec) );
                 
    payload_recs := getEmailPayload(id_recs); 
    RETURN payload_recs;
  END;
  

END;
