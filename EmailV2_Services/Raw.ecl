﻿IMPORT $, dx_Email, DidVille, AutokeyB2_batch, Autokey_batch, Data_Services;

EXPORT Raw := MODULE


  EXPORT getIdsByLexID(DATASET($.Layouts.batch_in_rec) ds_batch_in, UNSIGNED1 data_environment=Data_Services.data_env.iNonFCRA) := FUNCTION
    
    ids_from_did := PROJECT(dx_Email.Ids.mac_byLexID(ds_batch_in, DID, data_environment), 
                            TRANSFORM($.Layouts.email_ids_rec,
                              SELF.acctno        := LEFT.acctno;
                              SELF.seq           := LEFT.seq;
                              SELF.email_rec_key := LEFT.email_rec_key,                                
                              SELF := LEFT,
                              SELF := []));
    RETURN ids_from_did;                                           
  END;          

  EXPORT getIdsByInputEmail(DATASET($.Layouts.batch_in_rec) ds_batch_in) := FUNCTION
    
    ds_batch := PROJECT(ds_batch_in,TRANSFORM($.Layouts.batch_in_rec, SELF.email := TRIM(LEFT.email_username)+'@'+LEFT.email_domain, SELF:=LEFT)); 
    email_lookup := PROJECT(dx_Email.Ids.mac_byEmail(ds_batch, email),
                            TRANSFORM($.Layouts.email_ids_rec,
                              SELF.acctno        := LEFT.acctno;
                              SELF.seq           := LEFT.seq;
                              SELF.email_rec_key := LEFT.email_rec_key,                                
                              SELF := LEFT,
                              SELF := []));
    RETURN email_lookup;                                           
  END;  
  
  
  EXPORT getEmailPayload(DATASET($.Layouts.email_ids_rec) ids_batch_in, UNSIGNED1 data_environment=Data_Services.data_env.iNonFCRA) := FUNCTION
    
    email_payload := PROJECT(dx_Email.Get.mac_payload(ids_batch_in, email_rec_key, data_environment), 
                            $.Transforms.addRawPayload(LEFT,LEFT._email_data));
    RETURN email_payload;                                           
  END;  
  
  EXPORT getIdsByAutokeys(DATASET($.Layouts.batch_in_rec) ds_batch_in) := FUNCTION

    ds_batch_prprd := PROJECT(ds_batch_in, TRANSFORM(Autokey_batch.Layouts.rec_inBatchMaster, SELF:=LEFT, SELF:=[]));
  
    autokey_file  := dx_Email.Constants('').ak_qa_keyname;
    ak_skipSet    := dx_Email.Constants('').ak_skipSet;

    autokey_lookup := AutokeyB2_batch.Get_IDs_Batch(ds_batch_prprd, autokey_file, ak_skipset, 
                                          workHard := TRUE, useAllLookups:= TRUE); 
                                            
    autokey_ids := JOIN(autokey_lookup(ID > 0), ds_batch_in,
                        LEFT.acctno = RIGHT.acctno,
                        TRANSFORM($.Layouts.email_ids_rec,
                              SELF.acctno        := LEFT.acctno;
                              SELF.email_rec_key := LEFT.ID,                                
                              SELF.subject_lexid := RIGHT.subject_lexid, // keeping subject_lexid for matching logic later
                              SELF := LEFT,
                              SELF := []));
    RETURN autokey_ids;                                           
  END;

  DeepDiveForIds(DATASET($.Layouts.batch_in_rec) ds_batch_in) := FUNCTION
  
    ds_for_dids_in := PROJECT(ds_batch_in(did = 0), $.Transforms.toMacDidAppend(LEFT));
    BOOLEAN useonlybestdid := FALSE;
    
    DidVille.MAC_DidAppend(ds_for_dids_in, ds_dids_out, useonlybestdid, ''); 
    
    ds_batch_with_did := JOIN(DEDUP(SORT(ds_dids_out(did>0), seq, did, -score), seq, did), ds_batch_in,
                              LEFT.seq = (UNSIGNED) RIGHT.acctno,
                              TRANSFORM($.Layouts.batch_in_rec, 
                                        SELF.acctno := (STRING) LEFT.seq,
                                        SELF.DID := LEFT.did,
                                        SELF.isdeepdive := TRUE,
                                        SELF.subject_lexid := RIGHT.subject_lexid,  // keeping subject_lexid for matching logic later
                                        SELF := LEFT));


    RETURN ds_batch_with_did;
  END;

  EXPORT getEmailRawData(DATASET($.Layouts.batch_in_rec) batch_in,
                         $.IParams.EmailParams in_mod,
                         STRING5 search_by,
                         UNSIGNED1 data_environment=Data_Services.data_env.iNonFCRA) := FUNCTION

    BOOLEAN isFCRA := data_environment=Data_Services.data_env.iFCRA;
    
    search_by_email := IF(~isFCRA, getIdsByInputEmail(batch_in));
 
    search_by_lexid := getIdsByLexID(batch_in(did>0),data_environment);
    
    // in case of search by PII we will use input Did or Did coming as deep dive
    deepdive_dids := IF(~isFCRA AND in_mod.RunDeepDive AND ~in_mod.RequireLexidMatch, DeepDiveForIds(batch_in(did=0)));
    batch_did_ids := getIdsByLexID(batch_in(did>0) + deepdive_dids);
    
    batch_autokey_ids := IF(~isFCRA, getIdsByAutokeys(batch_in));
    search_by_input_pii := DEDUP(SORT(batch_did_ids + batch_autokey_ids,acctno,seq,email_rec_key,isdeepdive),acctno,seq,email_rec_key);
   
    id_recs := CASE(search_by,
                 $.Constants.SearchBy.ByEmail => search_by_email,
                 $.Constants.SearchBy.ByLexid => search_by_lexid,
                 $.Constants.SearchBy.ByPII   => search_by_input_pii,
                 DATASET([], $.Layouts.email_ids_rec) );
                 
    payload_recs := getEmailPayload(id_recs, data_environment); 
    
    //output(search_by_email, named('search_by_email'),EXTEND);
    //output(search_by_lexid, named('search_by_lexid'),EXTEND);
    //output(deepdive_dids, named('deepdive_dids'),EXTEND);
    //output(batch_in, named('batch_in_raw'),EXTEND);
    //output(batch_did_ids, named('batch_did_ids'),EXTEND);
    //output(batch_autokey_ids, named('batch_autokey_ids'),EXTEND);
    //output(search_by_input_pii, named('search_by_input_pii'),EXTEND);
    
    RETURN payload_recs;
  END;
  

END;
