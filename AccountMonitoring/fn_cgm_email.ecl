IMPORT AccountMonitoring, dx_Email;

EXPORT DATASET( AccountMonitoring.layouts.history) fn_cgm_email(
        DATASET(AccountMonitoring.layouts.portfolio.base) in_portfolio,
        DATASET(AccountMonitoring.layouts.documents.email.base) in_documents = DATASET([], AccountMonitoring.layouts.documents.email.base),
        AccountMonitoring.i_Job_Config job_config
	) := 
	FUNCTION

  // Get key files
  key_lexids := DISTRIBUTED(AccountMonitoring.product_files.email.lexid_key,
                            HASH64(did));

  key_emailaddr := DISTRIBUTED(AccountMonitoring.product_files.email.emailaddr_key,
                               HASH64(clean_email));

  key_payload := DISTRIBUTED(AccountMonitoring.product_files.email.main_key,
                             HASH64(email_rec_key));


  // Temporary Join Layout
  temp_layout := RECORD
    in_documents.pid;
    in_documents.rid;
    in_documents.hid;
    in_portfolio.did;
    in_portfolio.bdid;
    key_payload.email_rec_key;
  END;

  temp_port_dist_lexid  := DISTRIBUTE(in_portfolio(did != 0), HASH64(did));
    
  temp_join_lexid_rcid := JOIN(temp_port_dist_lexid, Key_lexids, 
                                LEFT.did = RIGHT.did,
                                TRANSFORM(temp_layout,
                                          SELF.pid := LEFT.pid,
                                          SELF.rid := LEFT.rid,
                                          SELF.hid := 0,
                                          SELF.did := LEFT.did,
                                          SELF.bdid := LEFT.bdid,
                                          SELF.email_rec_key := RIGHT.email_rec_key), LOCAL);	

    
  temp_port_dist_emailaddr  := DISTRIBUTE(in_portfolio(email_address != ''), HASH64(email_address));
    
  temp_join_emailaddr_rcid := JOIN(temp_port_dist_emailaddr, Key_emailaddr, 
                                  LEFT.email_address = RIGHT.clean_email,
                                  TRANSFORM(temp_layout,
                                          SELF.pid := LEFT.pid,
                                          SELF.rid := LEFT.rid,
                                          SELF.hid := 0,
                                          SELF.did := LEFT.did,
                                          SELF.bdid := LEFT.bdid,
                                          SELF.email_rec_key := RIGHT.email_rec_key), LOCAL);	
                                  
  // Combine the possibilities 
  temp_all_joins := temp_join_emailaddr_rcid + temp_join_lexid_rcid;

  // Dedup by email_rec_key so not to double-count
  temp_joins_deduped := DEDUP(SORT(DISTRIBUTE( temp_all_joins, hash64(pid,rid) ),
                                   pid,rid,email_rec_key, LOCAL),
                              pid,rid,email_rec_key, LOCAL);

  temp_joins_dist := DISTRIBUTE(temp_joins_deduped,hash64(email_rec_key));


  // Temporary data Layout
  temp_data_layout := RECORD
    temp_layout  - [email_rec_key];
    key_payload.clean_email;
  END;

  temp_join_email_payload := JOIN(temp_joins_dist , Key_payload, 
                                LEFT.email_rec_key = RIGHT.email_rec_key,
                                TRANSFORM(temp_data_layout,
                                          SELF.pid := LEFT.pid,
                                          SELF.rid := LEFT.rid,
                                          SELF.hid := 0,
                                          SELF.did := LEFT.did,
                                          SELF.bdid := LEFT.bdid,
                                          SELF.clean_email := RIGHT.clean_email
                                         ), LOCAL);

    
  payload_email_dedup := DEDUP(SORT(DISTRIBUTE(temp_join_email_payload, HASH64(pid,rid)), 
                                 pid,rid,did,clean_email, LOCAL),
                                pid,rid,did,clean_email, LOCAL);


  email_unrolled_hashes := PROJECT(payload_email_dedup,
                                  TRANSFORM(AccountMonitoring.layouts.history,
                                    SELF.pid          := LEFT.pid,
                                    SELF.rid          := LEFT.rid,
                                    SELF.hid          := LEFT.hid,
                                    SELF.product_mask := AccountMonitoring.Constants.pm_email,
                                    SELF.timestamp    := '',
                                    SELF.hash_value   := HASH64(LEFT.did, LEFT.clean_email),
                                    SELF:=LEFT));

  // Roll up the hashes for all records for a particular pid/rid; and return.
  result_rolled_hashes := ROLLUP(SORT(
                              DISTRIBUTE(email_unrolled_hashes, HASH64(pid,rid,hid)),
                               pid,rid,hid,RECORD,LOCAL),
                              TRANSFORM(AccountMonitoring.layouts.history,
                                SELF.hash_value := LEFT.hash_value + RIGHT.hash_value,
                                SELF := LEFT),
                              pid,rid,LOCAL);
    
  RETURN result_rolled_hashes;

END;		



