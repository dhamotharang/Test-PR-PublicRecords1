IMPORT $, Address, doxie, iesp, PhoneFinder_Services;

EXPORT parser_iconectiv_elep := MODULE

  // Common temp record layouts used by the functions below
  // Next 1 used in Clean/parse request functions
  SHARED rec_request_wseq := RECORD
    UNSIGNED4 request_seq; // needed for joining later
    PhoneFinder_Services.Layouts.IconectivElepRequest_ext;
  END;

  // Next 6 used in Clean/parse response functions
  SHARED rec_ServiceProviderInfo_wseqs := RECORD
    UNSIGNED4 response_seq       :=0; // needed for joining later
    UNSIGNED4 portingrecord_seq  :=0; // needed for joining later
    UNSIGNED4 portinghistory_seq :=0; // needed for joining later
    UNSIGNED4 spi_seq := 0;
    iesp.iconectiv_elep.t_IconectivElepServiceProviderInfo;
  END;
 
  SHARED rec_PortingHistoryInfo_wseq := RECORD
    UNSIGNED4 response_seq       :=0; // needed for joining later
    UNSIGNED4 portingrecord_seq  :=0; // needed for joining later
    UNSIGNED4 portinghistory_seq :=0; // needed for joining later
    iesp.iconectiv_elep.t_IconectivElepPortingInfoRecord;
  END;

  SHARED rec_portingrecord_wseq := RECORD
    UNSIGNED4 response_seq      :=0; // needed for joining later
    UNSIGNED4 portingrecord_seq :=0; // needed for joining later
    // v--- next 4 copied from iesp.iconectiv_elep.t_IconectivElepPortingRecord with dataset record name changed to use the one above
    STRING10 PhoneNumber {xpath('PhoneNumber')};
    STRING QueryStatus {xpath('QueryStatus')};
    iesp.iconectiv_elep.t_IconectivElepPortingInfoRecord PortingInfo {xpath('PortingInfo')};
    DATASET(rec_PortingHistoryInfo_wseq) PortingHistory {xpath('PortingHistory/PortingHistoryInfo'), 
                                                         MAXCOUNT(iesp.Constants.Phone_Finder.MaxIcElepGwHistory)};
  END;

  SHARED rec_t_IconectivElepHistoryResponse := record
    // v--- next 3 copied from iesp.iconectiv_elep.t_IconectivElepHistoryResponse with dataset record name changed to use the one above
    string ResponseCode {xpath('ResponseCode')};
    string ResponseMessage {xpath('ResponseMessage')};
    DATASET(rec_portingrecord_wseq) PortingRecords {xpath('PortingRecords/PortingRecord'), 
                                                    MAXCOUNT(iesp.Constants.Phone_Finder.MaxIcElepGwPortingRecs)};
  END;

  SHARED rec_t_IconectivElepResponse := record
    // v--- next 2 copied from iesp.iconectiv_elep.t_IconectivElepResponse with dataset record name changed to use the one above
    iesp.share.t_ResponseHeader _Header {xpath('Header')};
    rec_t_IconectivElepHistoryResponse ElepHistoryResponse {xpath('ElepHistoryResponse')};
  END;

  SHARED rec_t_response := RECORD
    UNSIGNED4 response_seq :=0; // needed for joining later
    rec_t_IconectivElepResponse response {xpath('response')};
  END;


  // ********************************************************************************************************
  // ********************************************************************************************************
  EXPORT fn_parseRequest(DATASET(rec_request_wseq) ds_in_request) := FUNCTION

    ds_out_request := PROJECT(ds_in_request,
      TRANSFORM($.Layouts.common_optout,
        SELF.seq            := LEFT.request_seq; 
        SELF.did            := LEFT.did; // use query input or PII appended DID, even though the gateway does not accept LexID as input
        SELF.global_sid     := $.Constants.IconectivElep.GLOBAL_SID;
        SELF.transaction_id := LEFT.GatewayParams.TxnTransactionId;
        // other fields on common_optout layout don't matter so they can be nulled out
        SELF := []
      ));
 
    // Outputs for debugging.  Un-comment them as needed! "EXTEND" option may be needed if testing the pf batch service 
    //OUTPUT(ds_in_request,  named('ds_in_request'));
    //OUTPUT(ds_out_request, named('ds_out_request')); 

    RETURN ds_out_request;
  END;

  
  // ********************************************************************************************************
  // ********************************************************************************************************
  EXPORT fn_CleanRequest(DATASET(PhoneFinder_Services.Layouts.IconectivElepRequest_ext) ds_request_in, 
                         doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

    // Add a sequence# to each request dataset record to be used for joining on later.
    rec_request_wseq tf_add_req_seq(PhoneFinder_Services.Layouts.IconectivElepRequest_ext L, 
                                    INTEGER C) := TRANSFORM
      SELF.request_seq := C;
      SELF             := L;
    END;

    ds_req_in_wseq := PROJECT(ds_request_in, tf_add_req_seq(LEFT,COUNTER));

    // Call function to parse the applicable request data
    ds_req_parsed := fn_parseRequest(ds_req_in_wseq);

    // Use macro to check for LexID/did on suppress opt_out key
    $.mac_flag_optout(ds_req_parsed, ds_req_did_optout, mod_access);

    // Skip input record(s) if LexId/did is suppressed/opted out
    ds_req_clean := JOIN(ds_req_in_wseq, ds_req_did_optout(~is_suppressed), 
                           LEFT.request_seq = RIGHT.seq,
                         TRANSFORM(PhoneFinder_Services.Layouts.IconectivElepRequest_ext,
                           SELF := LEFT),
                         KEEP(1), 
                         LIMIT(0));

    // Outputs for debugging.  Un-comment them as needed!
    //OUTPUT(ds_request_in,           named('dxpice_ds_request_in'));
    //OUTPUT(ds_req_in_wseq,          named('dxpice_ds_req_in_wseq'));
    //OUTPUT(ds_req_parsed,           named('dxpice_ds_req_parsed'));
    //OUTPUT(ds_req_did_optout,       named('dxpice_ds_req_did_optout'));
    //OUTPUT(ds_req_clean,            named('dxpice_ds_req_clean'));

    RETURN ds_req_clean;

  END; //end of fn_CleanRequest


  // ********************************************************************************************************
  // ********************************************************************************************************
  EXPORT fn_parseResponse(DATASET(rec_ServiceProviderInfo_wseqs) ds_parse_resp_in) := FUNCTION

    $.layouts.common_optout tf_parse_name_phone (rec_ServiceProviderInfo_wseqs L) := TRANSFORM

      SELF.seq            := L.response_seq;       // for matching on after LexId/did is appended down in fn_Clean_Response
      SELF.section_id     := L.portingrecord_seq;  // for matching on after LexId/did is appended down in fn_Clean_Response
      // v--- also use some existing unused $.Layouts.common_optout fields for 2 additional seq#s needed
      SELF.record_sid     := L.portinghistory_seq; // for matching on after LexId/did is appended down in fn_Clean_Response
      SELF.transaction_id := (STRING) L.spi_seq;   // for matching on after LexId/did is appended down in fn_Clean_Response

      // use standard name cleaner to parse the (full) ContactName into standard name parts
      clean_name   := Address.CleanPersonFML73_fields(L.ContactName);
      SELF.title   := clean_name.title;
      SELF.fname   := clean_name.fname;
      SELF.mname   := clean_name.mname;
      SELF.lname   := clean_name.lname;  
      SELF.suffix  := clean_name.name_suffix;
      SELF.phone10 := L.ContactPhoneNumber;

      SELF.Global_Sid := $.Constants.IconectivElep.GLOBAL_SID;
      SELF            := []; // null all other fields not already assigned (address, email, ssn, dob, did, record_sid, etc.)
    END;

    // Before parse/build opt_out records, filter out any passed in records with an empty ContactPhoneNumber, 
    // since won't be able to append a LexId without it.
    ds_parse_resp_out := PROJECT(ds_parse_resp_in(ContactPhoneNumber!=''),tf_parse_name_phone(LEFT));
    
    // Outputs for debugging.  Un-comment them as needed! "EXTEND" option may be needed if testing the pf batch service
    //OUTPUT(ds_parse_resp_in,  named('dxpice_ds_parse_resp_in'));
    //OUTPUT(ds_parse_resp_out, named('dxpice_ds_parse_resp_out'));

    RETURN ds_parse_resp_out;
    
  END; //end of fn_parseResponse


  // ********************************************************************************************************
  // ********************************************************************************************************
  EXPORT fn_CleanResponse(DATASET(iesp.iconectiv_elep.t_IconectivElepResponseEx) ds_response_in,
                          doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END) := FUNCTION

    // Add a response_seq, portingrecord_seq and a portinghistory_seq # to:
    //   1. each ds_response_in 'response' record
    //   2. each 'response' record's ElepHistoryResponse.PortingRecords' child dataset records
    //   3. each 'ElepHistoryResponse.PortingRecords[n].PortingHistory' child dataset records
    //   all to be used for joining on later.
    rec_PortingHistoryInfo_wseq tf_add_porthist_seq(iesp.iconectiv_elep.t_IconectivElepPortingInfoRecord L, 
                                                    INTEGER resp_seq, 
                                                    INTEGER portrec_seq, 
                                                    INTEGER in_counter) := TRANSFORM
      SELF.response_seq       := resp_seq;
      SELF.portingrecord_seq  := portrec_seq;
      SELF.portinghistory_seq := in_counter;
      SELF                    := L;
    END;

    rec_portingrecord_wseq tf_add_portrecs_seq(iesp.iconectiv_elep.t_IconectivElepPortingRecord L, 
                                               INTEGER resp_seq, 
                                               INTEGER in_counter) := TRANSFORM
      SELF.response_seq      := resp_seq;
      SELF.portingrecord_seq := in_counter;
      SELF.PortingHistory    := CHOOSEN(PROJECT(L.PortingHistory, tf_add_porthist_seq(LEFT, resp_seq, in_counter, COUNTER)),
                                        PhoneFinder_Services.Constants.MaxIconectivElepPortHist);
      SELF                   := L;
    END;

    rec_t_response tf_add_seqs(iesp.iconectiv_elep.t_IconectivElepResponseEx L, 
                               INTEGER in_counter) := TRANSFORM
      SELF.response_seq := in_counter;
      SELF.response.ElepHistoryResponse.PortingRecords := PROJECT(L.response.ElepHistoryResponse.PortingRecords, 
                                                                  tf_add_portrecs_seq(LEFT, in_counter, COUNTER));
      SELF                                             := L;
    END;

    ds_resp_in_wseqs := PROJECT(ds_response_in, tf_add_seqs(LEFT,COUNTER));

    // Since need the individual child datset records for use later, do all of the 'normalizing' here to get 
    // all of the PortingHistory child dataset records on all of the PortingRecords child datset records.
    // Then pass the resulting lowest level normalized ds records into the parse function.

    // First normalize all <PortingRecords> child datset records on every response.ElepHistoryResponse, 
    // using a transform to save off both: 
    //   1. the 'PortingInfo'(current) data (NOTE: TBD, might not be needed since we are not using this "current" data from 
    //      the gateway response in the PublicRecords.PhoneFinder_Services.GetPhonesPortedMetadata returned output)
    //   and 
    //   2. the 'PortingHistory' child dataset to then be normalized below
    rec_PortingRecord_wseq tf_norm_PortingRecords(rec_t_response L, 
                                                  INTEGER norm_count) := TRANSFORM
      SELF := L.response.ElepHistoryResponse.PortingRecords[norm_count];
    END;

    ds_resp_in_portrec_normed := NORMALIZE(ds_resp_in_wseqs, 
                                           COUNT(LEFT.response.ElepHistoryResponse.PortingRecords),
                                           tf_norm_PortingRecords(LEFT, COUNTER));

    // Next normalize all 'PortingHistory' child datset records on each response.ElepHistoryResponse.PortingRecords
    // child dataset record, using a transform to save off the 'PortingInfo' record data.
    rec_PortingHistoryInfo_wseq tf_norm_PortingHistory(rec_portingrecord_wseq L,  
                                                       INTEGER norm_count) := TRANSFORM
      SELF := L.PortingHistory[norm_count];
    END;
    
    ds_resp_in_porthist_normed := NORMALIZE(ds_resp_in_portrec_normed, 
                                            COUNT(LEFT.PortingHistory),
                                            tf_norm_PortingHistory(LEFT, COUNTER));

    // Next normalize a 3rd time for each of the 3 ServiceProvider, AltServiceProvider & LastAltServiceProvider parts
    // on each PortingInfo Record.
    rec_ServiceProviderInfo_wseqs tf_norm_PortingInfo(rec_PortingHistoryInfo_wseq L, 
                                                      INTEGER norm_count) := TRANSFORM
      SELF.spi_seq := norm_count;
      SELF.ServiceProviderId := CHOOSE(norm_count, L.ServiceProvider.ServiceProviderId,         // 1st time grab this one
                                                   L.AltServiceProvider.ServiceProviderId,      // 2nd time grab this one
                                                   L.LastAltServiceProvider.ServiceProviderId); // 3rd time grab this one
      SELF.CompanyName       := CHOOSE(norm_count, L.ServiceProvider.CompanyName,         // 1st time grab this one
                                                   L.AltServiceProvider.CompanyName,      // 2nd time grab this one
                                                   L.LastAltServiceProvider.CompanyName); // 3rd time grab this one
      SELF.CarrierType       := ''; // don't need to use this field, so just null it out
      SELF.ContactName       := CHOOSE(norm_count, L.ServiceProvider.ContactName,         // 1st time grab this one
                                                   L.AltServiceProvider.ContactName,      // 2nd time grab this one
                                                   L.LastAltServiceProvider.ContactName); // 3rd time grab this one
     SELF.ContactPhoneNumber := CHOOSE(norm_count, L.ServiceProvider.ContactPhoneNumber,         // 1st time grab this one
                                                   L.AltServiceProvider.ContactPhoneNumber,      // 2nd time grab this one
                                                   L.LastAltServiceProvider.ContactPhoneNumber); // 3rd time grab this one
     SELF         := L; // stores the response_seq, portingrecord_seq & portinghistory_seq fields
    END;

    ds_resp_in_portinfo_normed := NORMALIZE(ds_resp_in_porthist_normed, 
                                            3, // normalize 3 times, once for each ServProv, AltServProv & Last Alt ServProv
                                            tf_norm_PortingInfo(LEFT, COUNTER));

    // Next parse the sequenced 'PortingHistory' child dataset normalized PortingInfo records to parse/clean the 
    // ContactName and use it and the ContactPhoneNumber for LexId appending below.
    ds_resp_in_parsed := fn_parseResponse(ds_resp_in_portinfo_normed);

    // Use a macro to try to assign a did/LexID to each normalized/parsed record (contact name & contact phone pair)
    $.mac_append_did(ds_resp_in_parsed, ds_resp_did_append, mod_access, $.Constants.DID_APPEND_LOCAL);

    // Check ds of appended dids for suppress opt_out
    $.mac_flag_optout(ds_resp_did_append, ds_resp_did_optout, mod_access);

    // Next join the normalized PortingHistory 'PortingInfo' recs to the ds with opted out is_suppressed flag set to true,
    // to blank out the 2 appropriate fields if the did was found to be suppressed.
    ds_resp_in_portinfo_normed_woptouts := JOIN(ds_resp_in_portinfo_normed,
                                                ds_resp_did_optout,
                                                  LEFT.response_seq       = RIGHT.seq        AND
                                                  LEFT.portingrecord_seq  = RIGHT.section_id AND
                                                  LEFT.portinghistory_seq = RIGHT.record_sid AND
                                                  LEFT.spi_seq            = (UNSIGNED4) RIGHT.transaction_id,
                                                TRANSFORM(rec_ServiceProviderInfo_wseqs,
                                                  // When opted out/is_suppressed=true, 2 Contact*** fields should be blanked out
                                                  SELF.ContactName        := IF(RIGHT.is_suppressed, '', LEFT.ContactName),
                                                  SELF.ContactPhoneNumber := IF(RIGHT.is_suppressed, '', LEFT.ContactPhoneNumber),
                                                  SELF := LEFT, // rest of fields from left
                                                ),
                                                KEEP(1)
                                               );

    // Denorm the resulting ds with optouts applied above to put each of the 3 sets of data (sp, alt sp & last alt sp) 
    // on each PortingHistory child dataset (PortingInfo) record back all on 1 record.
    rec_PortingHistoryInfo_wseq tf_denorm_PortingInfo(rec_PortingHistoryInfo_wseq L, 
                                                      rec_ServiceProviderInfo_wseqs R,
                                                      INTEGER denorm_count) := TRANSFORM
      SELF.ServiceProvider.ServiceProviderId         := IF (denorm_count=1, R.ServiceProviderId, L.ServiceProvider.ServiceProviderId), // 1st time grab these
      SELF.ServiceProvider.CompanyName               := IF (denorm_count=1, R.CompanyName, L.ServiceProvider.CompanyName),
      SELF.ServiceProvider.ContactName               := IF (denorm_count=1, R.ContactName, L.ServiceProvider.Contactname),
      SELF.ServiceProvider.ContactPhoneNumber        := IF (denorm_count=1, R.ContactPhoneNumber, L.ServiceProvider.ContactPhoneNumber), 
      SELF.AltServiceProvider.ServiceProviderId      := IF (denorm_count=2, R.ServiceProviderId, L.AltServiceProvider.ServiceProviderId), // 2nd time grab these
      SELF.AltServiceProvider.CompanyName            := IF (denorm_count=2, R.CompanyName, L.AltServiceProvider.CompanyName),
      SELF.AltServiceProvider.ContactName            := IF (denorm_count=2, R.ContactName, L.AltServiceProvider.Contactname),
      SELF.AltServiceProvider.ContactPhoneNumber     := IF (denorm_count=2, R.ContactPhoneNumber, L.AltServiceProvider.ContactPhoneNumber),
      SELF.LastAltServiceProvider.ServiceProviderId  := IF (denorm_count=3, R.ServiceProviderId, L.LastAltServiceProvider.ServiceProviderId); // 3rd time grab these
      SELF.LastAltServiceProvider.CompanyName        := IF (denorm_count=3, R.CompanyName, L.LastAltServiceProvider.CompanyName),
      SELF.LastAltServiceProvider.ContactName        := IF (denorm_count=3, R.ContactName, L.LastAltServiceProvider.Contactname),
      SELF.LastAltServiceProvider.ContactPhoneNumber := IF (denorm_count=3, R.ContactPhoneNumber, L.LastAltServiceProvider.ContactPhoneNumber),
      SELF := L; // stores the rest of the Left ds fields
    END;

    ds_resp_in_porthist_denormed := DENORMALIZE(ds_resp_in_porthist_normed,
                                                ds_resp_in_portinfo_normed_woptouts,
                                                  LEFT.response_seq       = RIGHT.response_seq      AND
                                                  LEFT.portingrecord_seq  = RIGHT.portingrecord_seq AND
                                                  LEFT.portinghistory_seq = RIGHT.portinghistory_seq,
                                                tf_denorm_PortingInfo(LEFT,RIGHT,COUNTER)
                                               );

    // Finally do a join to put the gw response all back together using 'PortingHistory' matching records from the 
    // porthist_denormed dataset above (with opt outs applied) in place of the original 'PortingHistory' child dataset 
    // and stripping off all of the temp ***_seq fields.
    iesp.iconectiv_elep.t_IconectivElepPortingRecord tf_portingrecords_final(rec_portingrecord_wseq L) := TRANSFORM 
      
      SELF.PortingHistory := CHOOSEN(PROJECT(ds_resp_in_porthist_denormed(response_seq      = L.response_seq      AND
                                                                          portingrecord_seq = L.portingrecord_seq),
                                             TRANSFORM(iesp.iconectiv_elep.t_IconectivElepPortingInfoRecord,
                                                SELF := LEFT, 
                                            )),
                                     PhoneFinder_Services.Constants.MaxIconectivElepPortHist),
      SELF := L,
    END;

   ds_resp_clean := JOIN(ds_resp_in_wseqs, ds_resp_in_porthist_denormed,
                             LEFT.response_seq = RIGHT.response_seq,
                           TRANSFORM(iesp.iconectiv_elep.t_IconectivElepResponseEx, // use orig layout without the temp seq#s
                             SELF.response.ElepHistoryResponse.PortingRecords := 
                                                                    PROJECT(LEFT.response.ElepHistoryResponse.PortingRecords, 
                                                                            tf_portingrecords_final(LEFT)),
                              SELF := LEFT
                           ),
                           LEFT OUTER,
                           KEEP(1)
                          );

    // Outputs for debugging.  Un-comment them as needed!
    //OUTPUT(ds_response_in,             NAMED('dxpice_ds_response_in'));
    //OUTPUT(ds_resp_in_wseqs,           NAMED('dxpice_ds_resp_in_wseqs'));
    //OUTPUT(ds_resp_in_portrec_normed,  NAMED('dxpice_ds_resp_in_portrec_normed'));
    //OUTPUT(ds_resp_in_porthist_normed, NAMED('dxpice_ds_resp_in_porthist_normed')); 
    //OUTPUT(ds_resp_in_portinfo_normed, NAMED('dxpice_ds_resp_in_portinfo_normed')); 
    //OUTPUT(ds_resp_in_parsed,          NAMED('dxpice_ds_resp_in_parsed'));
    //OUTPUT(ds_resp_did_append,         NAMED('dxpice_ds_resp_did_append'));
    //OUTPUT(ds_resp_did_optout,         NAMED('dxpice_ds_resp_did_optout'));
    //OUTPUT(ds_resp_in_portinfo_normed_woptouts, NAMED('dxpice_ds_resp_in_portinfo_normed_woptouts'));
    //OUTPUT(ds_resp_in_porthist_denormed,        NAMED('dxpice_ds_resp_in_porthist_denormed'));
    //OUTPUT(ds_resp_clean,               NAMED('dxpice_ds_resp_clean'));

    RETURN ds_resp_clean;

  END; // end of fn_CleanResponse

END; //end of module
